import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfridge/controllers/google_auth_controller.dart';
import 'package:smartfridge/controllers/google_drive_controller.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPage();
}

class _AuthPage extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    final user = GoogleAuthController().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Fridge'),
      ),
      body: Center(
        child: user == null
            ? ElevatedButton(
                onPressed: () async {
                  await GoogleAuthController().signInWithGoogle();
                  setState(() {});
                },
                child: Text('Login com Google'),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.photoURL ?? ''),
                    radius: 40,
                  ),
                  SizedBox(height: 16),
                  Text('Bem-vindo, ${user.displayName}'),
                  SizedBox(height: 8),
                  Text(user.email ?? ''),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await GoogleAuthController().signOut();
                      setState(() {});
                    },
                    child: Text('Logout'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await GoogleDriveController().uploadDatabaseToDrive();
                    },
                    child: Text('Upload Database to Drive'),
                  ),
                ],
              ),
      ),
    );
  }
}