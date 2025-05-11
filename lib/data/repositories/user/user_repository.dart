import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gluco_scan/data/repositories/authentication/authentication_repository.dart';
import 'package:gluco_scan/features/personalization/models/user_model.dart';
import 'package:gluco_scan/utils/exceptions/firebase_exceptions.dart';
import 'package:gluco_scan/utils/exceptions/format_exceptions.dart';
import 'package:gluco_scan/utils/exceptions/platform_exceptions.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Function to save user record to Firestore
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
    } on LFirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on LFormatException catch (_) {
      throw const LFormatException();
    } on LPlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Function to get user record from Firestore
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on LFirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on LFormatException catch (_) {
      throw const LFormatException();
    } on LPlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Function to update user record in Firestore
  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      await _db
          .collection('Users')
          .doc(updateUser.id)
          .update(updateUser.toJson());
    } on LFirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on LFormatException catch (_) {
      throw const LFormatException();
    } on LPlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Update a single field in user record
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on LFirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on LFormatException catch (_) {
      throw const LFormatException();
    } on LPlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Function to delete user record from Firestore
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection('Users').doc(userId).delete();
    } on LFirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on LFormatException catch (_) {
      throw const LFormatException();
    } on LPlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Update any Image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on LFirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on LFormatException catch (_) {
      throw const LFormatException();
    } on LPlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}
