import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  String _email = '', _password = '', type = 'login';
  //User? user;
  // bool _success = false;

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
          headline1: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'primary',
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: context.resources.color.colorLightest,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      // margin: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Image.asset(
                        'assets/images/Icononly.png',
                        height: 170,
                      ),
                    ),
                    Container(
                      // margin: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Image.asset(
                        'assets/images/DokuDoku_Fontonly.png',
                        height: 70,
                      ),
                    ),
                    SizedBox(
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
                    SizedBox(
                      height: 20,
                    ),
                    AuthTextField(email: '', password: '', type: type),
                    SizedBox(
                      height: 10,
                    ),
                    AuthTextField(email: '', password: '', type: type),
                    if (type == 'register') ...[
                      SizedBox(
                        height: 10,
                      ),
                    ],
                    SizedBox(
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
                              onPressed: () {})),
                    ),
                    SizedBox(height: 20),
                    if (type == 'register') ...[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text('Have an account?',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18)),
                            TextButton(
                              onPressed: () => setState(() => type = 'login'),
                              child: const Text(
                                'Log in',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
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
                                color: Color(0xff92603D),
                              )),
                              SizedBox(width: 10),
                              Text(
                                'or connect with',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                  child: Divider(
                                color: Color(0xff92603D),
                              )),
                            ],
                          ),
                          const SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              _AuthButton(
                                  image: const NetworkImage(
                                      'https://freesvg.org/img/1534129544.png'),
                                  onPressed: () {}),
                            ],
                          ),
                          const SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                              TextButton(
                                onPressed: () =>
                                    setState(() => type = 'register'),
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
                    ]
                  ],
                ),
              ),
            ),
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
                SizedBox(width: 65),
                Text(
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
  String _email = '', _password = '', type = 'login';
  AuthTextField({
    required email,
    required password,
    required type,
  });
  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (value) {
        widget._password = value!;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 1, color: context.resources.color.colorDark),
            borderRadius: BorderRadius.circular(20)),
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 1, color: context.resources.color.colorDark),
            borderRadius: BorderRadius.circular(20)),
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(color: Color(0xff92603D)),
        labelText: 'Comfirm Password',
      ),
    );
  }
}
