import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../signin_signup/providers/auth_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool showSearchBar;
  final bool showUpgradeButton;
  final bool showAvatar;
  final bool showTitle;
  final bool showIcon;
  final VoidCallback? onSearchTap;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showBackButton = false,
    this.showSearchBar = false,
    this.showUpgradeButton = false,
    this.showAvatar = true,
    this.showTitle = true,
    this.showIcon = false,
    this.onSearchTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 16,
        right: 16,
        bottom: 8,
      ),
      color: Color(0xFF2B3A5C), // Màu nền xanh đậm
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Nút back hoặc tiêu đề
              Row(
                children: [
                  if (showBackButton)
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  if (showBackButton) SizedBox(width: 8),
                  if (!showIcon && showTitle)
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (showIcon)
                    Container(
                      height: 36,
                      // Đặt chiều cao bằng đường kính của CircleAvatar (2 * 18 = 36)
                      width: 90,
                      // Giữ chiều rộng để logo không bị méo
                      child: Image.asset(
                        'assets/images/logo_text_white.png',
                        fit: BoxFit.contain, // Giữ tỷ lệ logo
                      ),
                    ),
                ],
              ),

              // Nút nâng cấp và avatar
              Row(
                children: [
                  if (showUpgradeButton)
                    ElevatedButton.icon(
                      onPressed: () {
                        // Xử lý khi nhấn nút nâng cấp
                      },
                      icon: Icon(Icons.diamond, color: Colors.white, size: 16),
                      label: Row(
                        children: [
                          Text(
                            'Nâng cấp',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF8A65),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                  if (showUpgradeButton && showAvatar) SizedBox(width: 8),
                  if (showAvatar)
                    GestureDetector(
                      onTap: () async {
                        // // Chuyển đến màn hình profile
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(builder: (_) => ProfileScreen()),
                        // );
                        await authProvider.signOut();
                      },
                      child: CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                          authProvider.user!.photoURL!,
                        ), // Dùng ảnh từ URL
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                ],
              ),
            ],
          ),

          // Thanh tìm kiếm (nếu cần)
          if (showSearchBar)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: GestureDetector(
                onTap: onSearchTap,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        'Tìm tên sách, tác giả, mentor...',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 90);
}
