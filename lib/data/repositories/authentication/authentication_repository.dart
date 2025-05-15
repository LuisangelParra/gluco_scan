// lib/data/repositories/authentication/authentication_repository.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gluco_scan/features/dashboard/screen/dashboard.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:gluco_scan/data/repositories/user/user_repository.dart';
import 'package:gluco_scan/features/authentication/screens/login/login.dart';
import 'package:gluco_scan/features/authentication/screens/onboarding/onboarding.dart';
import 'package:gluco_scan/features/authentication/screens/signup/verify_email.dart';
import 'package:gluco_scan/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:gluco_scan/utils/exceptions/firebase_exceptions.dart';
import 'package:gluco_scan/utils/exceptions/format_exceptions.dart';
import 'package:gluco_scan/utils/exceptions/platform_exceptions.dart';
import 'package:gluco_scan/utils/local_storage/storage_utility.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    super.onReady();
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  /// Decide a qué pantalla ir al iniciar la app
  void screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        // Inicializa tu storage con el uid
        await LLocalStorage.init(user.uid);
        // Navega a la pantalla principal (home)
        Get.offAll(() => const DashboardScreen());
      } else {
        // Si no ha verificado el email, muéstrale la pantalla de verificación
        Get.offAll(() => VerifyEmailScreen(email: user.email));
      }
    } else {
      // Marcador de primer arranque
      deviceStorage.writeIfNull('IsFirstTime', true);
      final isFirstTime = deviceStorage.read('IsFirstTime') as bool;
      if (isFirstTime) {
        Get.offAll(() => const OnBoardingScreen());
      } else {
        Get.offAll(() => const LoginScreen());
      }
    }
  }

  /// LOGIN con email/contraseña
Future<UserCredential> loginUserWithEmailAndPassword(
    String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw LFirebaseAuthException(e.code);
    } on LFirebaseException catch (e) {
      throw e;
    } on FormatException catch (_) {
      throw const LFormatException();
    } on PlatformException catch (e) {
      throw LPlatformException(e.code);
    } catch (e) {
      throw 'Error desconocido. Intenta de nuevo.';
    }
  }


  /// REGISTRO con email/contraseña
  Future<UserCredential> registerUserWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw LFirebaseAuthException(e.code).message;
    } on LFirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on FormatException {
      throw const LFormatException();
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (_) {
      throw 'Algo salió mal. Inténtalo de nuevo.';
    }
  }

  /// ENVÍO de verificación de email
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw LFirebaseAuthException(e.code).message;
    } on LFirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on FormatException {
      throw const LFormatException();
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (_) {
      throw 'Algo salió mal. Inténtalo de nuevo.';
    }
  }

  /// RESET de contraseña
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw LFirebaseAuthException(e.code).message;
    } on LFirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on FormatException {
      throw const LFormatException();
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (_) {
      throw 'Algo salió mal. Inténtalo de nuevo.';
    }
  }

  /// RE-AUTENTICAR al usuario  
  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await _auth.currentUser?.reauthenticateWithCredential(cred);
    } on FirebaseAuthException catch (e) {
      throw LFirebaseAuthException(e.code).message;
    } on LFirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on FormatException {
      throw const LFormatException();
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (_) {
      throw 'Algo salió mal. Inténtalo de nuevo.';
    }
  }

  /// LOGIN con Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      if (googleAuth == null) return null;
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw LFirebaseAuthException(e.code).message;
    } on LFirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on FormatException {
      throw const LFormatException();
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Google sign-in error: $e');
      return null;
    }
  }

  /// CERRAR SESIÓN
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw LFirebaseAuthException(e.code).message;
    } on LFirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on FormatException {
      throw const LFormatException();
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (_) {
      throw 'Algo salió mal. Inténtalo de nuevo.';
    }
  }

  /// ELIMINAR CUENTA
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw LFirebaseAuthException(e.code).message;
    } on LFirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on FormatException {
      throw const LFormatException();
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (_) {
      throw 'Algo salió mal. Inténtalo de nuevo.';
    }
  }
}
