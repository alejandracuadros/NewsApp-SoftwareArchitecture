import 'package:firebase_auth/firebase_auth.dart';
import 'package:kira_news/core/theme/app_colors.dart';
import '../../core/helper_functions.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(
            message: 'The email address is already in use.',
            color: AppColors.primaryYellow);
      } else {
        showToast(message: e.code, color: AppColors.primaryYellow);
      }
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(
            message: 'Invalid email or password.',
            color: AppColors.primaryYellow);
      } else {
        showToast(message: e.code, color: AppColors.primaryYellow);
      }
    }
    return null;
  }
}
