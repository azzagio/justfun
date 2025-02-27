import 'package:firebase_auth/firebase_auth.dart';
    import 'package:google_sign_in/google_sign_in.dart';

    class AuthService {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final GoogleSignIn _googleSignIn = GoogleSignIn();

      Future<User?> signInWithGoogle() async {
        try {
          final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
          final GoogleSignInAuthentication googleAuth = await googleSignInAccount!.authentication;
          final OAuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          final UserCredential userCredential = await _auth.signInWithCredential(credential);
          return userCredential.user;
        } catch (e) {
          print(e.toString());
          return null;
        }
      }

      Future<void> signOut() async {
        await _auth.signOut();
        await _googleSignIn.signOut();
      }

      Stream<User?> get authStateChanges => _auth.authStateChanges();
    }
