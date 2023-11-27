import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kira_news/presentation/widgets/black_button.dart';
import '../../../core/helper_functions.dart';
import '../../../core/theme/app_text_style.dart';
import '../../../data/auth/firebase_auth.dart';
import '../../widgets/rounded_text_field.dart';
import '../sign_up/sign_up.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _isSigning = false;
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Login"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24).r,
            child: Column(
              children: [
                Text(
                  "Login",
                  style:
                      TextStyle(fontSize: 27.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30.h,
                ),
                RoundedTextField(
                  controller: _emailController,
                  hintText: "Email",
                ),
                SizedBox(
                  height: 10.h,
                ),
                RoundedTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  isObscure: true,
                ),
                SizedBox(
                  height: 30.h,
                ),
                BlackButton(
                  text: 'Login',
                  onTap: () {
                    _signIn();
                  },
                  isLoading: _isSigning,
                ),
                SizedBox(
                  height: 32.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style:
                            AppTextStyles.styleW600.copyWith(fontSize: 15.sp),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        "Sign Up",
                        style: AppTextStyles.styleW700
                            .copyWith(color: Colors.blue, fontSize: 15.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    closeKeyboard();
    if (_formKey.currentState?.validate() == true) {
      try {
        setState(() {
          _isSigning = true;
        });

        String email = _emailController.text;
        String password = _passwordController.text;

        final FirebaseAuthService auth = FirebaseAuthService();
        final user = await auth.signInWithEmailAndPassword(email, password);
        setState(() {
          _isSigning = false;
        });
        if (user != null) {
          showToast(
            message: "User is successfully signed in",
            color: Colors.green,
          );
        }
      } catch (e) {
        setState(() {
          _isSigning = false;
        });
      }
    }
  }
}
