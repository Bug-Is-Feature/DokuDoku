import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:dokudoku/services/user_service.dart';
import 'package:dokudoku/ui/components/snack_bar_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailPasswordAuth {
  const EmailPasswordAuth();
  static String errorText = '';
  static String errorLoginText = '';

  Future<void> signIn(BuildContext context, String email, String pwd) async {
    try {
      final User? user =
          (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pwd,
      ))
              .user;

      await UserServices.updateLastLogin();

      SnackBarUtils.showSuccessSnackBar(
        context: context,
        content: '${user!.email} signed in',
      );
    } on FirebaseAuthException catch (e) {
      errorLoginText = e.code;

      if (e.code == 'wrong-password') {
        print(errorText);
      } else if (e.code == 'user-not-found') {
        print('user not found');
      } else if (e.code == 'invalid-email') {
        print('The email is invalid');
      }
    }
  }

  Future<void> register(BuildContext context, String email, String pwd) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pwd,
      );

      SnackBarUtils.showSuccessSnackBar(
        context: context,
        content: 'Register successful',
      );

      await UserServices.createUser();
    } on FirebaseAuthException catch (e) {
      errorText = e.code;

      if (e.code == 'weak-password') {
        print(errorText);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        print('The email is invalid');
      }
    } catch (e) {
      print(e);
    }
  }
}
