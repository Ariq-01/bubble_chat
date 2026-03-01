import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';
import '../../domain/entities/auth_firebase.dart';
import '../../domain/repositories/auth_repository.dart';

class FirebaseAuthRepositoryImpl implements AuthRepository {
  final fb.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthRepositoryImpl(this._firebaseAuth, this._googleSignIn);

  @override
  Stream<AppUser?> get user => _firebaseAuth.authStateChanges().map((fbUser) {
        if (fbUser == null) return null;
        return AppUser(
          id: fbUser.uid,
          email: fbUser.email,
          displayName: fbUser.displayName,
          photoUrl: fbUser.photoURL,
        );
      });

  @override
  Future<void> SignInWithGoogle() async {
    try {
      // FIX #1: = bukan ==
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // FIX #2: GoogleAuthProvider bukan GoogleAuthprovider
      // FIX #3: nama variabel konsisten → credential
      final fb.AuthCredential credential = fb.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      throw Exception('login failed: $e');
    }
  }

  @override
  // FIX #5: sign out dari Google juga agar account picker muncul kembali
  Future<void> SignOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }




}