import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  final nameController = TextEditingController();

  late DatabaseReference userRef;

  @override
  void initState() {
    super.initState();
    userRef = FirebaseDatabase.instance.ref('users/${user.uid}');
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final snapshot = await userRef.get();
    if (snapshot.exists) {
      final data = snapshot.value as Map;
      nameController.text = data['name'] ?? '';
    }
  }

  Future<void> _updateProfile() async {
    await userRef.update({
      'name': nameController.text.trim(),
      'email': user.email,
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated')),
      );
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.person, size: 80),
            const SizedBox(height: 20),

            Text(
              user.email ?? '',
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _updateProfile,
                child: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
