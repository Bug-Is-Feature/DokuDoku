import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:dokudoku/services/dokudoku_service/user_service.dart';

class GoogleAuth {
  GoogleAuth();

  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future<void> signIn() async {
    print('login');
    final googleUser = await googleSignIn.signIn();
    print('asd $googleUser');
    if (googleUser == null) return;

    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    print(googleAuth);

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    print(credential);

    final UserCredential authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);

    print('login gmail: ${googleUser.email}');
    if (authResult.additionalUserInfo!.isNewUser) {
      print('isNewUser: true');
      //   await UserServices.createUser();
    } else {
      //   await UserServices.updateLastLogin();
    }
  }
}
