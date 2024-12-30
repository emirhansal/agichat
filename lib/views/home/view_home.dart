import 'package:agichat/base/base_view.dart';
import 'package:agichat/resources/_r.dart';
import 'package:agichat/service/ui_brightness_style.dart';
import 'package:agichat/views/home/vm_home.dart';
import 'package:agichat/widgets/chat_bubble.dart';
import 'package:agichat/widgets/info_card_widget.dart';
import 'package:agichat/widgets/widget_textfield.dart';
import 'package:agichat/widgets/widgets_text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class ViewHome extends StatefulWidget {
  const ViewHome({super.key});

  @override
  State<ViewHome> createState() => ViewHomeState();
}

class ViewHomeState extends WidgetBaseStatefull<ViewHome, VmHome> {
  @override
  SystemUiOverlayStyle systemBarBrightness() =>
      UIBrightnessStyle.dark(systemNavigationBarColor: R.color.black);

  @override
  VmHome createViewModel(BuildContext context) => VmHome(router(context));

  @override
  Widget buildWidgetForTablet(BuildContext context, VmHome viewModel) {
    return Scaffold(
      body: Container(),
    );
  }

  @override
  Widget buildWidget(BuildContext context, VmHome viewModel) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            R.color.appTextColor,
            R.color.white,
            R.color.white,
            R.color.appTextColor2,
          ],
          stops: const [0.0, 0.4, 0.5, 1.0],
        ),
      ),
      child: Scaffold(
        key: viewModel.scaffoldKey,
        backgroundColor: Colors.transparent,
        drawer: _buildDrawer(context, viewModel),
        appBar: _getHeader(context, viewModel),
        body: _getBody(context, viewModel),
      ),
    );
  }

  PreferredSizeWidget _getHeader(BuildContext context, VmHome viewModel) {
    return AppBar(
      backgroundColor: R.color.white.withOpacity(0.6),
      leading: Builder(
        builder: (BuildContext builderContext) {
          return IconButton(
            icon: Icon(Icons.keyboard_arrow_left, color: R.color.appTextColor),
            onPressed: () {
              viewModel.scaffoldKey.currentState?.openDrawer();
            },
          );
        },
      ),
      title: TextBasic(
        text: 'Esin Erdem',
        color: R.color.appTextColor,
        fontSize: 16.0,
        fontFamily: R.fonts.displayBold,
      ),
      centerTitle: true,
      actions: [
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              R.drawable.svg.iconNewChat,
              width: 20.0,
            ),
          ),
          onTap: () => viewModel.createNewChat(),
        )
      ],
      elevation: 0,
    );
  }

  final ScrollController _controller = ScrollController();

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  bool _isScrolledToBottom = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      _isScrolledToBottom = _controller.position.pixels >=
          _controller.position.maxScrollExtent - 100;
    });
  }

  Widget _getBody(BuildContext context, VmHome viewModel) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
            bottom: 80,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: viewModel.messages.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const WidgetInfoCard();
                      }
                      final message = viewModel.messages[index - 1];
                      return ChatBubble(
                        message: message['message'],
                        isSentByMe: message['isSentByMe'],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          if (!_isScrolledToBottom)
            Positioned(
              left: 0,
              right: 0,
              bottom: 90,
              child: Center(
                child: FloatingActionButton.small(
                  onPressed: _scrollDown,
                  backgroundColor: R.color.appBackgroundColor2,
                  child: Icon(
                    Icons.arrow_downward,
                    color: R.color.appTextColor2,
                  ),
                ),
              ),
            ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _getChatInput(context, viewModel),
          ),
        ],
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context, VmHome viewModel) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: TextBasic(
                text: 'Your Chat History',
                fontSize: 18,
                fontFamily: R.fonts.displayBold,
                color: R.color.appTextColor,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                itemCount: viewModel.chatHistory.length,
                itemBuilder: (context, index) {
                  final chat = viewModel.chatHistory[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (index == 0)
                        Divider(
                          height: 1,
                          color: R.color.appTextColor,
                        ),
                      ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 0),
                        title: TextBasic(
                          text:
                              '${chat['messages']} ${chat['timestamp']}',
                          color: R.color.appTextColor,
                          fontSize: 16,
                        ),
                        onTap: () {
                          viewModel.loadChat(chat['id']);
                          viewModel.scaffoldKey.currentState?.closeDrawer();
                        },
                      ),
                      Divider(
                        height: 1,
                        color: R.color.appTextColor,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getChatInput(BuildContext context, VmHome viewModel) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: TextFieldBasic(
        bgColor: R.color.white,
        
        prefixIcon: Container(
          padding: const EdgeInsets.all(6.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child:SvgPicture.asset(
                    R.drawable.svg.iconAttach,
                    width: 36.0,
                ),
          ),
        ),
        suffixIcon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: viewModel.textController.text.isEmpty 
              ? Icon(
                  Icons.send,
                  color: R.color.appBackgroundColor,
                  size: 36.0,
                )
              : GestureDetector(
                  onTap: viewModel.sendMessage,
                  child: Icon(
                    Icons.plus_one,
                    color: R.color.appBackgroundColor,
                    size: 36.0,
                  ),
                ),
        ),
        hintText: '\tAsk anything',
        fontSize: 16,
        title: '',
        textColor: R.color.appTextColor2,
        labelTextColor: R.color.appTextColor2,
        borderColor: R.color.transparent,
        controller: viewModel.textController,
        focusNode: viewModel.textFocusNode,
      ),
    );
  }
}
