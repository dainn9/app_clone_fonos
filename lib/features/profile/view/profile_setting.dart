import 'package:app_clone_fonos/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/design_systems/design_system_export.dart';
import '../components/profile_setting_header.dart';
import '../components/setting_item.dart';

class ProfileSettingScreen extends StatelessWidget {
  const ProfileSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewmodel>(context);
    final user = authViewModel.user;

    if (user == null) {
      Future.microtask(() {
        Navigator.pushNamedAndRemoveUntil(context, '/sign_in', (_) => false);
      });
      return const SizedBox.shrink(); // Tránh build lỗi
    }

    final userData = {
      'name': user.displayName ?? 'Người dùng',
      'avatar': user.photoURL ?? '',
    };

    final settingItems = [
      {
        'icon': Icons.download_outlined,
        'title': 'Cài đặt dữ liệu và tải xuống',
        'route': '/data-settings',
      },
      {
        'icon': Icons.qr_code_scanner_outlined,
        'title': 'Quét mã QR',
        'route': '/qr-scanner',
      },
      {
        'icon': Icons.card_membership_outlined,
        'title': 'Thông tin Gói hội viên',
        'route': '/membership-info',
      },
      {
        'icon': Icons.info_outline,
        'title': 'Về chúng tôi',
        'route': '/about-us',
      },
      {
        'icon': Icons.article_outlined,
        'title': 'Điều khoản sử dụng',
        'route': '/terms-of-use',
      },
      {
        'icon': Icons.lock_outline,
        'title': 'Chính sách bảo mật',
        'route': '/privacy-policy',
      },
    ];
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
          'Cài đặt',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          ProfileHeader(userData: userData),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  ...settingItems.map((item) => SettingItem(
                    icon: item['icon'] as IconData,
                    title: item['title'] as String,
                    onTap: () {
                      Navigator.pushNamed(context, item['route'] as String);
                    },
                  )).toList(),
                  const Spacer(),
                  TextButton(
                    onPressed: () async {
                      // Xử lý sự kiện đăng xuất
                      await authViewModel.signOut(context);
                    },
                    child: const Text(
                      'Đăng xuất',
                      style: TextStyle(
                        color: Color(0xFF647AB9),
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
