import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthController {
  FirebaseAuth auth = FirebaseAuth.instance;

  User? get currentUser => auth.currentUser;

  Future<void> signInWithGoogle() async {
    try {
      // Inicia o processo de autenticação com o Google
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);

      await auth.signInWithCredential(credential);
    } catch (e) {
      print("Sign in failed: $e");
    }
  }

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await auth.signOut();
  }
}
