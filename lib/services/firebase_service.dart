import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/message_model.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // ၁။ စာတိုပေးပို့ခြင်း
  Future<void> sendTextMessage(String room, String sender, String text) async {
    MessageModel msg = MessageModel(
      sender: sender,
      text: text,
      type: 'text',
      mediaUrl: '',
      timestamp: Timestamp.now(),
    );
    await _db.collection('rooms').doc(room).collection('messages').add(msg.toMap());
  }

  // ၂။ ဖိုင်တင်ခြင်း (ဓာတ်ပုံ သို့မဟုတ် အသံဖိုင်)
  Future<String> uploadFile(File file, String path) async {
    Reference ref = _storage.ref().child(path);
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  // ၃။ ပုံ သို့မဟုတ် အသံဖိုင် ပါဝင်သော မက်ဆေ့ခ်ျ ပို့ခြင်း
  Future<void> sendMediaMessage(String room, String sender, String fileUrl, String type) async {
    MessageModel msg = MessageModel(
      sender: sender,
      text: '',
      type: type,
      mediaUrl: fileUrl,
      timestamp: Timestamp.now(),
    );
    await _db.collection('rooms').doc(room).collection('messages').add(msg.toMap());
  }

  // ၄။ တည်နေရာ (GPS) ပို့ခြင်း
  Future<void> sendLocationMessage(String room, String sender, double lat, double lon) async {
    MessageModel msg = MessageModel(
      sender: sender,
      text: 'https://maps.google.com/?q=$lat,$lon',
      type: 'location',
      mediaUrl: '',
      latitude: lat,
      longitude: lon,
      timestamp: Timestamp.now(),
    );
    await _db.collection('rooms').doc(room).collection('messages').add(msg.toMap());
  }

  // ၅။ စာတိုများ တိုက်ရိုက်ဖတ်ရှုခြင်း (Stream)
  Stream<List<MessageModel>> getMessages(String room) {
    return _db
        .collection('rooms')
        .doc(room)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MessageModel.fromFirestore(doc))
            .toList());
  }
}
