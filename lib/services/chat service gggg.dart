import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import '../models/message.dart';

class ChatService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Update FCM Token in Firestore (Fixed to handle new users)
  Future<void> updateFCMToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    String userId = _auth.currentUser!.uid;

    if (token != null) {
      await _db.collection('Users').doc(userId).set(
        {'fcmToken': token},
        SetOptions(merge: true),
      ); // Inatengeneza au ina-merge bila kufuta data zingine
    }
  }

  // Send Message and Trigger Notification
  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    // Save message to database
    await _db
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());

    // Send push notification to receiver
    await sendPushNotification(receiverId, message, currentUserEmail);
  }

  // Push Notification Logic
  Future<void> sendPushNotification(
    String receiverId,
    String message,
    String senderEmail,
  ) async {
    try {
      DocumentSnapshot userDoc = await _db
          .collection('Users')
          .doc(receiverId)
          .get();

      // Angalia kama mpokeaji ana token
      if (userDoc.exists && userDoc.data() != null) {
        String? receiverToken =
            (userDoc.data() as Map<String, dynamic>)['fcmToken'];

        if (receiverToken != null) {
          await http.post(
            Uri.parse('https://fcm.googleapis.com/fcm/send'),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization': 'key=YOUR_SERVER_KEY_HERE', // WEKA KEY YAKO HAPA
            },
            body: jsonEncode(<String, dynamic>{
              'priority': 'high',
              'data': <String, dynamic>{
                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                'status': 'done',
                'body': message,
                'title': 'New Message from $senderEmail',
              },
              'notification': <String, dynamic>{
                'title': 'New Message from $senderEmail',
                'body': message,
                'android_channel_id': 'chat_messages',
              },
              'to': receiverToken,
            }),
          );
        }
      }
    } catch (e) {
      //("Error sending notification: $e");
    }
  }

  // Get User Stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _db.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  // Get Messages Stream
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _db
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
