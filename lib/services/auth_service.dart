import 'package:firebase_auth/firebase_auth.dart';
import 'package:dokudoku/services/email_auth.dart';
import 'package:dokudoku/services/google_auth.dart';

class AuthService {
  static const EmailPasswordAuth emailPasswordAuth = EmailPasswordAuth();
  static GoogleAuth googleAuth = GoogleAuth();

  static Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
  }
}
