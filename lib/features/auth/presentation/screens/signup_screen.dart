import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/user_service.dart';
import '../../domain/models/user_model.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();

  String _role = 'member';
  bool _loading = false;

  Future<void> _signup() async {
    setState(() => _loading = true);

    try {
      final cred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );

      final user = AppUser(
        uid: cred.user!.uid,
        email: _email.text.trim(),
        name: _name.text.trim(),
        role: _role,
        createdAt: DateTime.now(),
      );

      await UserService().createUser(user);

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _email,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 12),

            /// Role Selector
            DropdownButtonFormField<String>(
              value: _role,
              items: const [
                DropdownMenuItem(
                  value: 'member',
                  child: Text('Gym Member'),
                ),
                DropdownMenuItem(
                  value: 'gym_owner',
                  child: Text('Gym Owner'),
                ),
              ],
              onChanged: (value) => _role = value!,
              decoration: const InputDecoration(labelText: 'Role'),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _loading ? null : _signup,
              child: _loading
                  ? const CircularProgressIndicator()
                  : const Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}
