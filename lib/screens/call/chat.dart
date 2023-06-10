import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../config.dart';
import '../../config.dart';

class ChatScreen extends StatefulWidget {
  final String userId;

  ChatScreen({required this.userId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Service Chat'),
        backgroundColor: Colors.tealAccent.shade700,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('chats')
                    .doc(widget.userId)
                    .collection('messages')
                    .orderBy('timestamp',descending: true)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  FirebaseFirestore.instance.collection('chats').doc(widget.userId).set(
                      {"user": FirebaseAuth.instance.currentUser!.displayName});
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  List<QueryDocumentSnapshot> messages = snapshot.data!.docs;

                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      String senderId = messages[index]['senderId'];
                      String message = messages[index]['message'];

                      bool isSenderAdmin = senderId == kAdminEmail;
                      Color bubbleColor = isSenderAdmin ?Colors.grey.shade300: Colors.tealAccent.shade700  ;
                      CrossAxisAlignment alignment = isSenderAdmin ? CrossAxisAlignment.start : CrossAxisAlignment.end;

                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        child: Column(
                          crossAxisAlignment: alignment,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: bubbleColor,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                message,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 3.0),
                            Text(
                              isSenderAdmin ? 'Customer Support Center' : 'User',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      sendMessage(_textEditingController.text);
                      _textEditingController.clear();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendMessage(String message) {
    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.userId)
        .collection('messages')
        .add({
      'senderId': kAdminEmail,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
