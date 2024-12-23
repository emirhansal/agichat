import 'package:agichat/resources/_r.dart';
import 'package:agichat/widgets/widgets_text.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSentByMe;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isSentByMe,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 44, right: 30, top: 35),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isSentByMe)
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: ClipRRect(
                  child: Image.asset(
                    'assets/images/user.png',
                    width: 32,
                    height: 32,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            if (!isSentByMe) const SizedBox(height: 5.0),
            Flexible(
              child: Container(
                padding: !isSentByMe
                    ? const EdgeInsets.only(
                        right: 12.0, top: 12.0, bottom: 12.0)
                    : const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: isSentByMe ? R.color.white : R.color.transparent,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: TextBasic(
                  text: message,
                  color: R.color.black,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
