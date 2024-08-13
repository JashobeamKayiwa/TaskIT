import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StoreData {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    try {
      final ref = _storage.ref().child(childName);
      final uploadTask = ref.putData(file);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return ''; // Handle the error (return an empty string for now)
    }
  }

  Future<String> saveData({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
    required Uint8List file, required String,
  }) async {
    try {
      final imageUrl = await uploadImageToStorage('profileImage', file);
      await _firestore.collection('UpdateProfile').add({
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'password': password,
        'imageLink': imageUrl,
      });
      return 'success';
    } catch (err) {
      return err.toString();
    }
  }
}
