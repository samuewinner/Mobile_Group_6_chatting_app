import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser ? Colors.green[600] : Colors.grey[800],
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(15),
          topRight: const Radius.circular(15),
          bottomLeft: isCurrentUser ? const Radius.circular(15) : const Radius.circular(0),
          bottomRight: isCurrentUser ? const Radius.circular(0) : const Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 25),
      child: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}