import 'package:flutter/material.dart';
import '../services/auth_service.dart'; 

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Method to logout
  void logout() {
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat App"),
        actions: [
          // button to logout
          IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: const Center(child: Text("You are in home page!")),
    );
  }
}