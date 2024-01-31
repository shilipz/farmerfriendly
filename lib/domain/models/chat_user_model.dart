// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatMessage {
  final String senderId;
  final String adminId;
  final String message;
  final DateTime timestamp;
  final bool? isSentbyme;
  ChatMessage({
    this.isSentbyme,
    required this.senderId,
    required this.adminId,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'receiverId': adminId,
      'message': message,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'isSentbyme': isSentbyme,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      senderId: map['senderId'] as String,
      adminId: map['receiverId'] as String,
      message: map['message'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      isSentbyme: map['isSentbyme'] != null ? map['isSentbyme'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) =>
      ChatMessage.fromMap(json.decode(source) as Map<String, dynamic>);
}
