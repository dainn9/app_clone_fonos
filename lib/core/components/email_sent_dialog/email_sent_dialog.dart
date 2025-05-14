import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../processing_dialog/processing_dialog.dart';

class EmailSentDialog extends StatelessWidget {
  const EmailSentDialog({Key? key}) : super(key: key);

  // Hàm mở ứng dụng email
  void _openEmailApp(BuildContext context) async {
    Navigator.pop(context); // Đóng dialog trước
    final Uri emailUri = Uri(scheme: 'mailto');
    if (await canLaunchUrl(emailUri)) {
      showProcessingDialog(context);
      await launchUrl(
        emailUri,
        mode: LaunchMode.externalApplication, // Mở ứng dụng ngoài
      );
      hideProcessingDialog(context);
    } else {
      debugPrint("Không thể mở ứng dụng email.");
      print(await canLaunchUrl(emailUri));
      print(emailUri.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: const Color(0xFFFEE8E6),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/images/mail_icon.png',
                height: 70,
                width: 70,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Đã gửi mail chứa link đăng nhập",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A2B47),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _openEmailApp(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF7B5C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "Mở ứng dụng email",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Để sau",
                style: TextStyle(fontSize: 16, color: Color(0xFF1A2B47)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
