import 'package:dokudoku/services/auth_service.dart';
import 'package:dokudoku/services/email_auth.dart';
import 'package:dokudoku/ui/components/loader.dart';
import 'package:dokudoku/ui/view/forgot_password_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  String type = 'login', _email = '', _password = '', _confirmPassword = '';
  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
        textTheme: theme.textTheme.copyWith(
          headline1: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'primary',
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: context.resources.color.colorLightest,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Image.asset(
                            'assets/images/Icononly.png',
                            height: 170,
                          ),
                        ),
                        Container(
                          child: Image.asset(
                            'assets/images/DokuDoku_Fontonly.png',
                            height: 70,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text(
                            type == 'login'
                                ? 'To continue, log in to DokuDoku'
                                : 'Sign up for free to stop being a hoarder ^ - ^',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AuthTextField(
                          controller: emailController,
                          label: 'Email',
                          onSaved: (value) {
                            _email = value!;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email';
                            } else if (EmailPasswordAuth.errorText ==
                                    'invalid-email' ||
                                EmailPasswordAuth.errorLoginText ==
                                    'invalid-email') {
                              return 'Invalid email';
                            } else if (EmailPasswordAuth.errorText ==
                                'email-already-in-use') {
                              return "The account already exists for this email.";
                            } else if (EmailPasswordAuth.errorLoginText ==
                                'user-not-found') {
                              return "No user found for this email.";
                            }
                            return null;
                          },
                          isPassword: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AuthTextField(
                          controller: passwordController,
                          label: 'Password',
                          onSaved: (value) {
                            _password = value!;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            } else if (EmailPasswordAuth.errorText ==
                                'weak-password') {
                              return 'Password is too weak, at least 6 characters';
                            } else if (EmailPasswordAuth.errorLoginText ==
                                'wrong-password') {
                              return 'Password is wrong';
                            }
                            return null;
                          },
                          isPassword: true,
                        ),
                        if (type == 'register') ...[
                          const SizedBox(
                            height: 10,
                          ),
                          AuthTextField(
                            controller: confirmPasswordController,
                            label: 'Confirm Password',
                            onSaved: (value) {
                              _confirmPassword = value!;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              } else if (_password != _confirmPassword) {
                                return 'Password does not match';
                              }
                              return null;
                            },
                            isPassword: true,
                          ),
                        ],
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(double.infinity, 40),
                                  textStyle: const TextStyle(
                                      fontSize: 20, fontFamily: 'primary'),
                                  backgroundColor:
                                      context.resources.color.colorDark,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  minimumSize: const Size(double.infinity, 36)),
                              child: Text(
                                type == 'login' ? 'Login' : 'Register',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                EmailPasswordAuth.errorText = '';
                                EmailPasswordAuth.errorLoginText = '';
                                setState(() => isLoading = true);
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  if (type == 'login') {
                                    await AuthService.emailPasswordAuth
                                        .signIn(context, _email, _password);
                                  } else if (type == 'register') {
                                    await AuthService.emailPasswordAuth
                                        .register(context, _email, _password);
                                  }
                                }
                                _formKey.currentState!.validate();
                                setState(() => isLoading = false);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (type == 'register') ...[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  'Have an account?',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() => type = 'login');
                                    emailController.clear();
                                    passwordController.clear();
                                    confirmPasswordController.clear();
                                  },
                                  child: const Text(
                                    'Log in',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                )
                              ],
                            ),
                          )
                        ] else ...[
                          Column(
                            children: <Widget>[
                              Row(
                                children: const [
                                  Expanded(
                                    child: Divider(
                                      thickness: 1,
                                      color: Color(0xff92603D),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'or connect with',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Divider(
                                      thickness: 1,
                                      color: Color(0xff92603D),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  _AuthButton(
                                    image: const NetworkImage(
                                        'https://freesvg.org/img/1534129544.png'),
                                    onPressed: () async {
                                      setState(() => isLoading = true);
                                      await AuthService.googleAuth.signIn();
                                      setState(() => isLoading = false);
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15.0),
                              GestureDetector(
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                ),
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ForgotPassWordView(),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text(
                                    'Don\'t have an account?',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() => type = 'register');
                                      emailController.clear();
                                      passwordController.clear();
                                    },
                                    child: const Text(
                                      'Sign up',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                        WillPopScope(
                          child: Container(),
                          onWillPop: () async {
                            if (type == 'register') {
                              setState(() => type = 'login');
                              return false;
                            } else {
                              return true;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (isLoading == true) ...[const Loader()],
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthButton extends StatelessWidget {
  final ImageProvider image;
  final VoidCallback onPressed;

  const _AuthButton({
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          splashColor: Colors.black26,
          onTap: () => onPressed(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Ink.image(
                  image: image,
                  fit: BoxFit.cover,
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 65),
                const Text(
                  'Log in with Google',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthTextField extends StatefulWidget {
  String label;
  FormFieldSetter onSaved;
  FormFieldValidator validator;
  bool isPassword;
  TextEditingController controller;

  AuthTextField({
    super.key,
    required this.label,
    required this.onSaved,
    required this.validator,
    required this.controller,
    required this.isPassword,
  });
  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // continue in part logic
      onSaved: widget.onSaved,
      validator: widget.validator,
      obscureText: widget.isPassword ? isObscure : false,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 1, color: context.resources.color.colorDark),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 1, color: context.resources.color.colorDark),
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 1, color: context.resources.color.warning),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 1, color: context.resources.color.warning),
          borderRadius: BorderRadius.circular(20),
        ),
        filled: true,
        fillColor: context.resources.color.colorWhite,
        labelStyle: const TextStyle(
          color: Color(0xff92603D),
        ),
        labelText: widget.label,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  isObscure ? Icons.visibility : Icons.visibility_off,
                  color: context.resources.color.colorDark,
                ),
                onPressed: () {
                  setState(() => isObscure = !isObscure);
                },
              )
            : null,
      ),
      controller: widget.controller,
    );
  }
}
