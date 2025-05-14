import 'package:flutter/material.dart';

class ProfileInfoItem extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onEdit;

  const ProfileInfoItem({
    Key? key,
    required this.title,
    required this.value,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF263553),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF263553),
                ),
              ),
            ],
          ),
          const Spacer(),
          TextButton(
            onPressed: onEdit,
            child: const Text(
              'Thay đổi',
              style: TextStyle(
                color: Color(0xFFFF7D54),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
