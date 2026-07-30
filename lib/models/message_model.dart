import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String sender;
  final String text;
  final String type; // 'text', 'photo', 'voice', 'location'
  final String mediaUrl;
  final double? latitude;
  final double? longitude;
  final Timestamp timestamp;

  MessageModel({
    required this.sender,
    required this.text,
    required this.type,
    required this.mediaUrl,
    this.latitude,
    this.longitude,
    required this.timestamp,
  });

  // Firestore ထဲကရတဲ့ Data ကို App ထဲမှာ သုံးလို့ရအောင် Object ပုံစံပြောင်းတာပါ
  factory MessageModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return MessageModel(
      sender: data['sender'] ?? '',
      text: data['text'] ?? '',
      type: data['type'] ?? 'text',
      mediaUrl: data['mediaUrl'] ?? '',
      latitude: data['latitude'],
      longitude: data['longitude'],
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }

  // App ထဲက Data ကို Firebase Database ဆီ ပို့ဖို့အတွက် Map ပြောင်းတာပါ
  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'text': text,
      'type': type,
      'mediaUrl': mediaUrl,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp,
    };
  }
}
