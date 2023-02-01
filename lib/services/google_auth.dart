import 'package:dokudoku/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  GoogleAuth();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future<void> signIn() async {
    final googleUser =
        await GoogleSignIn(scopes: ['profile', 'email']).signIn();
    if (googleUser == null) return;

    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);

    print('login gmail: ${googleUser.email}');
    if (authResult.additionalUserInfo!.isNewUser) {
      print('isNewUser: true');
      await UserServices.createUser();
    } else {
      await UserServices.updateLastLogin();
    }
  }

  Future<void> signOut() async {
    if (_user != null) {
      await GoogleSignIn().disconnect();
    }
  }
}
