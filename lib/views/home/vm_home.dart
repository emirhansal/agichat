import 'package:agichat/base/base_view_model.dart';
import 'package:agichat/constants/app_config.dart';
import 'package:agichat/enums/enum_app.dart';
import 'package:agichat/service/service_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class VmHome extends ViewModelBase {
  final ServiceRoute serviceRoute;

  VmHome(this.serviceRoute) {
    init();
    history = [
      {"role": "system", "content": systemContent},
    ];
  }

  final TextEditingController textController = TextEditingController();
  final FocusNode textFocusNode = FocusNode();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> chatHistory = [];
  late String chatId;

  String systemContent =
      'Esin is a passionate designer specializing in branding. With a keen eye for detail and a love for innovation, she crafts visually stunning designs that tell compelling stories. And you have to acting like Esin.';

  List<Map<String, String>> history = [
    {
      "role": "system",
      "content":
          'Esin is a passionate designer specializing in branding. With a keen eye for detail and a love for innovation, she crafts visually stunning designs that tell compelling stories. And you have to acting like Esin.'
    },
  ];

  List<Map<String, String>> resetHistory = [
    {
      "role": "system",
      "content":
          'Esin is a passionate designer specializing in branding. With a keen eye for detail and a love for innovation, she crafts visually stunning designs that tell compelling stories. And you have to acting like Esin.'
    },
  ];

  List<Map<String, dynamic>> messages = [];

  @override
  void init() {
    setActivityState(ActivityState.isLoading);
    fetchChatHistory();
    textController.clear();
    textController.addListener(() {
      notifyListeners();
    });
    chatId = Uuid().v4();
    setActivityState(ActivityState.isLoaded);
  }

  Future<void> fetchChatHistory() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection('chats').get();

      chatHistory = await Future.wait(querySnapshot.docs.map((doc) async {
        DocumentSnapshot chatDoc =
            await firestore.collection('chats').doc(doc.id).get();

        return {
          'id': doc.id,
          'timestamp':
              chatDoc.get('created_at') ?? DateTime.now().toIso8601String(),
          'messages': chatDoc.get('messages').first['message'],
        };
      }).toList());

      chatHistory.sort((a, b) {
        DateTime dateA = DateTime.parse(a['timestamp']);
        DateTime dateB = DateTime.parse(b['timestamp']);
        return dateB.compareTo(dateA);
      });

      DateFormat dateFormat = DateFormat('hh:mm dd.MM.yy');
      chatHistory = chatHistory.map((chat) {
        DateTime parsedDate = DateTime.parse(chat['timestamp']);
        return {
          'id': chat['id'],
          'timestamp': dateFormat.format(parsedDate),
          'messages': chat['messages'],
        };
      }).toList();

      print('Fetched ${chatHistory.length} chats: $chatHistory');
      notifyListeners();
    } catch (e) {
      print('Error fetching chat history: $e');
    }
  }

  Future<void> sendMessage() async {
    String userMessage = textController.text.trim();
    if (userMessage.isEmpty) return;

    messages.add({
      "id": DateTime.now().millisecondsSinceEpoch,
      "message": userMessage,
      "isSentByMe": true,
      "timestamp": DateTime.now().toString(),
    });
    history.add({"role": "user", "content": userMessage});

    textController.clear();
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "gpt-4",
          "messages": history,
          "temperature": 0.3,
        }),
      );

      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        final data = jsonDecode(decodedResponse);
        String assistantReply = data['choices'][0]['message']['content'].trim();

        messages.add({
          "id": DateTime.now().millisecondsSinceEpoch,
          "message": assistantReply,
          "isSentByMe": false,
          "timestamp": DateTime.now().toString(),
        });
        history.add({"role": "assistant", "content": assistantReply});

        notifyListeners();
      } else {
        print('API Error: ${response.body}');
        messages.add({
          "id": DateTime.now().millisecondsSinceEpoch,
          "message": "Some error occurred. Please try again.",
          "isSentByMe": false,
          "timestamp": DateTime.now().toString(),
        });
        notifyListeners();
      }
    } catch (e) {
      print('Hata: $e');
      messages.add({
        "id": DateTime.now().millisecondsSinceEpoch,
        "message":
            "Connection error. Please check your internet connection and try again.",
        "isSentByMe": false,
        "timestamp": DateTime.now().toString(),
      });
      notifyListeners();
    }

    await saveMessagesToFirebase();
  }

  Future<void> saveMessagesToFirebase() async {
    try {
      final chatCollection = firestore.collection('chats');

      final chatDoc = chatCollection.doc(chatId);

      final snapshot = await chatDoc.get();

      if (snapshot.exists) {
        final currentData = snapshot.data();
        final currentMessages =
            List<Map<String, dynamic>>.from(currentData?['messages'] ?? []);

        for (var message in messages) {
          if (!currentMessages.any((m) => m['id'] == message['id'])) {
            currentMessages.add(message);
          }
        }

        await chatDoc.update({
          'messages': currentMessages,
          'updated_at': DateTime.now().toIso8601String(),
        });
      } else {
        await chatDoc.set({
          'messages': messages,
          'created_at': DateTime.now().toIso8601String(),
        });
      }
      print('Messages updated in Firebase successfully.');
    } catch (e) {
      print('Error saving messages to Firebase: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getMessagesFromFirebase() async {
    try {
      final chatDoc = await firestore.collection('chats').doc(chatId).get();

      if (chatDoc.exists) {
        final data = chatDoc.data();
        return List<Map<String, dynamic>>.from(data?['messages'] ?? []);
      } else {
        print('Chat with chatId $chatId does not exist.');
        return [];
      }
    } catch (e) {
      print('Error fetching messages from Firebase: $e');
      return [];
    }
  }

  Future<void> loadChat(String chatId) async {
    setActivityState(ActivityState.isLoading);
    try {
      final chatDoc = await firestore.collection('chats').doc(chatId).get();

      if (chatDoc.exists) {
        messages.clear();
        this.chatId = chatId;
        List<dynamic> fetchedMessages = chatDoc.data()?['messages'] ?? [];
        messages = fetchedMessages
            .map((msg) => {
                  'message': msg['message'],
                  'isSentByMe': msg['isSentByMe'],
                  'timestamp': msg['timestamp']
                })
            .toList();

        messages.sort((a, b) => (a['timestamp'] as Timestamp)
            .compareTo(b['timestamp'] as Timestamp));

        notifyListeners();
        if (messages.isNotEmpty) {
          textController.text = messages.last['message'];
        }

        print('Loaded chat: $chatId with ${messages.length} messages');
      } else {
        print('Chat document not found: $chatId');
      }
    } catch (e) {
      print('Error loading chat: $e');
    }
    setActivityState(ActivityState.isLoaded);
  }

  void createNewChat() {
    chatId = Uuid().v4();
    messages.clear();
    history.clear();
    history = resetHistory;
    history.add({
      "role": "system",
      "content": systemContent,
    });
    fetchChatHistory();
    notifyListeners();
  }
}
