import 'package:app_clone_fonos/features/home/view/home_view.dart';
import 'package:app_clone_fonos/features/home/view/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../core/components/custom_button/custom_button.dart';
import '../../../core/components/circle_icon_button.dart';
import '../../../core/components/processing_dialog/processing_dialog.dart';
import '../providers/auth_provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isTermsAccepted = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    // Nếu đã đăng nhập, chuyển đến màn hình chính
    if (authProvider.isLoggedIn) {
      return MainScreen();
    }
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2C3E50), Color(0xFF1E3A5F), Color(0xFF172B4D)],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              CircleIconButton(
                icon: Icons.close,
                right: 10,
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    Navigator.pushReplacementNamed(context, '/onboarding');
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (authProvider.errorMessage != null)
                      Text(
                        authProvider.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    const Spacer(),
                    const Text(
                      'Đăng nhập',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Nghe không giới hạn chương đầu của tất cả sách nói, và nhiều nội dung khác.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 40),
                    CustomButton(
                      text: 'Tiếp tục với Google',
                      icon: FontAwesomeIcons.google,
                      iconColor: Colors.blue,
                      onPressed: () async {
                        showProcessingDialog(context);
                        await authProvider.signInWithGoogle();
                        hideProcessingDialog(context);
                      },
                    ),

                    const SizedBox(height: 16),
                    // Phần chia cách "HOẶC"
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Divider(color: Colors.white30, thickness: 1),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Text(
                              'HOẶC',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Divider(color: Colors.white30, thickness: 1),
                          ),
                        ],
                      ),
                    ),

                    // Các nút đăng nhập khác (Email và Điện thoại)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildCircleButton(
                          icon: Icons.email_outlined,
                          color: Colors.orange,
                          onPressed:
                              () => Navigator.pushNamed(
                                context,
                                '/email_link',
                              ),
                        ),
                        const SizedBox(width: 24),
                        _buildCircleButton(
                          icon: Icons.phone,
                          color: Colors.red,
                          onPressed: () {
                            // Xử lý đăng nhập với Điện thoại
                            Navigator.pushReplacementNamed(
                              context,
                              '/phonesignin',
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    // Phần đăng ký và điều khoản
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Chưa có tài khoản? ',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 16,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                '/register',
                              );
                            },
                            child: const Text(
                              'Đăng ký',
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),

                    // Checkbox điều khoản sử dụng
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: 1,
                          child: Checkbox(
                            value: _isTermsAccepted,
                            onChanged: (value) {
                              setState(() {
                                _isTermsAccepted = value ?? false;
                              });
                            },
                            activeColor: Colors.orange,
                            checkColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 11,
                                ),
                                children: const [
                                  TextSpan(text: 'Tôi đã đọc và đồng ý với '),
                                  TextSpan(
                                    text: 'Điều khoản sử dụng',
                                    style: TextStyle(
                                      color: Colors.lightBlue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(text: ' và '),
                                  TextSpan(
                                    text: 'Chính\nsách bảo mật',
                                    style: TextStyle(
                                      color: Colors.lightBlue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(text: ' của Fonos.'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget nút tròn (Email và Điện thoại)
  Widget _buildCircleButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Center(child: Icon(icon, color: color, size: 30)),
      ),
    );
  }
}
