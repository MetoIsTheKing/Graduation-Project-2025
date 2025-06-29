import 'package:flutter/material.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/core/helpers/my_logger.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/chat_bot/data/message_model.dart';
import 'package:graduation_project_2025/core/shared_components/curved_appbar.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  //! ineed to clear the chat , and store it for a while
  final ScrollController _scrollController = ScrollController();
  ValueNotifier<bool> isButtonDisabled = ValueNotifier<bool>(false);
  //? mock messages
  final List<MessageModel> _messages = [
    MessageModel(
        content: "Hello! How can I assist you today?", isUserMessage: false),
    MessageModel(
        content: "Hi, I need help with booking a flight.",
        isUserMessage: false,
        isSearchFlights: true),
  ];
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    isButtonDisabled.value = _controller.text.isEmpty;
    _controller.addListener(() {
      isButtonDisabled.value = _controller.text.isEmpty;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    isButtonDisabled.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context, deviceInfo, constraints) {
        return Scaffold(
          backgroundColor: AppColors.appLighterGrey,
          resizeToAvoidBottomInset:
              false, // Crucial for keeping bottom bar above keyboard
          appBar: CurvedAppbar(
            onBack: () => context.pop(),
            backgroundColor: AppColors.appBlue,
            titleWidget: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(right: deviceInfo.screenWidth * 0.015),
                  child: Icon(
                    Icons.child_care,
                    color: Colors.white,
                    size: deviceInfo.screenWidth * 0.08,
                  ),
                ),
                Text(
                  "Chat Bot",
                  style: TextStyles.bold20(deviceInfo, Colors.white),
                )
              ],
            ),
            backButtonColor: Colors.white,
          ),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: deviceInfo.screenWidth * 0.04,
                      vertical: deviceInfo.screenHeight * 0.02),
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _messages.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return messageWidget(deviceInfo, _messages[index]);
                    },
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                color: AppColors.appGrey,
                padding: EdgeInsets.only(
                  top: deviceInfo.screenHeight * 0.001,
                  bottom: MediaQuery.of(context).viewInsets.bottom * 0.85,
                ),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: deviceInfo.screenWidth * 0.04,
                      vertical: deviceInfo.screenHeight * 0.02,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            focusNode: _focusNode,
                            minLines: 1,
                            maxLines: 50,
                            onSubmitted: (value) {
                              MyLogger.green('User input: $value');
                              _focusNode.unfocus();
                              _controller.clear();
                            },
                            onTapOutside: (event) => _focusNode.unfocus(),
                            onChanged: (value) {
                              isButtonDisabled.value = value.isEmpty;
                            },
                            decoration: InputDecoration(
                              hintText: "Type your message here...",
                              fillColor: Colors.white,
                              filled: true,
                              hintStyle: TextStyles.medium12(
                                  deviceInfo, AppColors.appBlack),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: AppColors.appBlue, width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: AppColors.appBlack, width: 1),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: deviceInfo.screenWidth * 0.04,
                                vertical: deviceInfo.screenHeight * 0.005,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: deviceInfo.screenWidth * 0.02),
                        ValueListenableBuilder(
                          valueListenable: isButtonDisabled,
                          builder: (context, value, child) {
                            return AnimatedOpacity(
                              duration: Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                              opacity: value ? 0 : 1,
                              child: Visibility(
                                visible: !value,
                                child: CircleAvatar(
                                  radius: deviceInfo.screenWidth * 0.06,
                                  backgroundColor: AppColors.appBlue,
                                  child: IconButton(
                                    icon: Icon(Icons.send, color: Colors.white),
                                    onPressed: () {
                                      if (value) return;
                                      if (_controller.text.isEmpty) return;
                                      _messages.add(
                                        MessageModel(
                                          isUserMessage: true,
                                          content: _controller.text,
                                        ),
                                      );
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        if (_scrollController.hasClients) {
                                          _scrollController.animateTo(
                                            _scrollController
                                                .position.maxScrollExtent,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeOut,
                                          );
                                        }
                                      });
                                      _addBotResponse();
                                      _focusNode.unfocus();
                                      _controller.clear();
                                      isButtonDisabled.value = true;
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Padding messageWidget(DeviceInfo deviceInfo, MessageModel message) {
    return Padding(
      padding: EdgeInsets.only(bottom: deviceInfo.screenHeight * 0.01),
      child: Row(
        mainAxisAlignment: message.isUserMessage
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            width: deviceInfo.screenWidth * 0.5,
            decoration: BoxDecoration(
              color:
                  message.isUserMessage ? AppColors.appBlue : AppColors.appGrey,
              borderRadius: message.isUserMessage
                  ? BorderRadius.only(
                      topLeft: Radius.circular(deviceInfo.screenWidth * 0.035),
                      bottomLeft:
                          Radius.circular(deviceInfo.screenWidth * 0.035),
                      bottomRight:
                          Radius.circular(deviceInfo.screenWidth * 0.035),
                    )
                  : BorderRadius.only(
                      topRight: Radius.circular(deviceInfo.screenWidth * 0.035),
                      bottomLeft:
                          Radius.circular(deviceInfo.screenWidth * 0.035),
                      bottomRight:
                          Radius.circular(deviceInfo.screenWidth * 0.035),
                    ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: deviceInfo.screenWidth * 0.02,
              vertical: deviceInfo.screenHeight * 0.01,
            ),
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  softWrap: true,
                  message.content,
                  style: TextStyles.medium12(
                      deviceInfo,
                      message.isUserMessage
                          ? Colors.white
                          : AppColors.appBlack),
                ),
                Visibility(
                    visible: message.isSearchFlights,
                    child: Transform.scale(
                      scale: 0.9,
                      child: CustomRoundedButton(
                          deviceInfo: deviceInfo,
                          label: "See Results",
                          backgroundColor: AppColors.appBlue,
                          onPressed: () {},
                          textColor: Colors.white),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

//^ mockinggggggggggggggggggg
  void _addBotResponse() {
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      _messages.add(
        MessageModel(
          isUserMessage: false,
          content: "I've received your message. How can I help you further?",
        ),
      );
      setState(() {});
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }
}
