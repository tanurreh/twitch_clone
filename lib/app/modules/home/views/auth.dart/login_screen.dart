import 'package:flutter/material.dart';
import 'package:twitch_clone/app/modules/home/controllers/auth_controller.dart';
import 'package:twitch_clone/app/modules/home/widgets.dart/custom_buttons.dart';
import 'package:twitch_clone/app/modules/home/widgets.dart/custom_text_feild.dart';
import 'package:twitch_clone/app/modules/home/widgets.dart/loading_indicators.dart';
import 'package:twitch_clone/app/responsive/responsive.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // final AuthMethods _authMethods = AuthMethods();
  bool _isLoading = false;

  loginUser() async {
    setState(() {
      _isLoading = true;
    });
    bool res = await AuthController.instance.loginUser(
      _emailController.text,
      _passwordController.text,
    );
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
        ),
      ),
      body: _isLoading
          ? const LoadingIndicator()
          : Responsive(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.1),
                      const Text(
                        'Email',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CustomTextField(
                          controller: _emailController,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CustomTextField(
                          controller: _passwordController,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                          onTap:
                            loginUser,

                          // loginUser,
                          text: 'Log In'),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
