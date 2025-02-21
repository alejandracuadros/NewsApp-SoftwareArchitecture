import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kira_news/core/theme/app_colors.dart';
import 'package:kira_news/core/theme/app_text_style.dart';
import 'package:kira_news/presentation/widgets/black_button.dart';
import 'package:kira_news/presentation/widgets/rounded_text_field.dart';
import '../../../core/helper_functions.dart';
import '../../../data/auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late final TextEditingController _usernameController =
      TextEditingController();
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  late final TextEditingController _passwordConfirmController =
      TextEditingController();

  bool isSigningUp = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Sign Up",
          style: AppTextStyles.styleW700,
        ),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24).r,
            child: Column(
              children: [
                Text(
                  "Sign Up",
                  style:
                      TextStyle(fontSize: 27.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30.h,
                ),
                RoundedTextField(
                  controller: _usernameController,
                  hintText: "Username",
                ),
                SizedBox(
                  height: 10.h,
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
                  height: 10.h,
                ),
                RoundedTextField(
                  controller: _passwordConfirmController,
                  hintText: "Confirm password",
                  isObscure: true,
                ),
                SizedBox(
                  height: 30.h,
                ),
                BlackButton(
                  text: "Sign Up",
                  isLoading: isSigningUp,
                  onTap: () {
                    _signUp();
                  },
                ),
                SizedBox(height: 32.h),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0).r,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style:
                              AppTextStyles.styleW600.copyWith(fontSize: 15.sp),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "Login",
                          style: AppTextStyles.styleW700
                              .copyWith(color: Colors.blue, fontSize: 15.sp),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    closeKeyboard();
    try {
      if (_formKey.currentState?.validate() == true) {
        if (_passwordController.text != _passwordConfirmController.text) {
          showToast(
            message: 'Passwords do not match',
            color: AppColors.primaryYellow,
          );
          return;
        }
        setState(() {
          isSigningUp = true;
        });

        String email = _emailController.text;
        String password = _passwordController.text;
        final FirebaseAuthService auth = FirebaseAuthService();

        User? user = await auth.signUpWithEmailAndPassword(email, password);

        final collectionRef = FirebaseFirestore.instance.collection('users');

        await collectionRef.doc(user!.uid).set({
          'username': _usernameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'id': user.uid,
        }).then((value) => Navigator.pop(context));

        showToast(
          message: "User is successfully created",
          color: Colors.green,
        );
      }
    } catch (e) {
      setState(() {
        isSigningUp = false;
      });
    }
  }
}
