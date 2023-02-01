// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:instagram/app/modules/widgets/dialogs/loading_dialog.dart';
// import 'package:instagram/app/services/database_services.dart';
// import '../../../models/user_model.dart';
// import 'auth_controller.dart';
// class UserController extends GetxController {
//   DatabaseServices db = DatabaseServices();
//   Rx<UserModel?> _userModel = UserModel().obs;
//   AuthController authController = Get.find<AuthController>();
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   UserModel get user => _userModel.value!;
//   Future<UserModel> getCurrentUser({required String uid}) async {
//     return await db.usersCollection.doc(uid).get().then((doc) {
//       return UserModel.fromMap(doc.data() as Map<String, dynamic>);
//     });
//   }
//   @override
//   Future<void> onReady() async {
//     _userModel.value = await getCurrentUser(uid: authController.user!.uid);
//     print(_userModel.value!.email);
//     super.onReady();
//   }
//   Future<void> followUser(
//       {required String uid, required String followId}) async {
//     showLoadingDialog(message: "Following");
//     try {
//       DocumentSnapshot snap =
//           await _firestore.collection('Users').doc(uid).get();
//       List<dynamic> following = (snap.data()! as dynamic)['following'];
//       log(following.toString());
//       if (following.contains(followId)) {
//         await _firestore.collection('Users').doc(followId).update({
//           'followers': FieldValue.arrayRemove([uid])
//         });
//         await _firestore.collection('Users').doc(uid).update({
//           'following': FieldValue.arrayRemove([followId])
//         });
//       } else {
//         await _firestore.collection('Users').doc(followId).update({
//           'followers': FieldValue.arrayUnion([uid])
//         });
//         await _firestore.collection('Users').doc(uid).update({
//           'following': FieldValue.arrayUnion([followId])
//         });
//       }
//       hideLoadingDialog();
//     } catch (e) {
//       hideLoadingDialog();
//       Get.snackbar('Error', e.toString());
//     }
//   }
// }