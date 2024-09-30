import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfridge/controllers/google_auth_controller.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPage();
}

class _AuthPage extends State<AuthPage> {
  // Simples tela de autenticação via google
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Fridge'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await GoogleAuthController().signInWithGoogle();
          },
          child: Text('Login com Google'),
        ),
      ),
    );
  }
}
