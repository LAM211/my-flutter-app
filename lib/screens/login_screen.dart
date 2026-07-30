import 'package:flutter/material.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();

  void _enterChat() {
    if (_nameController.text.trim().isNotEmpty && _roomController.text.trim().isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(
            senderName: _nameController.text.trim(),
            roomName: _roomController.text.trim().toLowerCase(),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('နာမည်နှင့် Chat Room အမည်ကို အရင်ဖြည့်ပေးပါဦးဗျာ!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Clan Chat Logo သို့မဟုတ် Icon
              const Icon(
                Icons.sports_esports,
                size: 100,
                color: Colors.indigoAccent,
              ),
              const SizedBox(height: 20),
              const Text(
                'CLAN CHAT',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Brothers PUBG Chat System သို့ ကြိုဆိုပါတယ်',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 40),
              
              // Name Input
              TextField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'သင့်နာမည် (Nickname)',
                  labelStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.person, color: Colors.indigoAccent),
                  filled: true,
                  fillColor: const Color(0xFF1E2330),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Room Name Input
              TextField(
                controller: _roomController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Chat Room အမည် (ဥပမာ- pubg_room1)',
                  labelStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.meeting_room, color: Colors.indigoAccent),
                  filled: true,
                  fillColor: const Color(0xFF1E2330),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              
              // Enter Button
              ElevatedButton(
                onPressed: _enterChat,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigoAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'အခန်းထဲသို့ ဝင်ရန်',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
