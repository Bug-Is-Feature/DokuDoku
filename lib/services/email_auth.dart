import 'package:dokudoku/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

// import 'package:dokudoku/services/dokudoku_service/user_service.dart';

class EmailPasswordAuth {
  const EmailPasswordAuth();
  static String errorText = '';

  Future<void> signIn(BuildContext context, String email, String pwd) async {
    try {
      final User? user =
          (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pwd,
      ))
              .user;

      await UserServices.updateLastLogin();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xff76CC96),
          content: Text(
            '${user!.email} signed in',
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xffF96161),
          content: Text(
            "Failed to sign in with email",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
      );
    }
  }

  Future<void> register(BuildContext context, String email, String pwd) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pwd,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xff76CC96),
          content: Text(
            'Register successful',
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
      );

      await UserServices.createUser();
    } on FirebaseAuthException catch (e) {
      print(e.message);
      print(e.code);
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
