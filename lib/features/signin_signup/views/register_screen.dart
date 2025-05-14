import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../core/components/custom_button/custom_button.dart';
import '../../../core/components/circle_icon_button.dart';
import '../../../core/components/processing_dialog/processing_dialog.dart';
import '../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isTermsAccepted = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

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
                icon: Icons.arrow_back_ios_new,
                left: 10,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/sign_in');
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacer(),
                    const Text(
                      'Tạo tài khoản miễn phí',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
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
                    SizedBox(height: 15),

                    CustomButton(
                      text: 'Tiếp tục với Email',
                      icon: Icons.email,
                      iconColor: Colors.orange,
                      onPressed: () {
                      },
                    ),
                    SizedBox(height: 15),

                    CustomButton(
                      text: 'Tiếp tục với Số điện thoại',
                      icon: FontAwesomeIcons.phone,
                      iconColor: Colors.pink,
                      onPressed: () {
                      },
                    ),
                    SizedBox(height: 30),
                    // Phần đăng ký và điều khoản
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Đã có tài khoản? ',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 16,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                '/sign_in',
                              );
                            },
                            child: const Text(
                              'Đăng nhập',
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
                    const SizedBox(height: 50),

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
}
