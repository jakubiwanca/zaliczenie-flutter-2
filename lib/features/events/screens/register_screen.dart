import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/features/auth/logic/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Rejestracja')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Hasło'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: _loading ? null : () async {
                setState(() {
                  _loading = true;
                  _error = null;
                });
                try {
                  await auth.register(_emailController.text.trim(), _passwordController.text.trim());
                  // Po rejestracji przekieruj na ekran wydarzeń
                  Navigator.pushReplacementNamed(context, '/events');
                } catch (e) {
                  setState(() {
                    _error = e.toString();
                  });
                } finally {
                  setState(() {
                    _loading = false;
                  });
                }
              },
              child: _loading ? const CircularProgressIndicator() : const Text('Zarejestruj się'),
            ),
          ],
        ),
      ),
    );
  }
}
