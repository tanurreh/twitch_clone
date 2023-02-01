import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:twitch_clone/app/database_resources.dart/database_resources.dart';
import 'package:twitch_clone/app/modules/home/model/user_model.dart';
import 'package:twitch_clone/app/modules/home/views/auth.dart/login_screen.dart';
import 'package:twitch_clone/app/modules/home/views/home_view.dart';
import 'package:twitch_clone/app/modules/home/views/on_boarding_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseServices db = DatabaseServices();
  late Rx<User?> _user;
  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(_auth.currentUser);
    _user.bindStream(_auth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => OnboardingScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }


  // registeration of user
  Future<bool> registerUser(
    String emailAddress,
    String username,
    String password,
  ) async {
    bool res = false;
    try {
      if (emailAddress.isNotEmpty &&
          username.isNotEmpty &&
          password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: emailAddress, password: password);
        // upload image to firestorage
        //Creating Model to enter in firestore
        UserModel user = UserModel(
          uid: cred.user!.uid,
          username: username,
          email: emailAddress,
        );
        await db.userCollection.doc(cred.user!.uid).set(user.toMap());
        res = true;
      } else {
        Get.snackbar('Data Feilds are empty', "Please Input all feilds");
        res = false;
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Unenale to Create User', e.toString());
      res = false;
    }
    return res;
  }

  Future<bool> loginUser(String emailAddress, String password) async {
    bool res = false;
    try {
      if (emailAddress.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: emailAddress, password: password);
        print('log in sucessfull');
        res = true;
      } else {
        Get.snackbar('Feilds are Empty', "Please Complete all the feild ");
        res = false;
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Authentication Failed', e.toString());
      res = false;
    }
    return res;
  }

  signOut() async {
    await _auth.signOut();
  }
}
