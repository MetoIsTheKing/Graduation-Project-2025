import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_2025/config/theming/text_styles.dart';
import 'package:graduation_project_2025/config/token_manager.dart';
import 'package:graduation_project_2025/core/helpers/my_logger.dart';
import 'package:graduation_project_2025/core/helpers/navigation_extentions.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart';
import 'package:graduation_project_2025/core/responsive/ui_component/info_widget.dart';
import 'package:graduation_project_2025/core/shared_components/custom_rounded_button.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/chat_bot/data/message_model.dart';
import 'package:graduation_project_2025/core/shared_components/curved_appbar.dart';
import 'package:graduation_project_2025/features/chat_bot/presentation/cubit/chat_bot_cubit.dart';
import 'package:graduation_project_2025/features/chat_bot/presentation/cubit/chat_bot_state.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen>
    with TickerProviderStateMixin {
  //! i need to clear the chat , and store it for a while
  final ScrollController _scrollController = ScrollController();
  ValueNotifier<bool> isButtonDisabled = ValueNotifier<bool>(false);
  //? mock messages
  // final List<MessageModel> _messages = [
  //   MessageModel(
  //       content: "Hello! How can I assist you today?", isUserMessage: false),
  //   MessageModel(
  //       content: "Hi, I need help with booking a flight.",
  //       isUserMessage: false,
  //       isSearchFlights: true),
  // ];
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late String sessionId;
  late Map<String, dynamic> additionalParams;

  // Animation controllers for the loading dots
  late final List<AnimationController> _dotAnimationControllers;

  @override
  void initState() {
    super.initState();
    isButtonDisabled.value = _controller.text.isEmpty;
    _controller.addListener(() {
      isButtonDisabled.value = _controller.text.isEmpty;
    });
    sessionId = _generateRandomSessionId();
    additionalParams = {
      "session_id": sessionId,
      "user_id": "loading",
      "access_token": "loading"
    };

    // Initialize animation controllers for the three dots
    _dotAnimationControllers = List.generate(3, (index) {
      return AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 600),
      )..repeat(reverse: true);
    });

    // Then update with actual values
    _loadTokens();
  }

  Future<void> _loadTokens() async {
    final userId = await TokenManager.getUserId();
    final accessToken = await TokenManager.getAccessToken();

    // Update parameters with actual values
    setState(() {
      additionalParams = {
        "session_id": sessionId,
        "user_id": userId ?? "guest",
        "access_token": accessToken ?? ""
      };
    });
  }

  String _generateRandomSessionId() {
    final random = Random();
    // Generate a random number between 100 and 999 (3 digits)
    return (100 + random.nextInt(900)).toString();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    isButtonDisabled.dispose();

    // Dispose all animation controllers
    for (var controller in _dotAnimationControllers) {
      controller.dispose();
    }

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
                  child: BlocBuilder<ChatBotCubit, ChatBotState>(
                    builder: (context, state) {
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: state.messages.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return messageWidget(
                              deviceInfo, state.messages[index]);
                        },
                      );
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
                                      context.read<ChatBotCubit>().sendMessage(
                                          _controller.text,
                                          additionalParams: additionalParams);
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
                                      //_addBotResponse();
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
                message.isLoading
                    ? Builder(
                        builder: (context) {
                          // Reset the dot index before building the dots
                          _currentDotIndex = 0;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildDot(deviceInfo),
                              SizedBox(width: deviceInfo.screenWidth * 0.01),
                              _buildDot(deviceInfo),
                              SizedBox(width: deviceInfo.screenWidth * 0.01),
                              _buildDot(deviceInfo),
                            ],
                          );
                        },
                      )
                    : Text(
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
                    visible: message.isSearchFlights &&
                        message.flights != null &&
                        message.flights!.isNotEmpty,
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

  // Track which dot is being built
  int _currentDotIndex = 0;

  Widget _buildDot(DeviceInfo deviceInfo) {
    // Use the current index and increment it for the next dot
    final animationController = _dotAnimationControllers[_currentDotIndex % 3];
    _currentDotIndex = (_currentDotIndex + 1) % 3;

    return Container(
      width: deviceInfo.screenWidth * 0.02,
      height: deviceInfo.screenWidth * 0.02,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.appBlack.withOpacity(0.6),
      ),
      child: FadeTransition(
        opacity: animationController,
        child: Container(),
      ),
    );
  }
}

// //^ mockinggggggggggggggggggg
//   void _addBotResponse() {
//     Future.delayed(const Duration(milliseconds: 800), () {
//       if (!mounted) return;
//       _messages.add(
//         MessageModel(
//           isUserMessage: false,
//           content: "I've received your message. How can I help you further?",
//         ),
//       );
//       setState(() {});
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (_scrollController.hasClients) {
//           _scrollController.animateTo(
//             _scrollController.position.maxScrollExtent,
//             duration: Duration(milliseconds: 300),
//             curve: Curves.easeOut,
//           );
//         }
//       });
//     });
//   }
