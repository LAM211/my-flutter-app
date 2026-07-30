import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ota_update/ota_update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateService {
  static Future<void> checkForUpdate(BuildContext context) async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String currentVersion = packageInfo.version; 

      DocumentSnapshot updateDoc = await FirebaseFirestore.instance
          .collection('settings')
          .doc('app_update')
          .get();

      if (!context.mounted) return;

      if (updateDoc.exists) {
        String latestVersion = updateDoc['version'];
        String downloadUrl = updateDoc['url'];

        if (currentVersion != latestVersion) {
          _showUpdateDialog(context, downloadUrl);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static void _showUpdateDialog(BuildContext context, String apkUrl) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Update ဗားရှင်းအသစ် ရပါပြီ"),
        content: const Text("ပိုမိုကောင်းမွန်တဲ့ စွမ်းဆောင်ရည်နဲ့ Features အသစ်တွေရဖို့ အခုပဲ Update လုပ်လိုက်ပါဗျာ။"),
        actions: [
          TextButton(
            onPressed: () {
              _startOtaUpdate(apkUrl);
              Navigator.pop(context);
            },
            child: const Text("UPDATE လုပ်မည်"),
          ),
        ],
      ),
    );
  }

  static void _startOtaUpdate(String url) {
    try {
      OtaUpdate().execute(
        url,
        destinationFilename: 'akarizchat_update.apk',
      ).listen(
        (OtaEvent event) {
          print('${event.status} : ${event.value}');
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
