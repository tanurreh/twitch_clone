import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:get/get.dart';
import 'package:twitch_clone/app/data/constants.dart';
import 'package:twitch_clone/app/modules/home/controllers/auth_controller.dart';
import 'package:twitch_clone/app/modules/home/controllers/live_stream_controller.dart';
import 'package:twitch_clone/app/modules/home/controllers/user_controller.dart';
import 'package:twitch_clone/app/modules/home/model/live_stream_model.dart';
import 'package:twitch_clone/app/modules/home/views/broadcast_screen.dart';
import 'package:twitch_clone/app/modules/home/widgets.dart/custom_buttons.dart';
import 'package:twitch_clone/app/modules/home/widgets.dart/custom_text_feild.dart';
import 'package:twitch_clone/app/responsive/responsive.dart';
import 'package:twitch_clone/app/services.dart/image_picker_services.dart';

class GoLiveScreen extends StatefulWidget {
  const GoLiveScreen({Key? key}) : super(key: key);

  @override
  State<GoLiveScreen> createState() => _GoLiveScreenState();
}

class _GoLiveScreenState extends State<GoLiveScreen> {
  UserController userController = Get.find();
  final LiveSteamController _liveStreamController = Get.find();

  final TextEditingController _titleController = TextEditingController();
  Uint8List? image;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  goLiveStream() async {
    print(userController.currentUser.username);
    String channelId =
        await _liveStreamController.startLiveStream(_titleController.text, image);
    print(channelId);
    if (channelId.isNotEmpty) {
      Get.snackbar(
        'Successful',
        'Livestream has started successfully!',
      );
      Get.to(
        () => BroadCastScreen(
          isBroadcaster: true,
          channelId: channelId,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Responsive(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Uint8List? pickedImage = await pickImage();
                        if (pickedImage != null) {
                          setState(() {
                            image = pickedImage;
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22.0,
                          vertical: 20.0,
                        ),
                        child: image != null
                            ? SizedBox(
                                height: 300,
                                child: Image.memory(image!),
                              )
                            : DottedBorder(
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(10),
                                dashPattern: const [10, 4],
                                strokeCap: StrokeCap.round,
                                color: CustomColor.buttonColor,
                                child: Container(
                                  width: double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: CustomColor.buttonColor
                                        .withOpacity(.05),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.folder_open,
                                        color: CustomColor.buttonColor,
                                        size: 40,
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        'Select your thumbnail',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.shade400,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Title',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CustomTextField(
                            controller: _titleController,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: CustomButton(
                    text: 'Go Live!',
                    onTap: goLiveStream,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
