import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/features/auth/models/user_model.dart';

class FirestoreService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference get _usersCollection => _firestore.collection('users');
  // 1. User ka data Firestore me save karna (Sign up ke foran baad)
  Future<void> saveUser(UserModel user) async {
    await _usersCollection.doc(user.uid).set(user.toMap());
  }
  // 2. User ka data Firestore se fetch karna (Profile load karne ke liye)
  Future<UserModel?> getUser(String uid) async {
    final DocumentSnapshot doc = await _usersCollection.doc(uid).get();
    if (doc.exists && doc.data() != null) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }
  Future<void> updateUser(UserModel user) async {
    await _usersCollection.doc(user.uid).update(user.toMap());
  }
   // Get all categories
  Future<QuerySnapshot<Map<String, dynamic>>> getCategories() async {
    return await _firestore.collection('categories').get();
  }
   // Get all products
  Future<QuerySnapshot<Map<String, dynamic>>> getProducts() async {
    return await _firestore.collection('products').get();
  }
    // Get featured products
  Future<QuerySnapshot<Map<String, dynamic>>> getFeaturedProducts() async {
    return await _firestore
        .collection('products')
        .where('isFeatured', isEqualTo: true)
        .get();
  }
   // Get flash sale products
  Future<QuerySnapshot<Map<String, dynamic>>> getFlashSaleProducts() async {
    return await _firestore
        .collection('products')
        .where('isFlashSale', isEqualTo: true)
        .get();
  }
}