import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cucumber_app/domain/models/chat_user_model.dart';
import 'package:cucumber_app/presentation/widgets/signing_widgets.dart';
import 'package:cucumber_app/utils/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String adminId;
  const ChatScreen({super.key, required this.adminId});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();

  void _handleSubmitted(String text) {
    _textController.clear();
    final user = FirebaseAuth.instance.currentUser;
    ChatMessage message = ChatMessage(
      isSentbyme: false,
      senderId: user!.uid,
      adminId: widget.adminId,
      message: text,
      timestamp: DateTime.now(),
    );

    String chatId = user.uid + widget.adminId;
    String messageId = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    String chatId = user!.uid + widget.adminId;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhite,
        leading: const Arrowback(backcolor: homeorange),
        title: const Text(
          'Chat with our Executive',
          style: TextStyle(color: homeorange),
        ),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(chatId)
                  .collection('messages')
                  .orderBy('timestamp', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: snapshot.data!.docs.length,
                  reverse: false,
                  itemBuilder: (_, index) {
                    var message = ChatMessage.fromMap(snapshot.data!.docs[index]
                        .data() as Map<String, dynamic>);
                    return _buildMessage(message);
                  },
                );
              },
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    bool isSender = message.isSentbyme ?? true;

    CrossAxisAlignment crossAxisAlignment =
        isSender ? CrossAxisAlignment.start : CrossAxisAlignment.end;

    Color messageColor = isSender ? homeorange : Colors.grey;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Material(
            borderRadius: BorderRadius.circular(8.0),
            color: messageColor,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {},
                child: Text(
                  message.message,
                  style: const TextStyle(color: kwhite, fontSize: 15),
                ),
              ),
            ),
          ),
          Text(
            DateFormat('hh:mm a').format(message.timestamp),
            style: const TextStyle(fontSize: 12.0, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).canvasColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    const InputDecoration.collapsed(hintText: 'Send a message'),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.send,
                color: Colors.grey,
              ),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ],
        ),
      ),
    );
  }
}
