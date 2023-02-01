import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitch_clone/app/database_resources.dart/database_resources.dart';

import 'package:twitch_clone/app/modules/home/controllers/user_controller.dart';
import 'package:twitch_clone/app/modules/home/model/live_stream_model.dart';
import 'package:twitch_clone/app/modules/home/model/user_model.dart';
import 'package:uuid/uuid.dart';

class LiveSteamController extends GetxController {
  final UserController _userController = Get.find();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  DatabaseServices db = DatabaseServices();

  Future<String> uploadToStrorge(
      String childname, Uint8List file, String uid) async {
    Reference ref = _storage.ref().child(childname).child(uid);
    UploadTask uploadTask = ref.putData(
      file,
      SettableMetadata(
        contentType: 'image/jpg',
      ),
    );
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> startLiveStream(String title,Uint8List? image) async {
    //Channel Id
    String channelId = '';
    try {
      //Check For Empty
      if (title.isNotEmpty && image != null) {
        //check for already existance
        if (!(await db.liveStreamCollection
                .doc(
                    '${_userController.user.uid}${_userController.user.username}')
                .get())
            .exists) {
String thumbnailUrl = await uploadToStrorge(
          'livestream-thumbnails', image, _userController.user.uid);

          channelId =
              '${_userController.user.uid}${_userController.user.username}';
          LiveStream liveStream = LiveStream(
              title: title,
              image: thumbnailUrl,
              uid: _userController.user.uid,
              username: _userController.user.username,
              viewers: 0,
              channelId: channelId,
              startedAt: DateTime.now());
          await db.liveStreamCollection.doc(channelId).set(liveStream.toMap());
        } else {
          Get.snackbar(
            'More the one Stream',
            'Two Livestreams cannot start at the same time.',
          );
        }
      } else {
        Get.snackbar(
          'Empty Feilds',
          'Please Input All feilds',
        );
      }
    } on FirebaseException catch (e) {
      Get.snackbar('SomeThing went wrong', e.toString());
    }
    return channelId;
  }

  Future<void> endLiveStream(String channelId) async {
    try {
      QuerySnapshot snap = await db.liveStreamCollection
          .doc(channelId)
          .collection('comments')
          .get();

      for (int i = 0; i < snap.docs.length; i++) {
        await db.liveStreamCollection
            .doc(channelId)
            .collection('comments')
            .doc(
              ((snap.docs[i].data()! as dynamic)['commentId']),
            )
            .delete();
      }
      await db.liveStreamCollection.doc(channelId).delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> chat(String text, String id) async {
    UserModel user = _userController.currentUser;

    try {
      String commentId = const Uuid().v1();
      await db.liveStreamCollection
          .doc(id)
          .collection('comments')
          .doc(commentId)
          .set({
        'username': user.username,
        'message': text,
        'uid': user.uid,
        'createdAt': DateTime.now(),
        'commentId': commentId,
      });
    } on FirebaseException catch (e) {
      Get.snackbar('Message Not delivered', e.message!);
    }
  }

  Future<void> updateViewCount(String id, bool isIncrease) async {
    try {
      await db.liveStreamCollection.doc(id).update({
        'viewers': FieldValue.increment(isIncrease ? 1 : -1),
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
