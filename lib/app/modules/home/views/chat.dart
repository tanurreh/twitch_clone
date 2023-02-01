import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitch_clone/app/modules/home/controllers/live_stream_controller.dart';
import 'package:twitch_clone/app/modules/home/controllers/user_controller.dart';
import 'package:twitch_clone/app/modules/home/model/user_model.dart';
import 'package:twitch_clone/app/modules/home/widgets.dart/custom_text_feild.dart';
import 'package:twitch_clone/app/modules/home/widgets.dart/loading_indicators.dart';

class Chat extends StatefulWidget {
  final String channelId;
  const Chat({
    Key? key,
    required this.channelId,
  }) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final UserController _userController = Get.find();
    final LiveSteamController _liveSteamController = Get.find();
  final TextEditingController _chatController = TextEditingController();

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = _userController.currentUser;
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width > 600 ? size.width * 0.25 : double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder<dynamic>(
              stream: FirebaseFirestore.instance
                  .collection('livestream')
                  .doc(widget.channelId)
                  .collection('comments')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingIndicator();
                }

                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                      snapshot.data.docs[index]['username'],
                      style: TextStyle(
                        color: snapshot.data.docs[index]['uid'] ==
                               user.uid
                            ? Colors.blue
                            : Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      snapshot.data.docs[index]['message'],
                    ),
                  ),
                );
              },
            ),
          ),
          CustomTextField(
            controller: _chatController,
            onTap: (val) {
            _liveSteamController.chat(
                _chatController.text,
                widget.channelId,
              );
              setState(() {
                _chatController.text = "";
              });
            },
          )
        ],
      ),
    );
  }
}
