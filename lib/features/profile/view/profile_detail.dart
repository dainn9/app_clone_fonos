import 'package:flutter/material.dart';
import '../../../core/design_systems/design_system_export.dart';
import '../components/profile_avatar.dart';
import '../components/profile_info_item.dart';
import '../components/social_account_item.dart';

class ProfileDetail extends StatelessWidget {
  const ProfileDetail({super.key});

  @override
  Widget build(BuildContext context) {
    // Fake data
    final userData = {
      'name': 'Phạm Thủy Tiên',
      'username': 'khsmdh60',
      'loginMethod': 'Số điện thoại',
      'phone': '+84336107518',
      'avatar': 'assets/images/avatar.jpg', // Thay bằng đường dẫn thực tế
      'socialAccounts': [
        {
          'platform': 'Facebook',
          'name': 'Đinh Quốc Bảo',
          'avatar': 'assets/images/fb_avatar.jpg', // Thay bằng đường dẫn thực tế
        },
        {
          'platform': 'Google',
          'name': 'Đinh Quoc Bao',
          'avatar': 'assets/images/google_avatar.jpg', // Thay bằng đường dẫn thực tế
        },
      ],
    };

    return Scaffold(
      backgroundColor: const Color(0xFF3A4A6D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3A4A6D),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Thông tin cá nhân',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  ProfileAvatar(avatarUrl: userData['avatar'] as String),
                  const SizedBox(height: 12),
                  Text(
                    userData['name'] as String,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF263553),
                    ),
                  ),
                  const SizedBox(height: 6),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF7A8BB3),
                      ),
                      children: [
                        const TextSpan(text: 'Tên người dùng: '),
                        TextSpan(
                          text: userData['username'] as String,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF7A8BB3),
                      ),
                      children: [
                        const TextSpan(text: 'Đã đăng nhập bằng: '),
                        TextSpan(
                          text: userData['loginMethod'] as String,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F5)),
                  ProfileInfoItem(
                    title: 'Tên',
                    value: userData['name'] as String,
                    onEdit: () {
                      print("Thay đổi tên");
                    },
                  ),
                  const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F5)),
                  ProfileInfoItem(
                    title: 'Số điện thoại',
                    value: userData['phone'] as String,
                    onEdit: () {
                      print("Thay đổi số điện thoại");
                    },
                  ),
                  const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F5)),
                  ...(userData['socialAccounts'] as List).map((account) {
                    final Map<String, dynamic> socialAccount = account as Map<String, dynamic>;
                    return Column(
                      children: [
                        SocialAccountItem(
                          platform: socialAccount['platform'] as String,
                          name: socialAccount['name'] as String,
                          avatarUrl: socialAccount['avatar'] as String,
                        ),
                        const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F5)),
                      ],
                    );
                  }).toList(),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: () {
                      // Xử lý sự kiện xóa tài khoản
                      print("Xóa tài khoản");
                    },
                    child: const Text(
                      'Xóa tài khoản',
                      style: TextStyle(
                        color: Color(0xFF7A8BB3),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
