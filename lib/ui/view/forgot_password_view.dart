import 'package:dokudoku/ui/components/loader.dart';
import 'package:dokudoku/ui/components/snack_bar_utils.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dokudoku/services/email_auth.dart';

class ForgotPassWordView extends StatefulWidget {
  const ForgotPassWordView({super.key});

  @override
  State<ForgotPassWordView> createState() => _ForgotPassWordViewState();
}

class _ForgotPassWordViewState extends State<ForgotPassWordView> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.resources.color.colorLightest,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: context.resources.color.colorLightest,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: context.resources.color.colorDark,
              size: 45,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: context.resources.color.colorWhite,
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color.fromARGB(255, 150, 150, 150),
                  offset: Offset(0, 6),
                  blurRadius: 11,
                ),
              ],
            ),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Padding(
              padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.mail_outline,
                        color: context.resources.color.colorDark, size: 70),
                    const SizedBox(height: 20),
                    const Text(
                      'Receive an email to \nreset your password',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      cursorColor: context.resources.color.colorDark,
                      textInputAction: TextInputAction.done,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: context.resources.color.colorDark),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: context.resources.color.colorDark),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: context.resources.color.warning),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: context.resources.color.warning),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: context.resources.color.colorWhite,
                          labelStyle: const TextStyle(
                            color: Color(0xff92603D),
                          ),
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          hintStyle: TextStyle(
                              color: context.resources.color.colorDarkest)),
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return 'Please enter email';
                        } else if (EmailPasswordAuth.errorText ==
                                'invalid-email' ||
                            EmailPasswordAuth.errorLoginText ==
                                'invalid-email') {
                          return 'Invalid email';
                        } else if (EmailPasswordAuth.errorLoginText ==
                            'user-not-found') {
                          return "No user found for this email.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(double.infinity, 40),
                        textStyle: const TextStyle(
                            fontSize: 20, fontFamily: 'primary'),
                        backgroundColor: context.resources.color.colorDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        minimumSize: Size.fromHeight(50),
                      ),
                      icon: Icon(Icons.email_outlined),
                      label: const Text(
                        'Reset Password',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: resetPassword,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future resetPassword() async {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Loader(),
      ),
    );
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      SnackBarUtils.showSuccessSnackBar(
        context: context,
        content: 'Password Reset Email Sent',
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      SnackBarUtils.showWarningSnackBar(
        context: context,
        content: e.code,
      );

      Navigator.of(context).pop();
      print(e.code);
      print(e.message);
    }
  }
}
