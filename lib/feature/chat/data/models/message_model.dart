import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp/core/services/firebase_constants.dart';

class MessageModel {
  final String text;
  final String senderId;
  final DateTime time;
  final String name;
  final String image;

  const MessageModel({
    required this.text,
    required this.senderId,
    required this.time,
    required this.name,
    required this.image,
  });

  factory MessageModel.fromFirestore(Map<String, dynamic> json) => MessageModel(
    text: json[FirebaseConstants.textKey] ?? '',
    senderId: json[FirebaseConstants.senderIdKey] ?? '',
    time:((json[FirebaseConstants.timeKey]) as Timestamp).toDate(),
    name: json[FirebaseConstants.nameKey] ?? '',
    image: json[FirebaseConstants.imagePathKey] ?? '',
  );

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        text: json['text'] ?? '',
        senderId: json['senderID'] ?? '',
        time: json['time'] ?? '',
        name: json['sender_name'] ?? '',
        image: json['sender_image'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'senderID': senderId,
        'time': time,
        'sender_name': name,
        'sender_image': image,
      };
}
