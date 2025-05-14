// processing_dialog.dart
import 'package:flutter/material.dart';

class ProcessingDialog extends StatelessWidget {
  final String? message;

  const ProcessingDialog({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 20),
            Text(message ?? "Đang xử lý..."),
          ],
        ),
      ),
    );
  }
}

// Hàm gọi dialog
void showProcessingDialog(BuildContext context, {String? message}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => ProcessingDialog(message: message),
  );
}

// Hàm đóng dialog (đảm bảo an toàn)
void hideProcessingDialog(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.pop(context);
  }
}
