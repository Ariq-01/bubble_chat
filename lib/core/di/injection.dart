import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zerochat/data/repositories/firebase_auth_repository_impl.dart';
import 'package:zerochat/domain/repositories/auth_repository.dart';
import 'package:zerochat/firebase_options_dev.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // External dependencies
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => GoogleSignIn(
        serverClientId:
            '254382477367-vak62vu0hbqpg4vciq0q0hcduqh2gt00.apps.googleusercontent.com',
      ));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => FirebaseAuthRepositoryImpl(sl(), sl()),
  );
}
