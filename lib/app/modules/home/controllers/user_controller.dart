import 'package:get/get.dart';
import 'package:twitch_clone/app/database_resources.dart/database_resources.dart';
import 'package:twitch_clone/app/modules/home/controllers/auth_controller.dart';
import 'package:twitch_clone/app/modules/home/model/user_model.dart';

class UserController extends GetxController {
 final AuthController _authController = Get.find();
  DatabaseServices db = DatabaseServices();
  final Rx<UserModel?> _user = UserModel(uid: '', email: '', username: '').obs;
  UserModel get currentUser => _user.value!;

    UserModel get user => _user.value!;
  Future<UserModel> getCurrentUser({required String uid}) async {
    return await db.userCollection.doc(uid).get().then((doc) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    });
  }
 @override
  Future<void> onReady() async {
    _user.value = await getCurrentUser(uid: _authController.user.uid);
    print(_user.value!.email);
    super.onReady();
  }
}
