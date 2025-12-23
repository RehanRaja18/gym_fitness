import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _db = FirebaseDatabase.instance.ref();

  /// LOGIN
  Future<User?> login({
    required String email,
    required String password,
  }) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = result.user;

    if (user != null) {
      await _saveUserToDatabase(user);
    }

    return user;
  }

  /// SAVE USER TO REALTIME DATABASE
  Future<void> _saveUserToDatabase(User user) async {
    await _db.child('users/${user.uid}').set({
      'email': user.email,
      'name': user.email?.split('@')[0],
      'createdAt': DateTime.now().toIso8601String(),
    });
  }

  /// LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
  }
}
