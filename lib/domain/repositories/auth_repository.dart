import '../entities/auth_firebase.dart';

abstract class AuthRepository {
  Future<void> SignInWithGoogle();
  Future<void> SignOut();
  Stream<AppUser?> get user; 

}