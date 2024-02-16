// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:FarmerFriendly/domain/models/chat_user_model.dart';
import 'package:FarmerFriendly/main.dart';
import 'package:FarmerFriendly/presentation/widgets/contact_form_widgets.dart';
import 'package:FarmerFriendly/presentation/widgets/signing_widgets.dart';
import 'package:FarmerFriendly/utils/constants/constants.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  DateTime? _lastDisplayedDate;
  void _handleSubmitted(String text) {
    _textController.clear();
    final user = FirebaseAuth.instance.currentUser;
    ChatMessage message = ChatMessage(
      isSentbyme: false,
      senderId: user!.uid,
      adminId: 'adminId',
      message: text,
      timestamp: DateTime.now(),
    );

    String chatId = '${user.uid}adminId';
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
    String chatId = '${user!.uid}adminId';
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.099),
          child: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient:
                        LinearGradient(colors: [Colors.green, Colors.teal])),
              ),
              leading: const Arrowback(backcolor: kwhite),
              title: const Captions(
                  captionColor: kwhite, captions: 'Talk to the team!')),
        ),
        body: Container(
          color: Colors.yellow[100],
          child: Column(
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
                        var message = ChatMessage.fromMap(
                            snapshot.data!.docs[index].data()
                                as Map<String, dynamic>);
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
        ),
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    bool isSender = message.isSentbyme ?? true;

    CrossAxisAlignment crossAxisAlignment =
        message.isSentbyme! ? CrossAxisAlignment.start : CrossAxisAlignment.end;

    Color messageColor = isSender ? Colors.green : Colors.teal;

    bool showDate = _shouldShowDate(message);

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          if (showDate)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: Text(
                  _formatDate(message.timestamp),
                  style: const TextStyle(fontSize: 18.0, color: Colors.black),
                ),
              ),
            ),
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
            style: const TextStyle(fontSize: 12.0, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  bool _shouldShowDate(ChatMessage message) {
    if (_lastDisplayedDate == null) {
      _lastDisplayedDate = message.timestamp;
      return true;
    }
    bool showDate = !isSameDay(_lastDisplayedDate!, message.timestamp);
    _lastDisplayedDate = message.timestamp;

    return showDate;
  }

  String _formatDate(DateTime dateTime) {
    // Format the date according to your requirements
    return DateFormat('MMMM d, y').format(dateTime);
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
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
