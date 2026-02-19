import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        // listening if use in  app
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // if user has login
          if (snapshot.hasData) {
            return HomePage();
          }
          // if user did not login
          else {
            return LoginPage();
          }
        },
      ),
    );
  }
}