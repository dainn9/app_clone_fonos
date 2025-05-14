import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/components/custom_button/custom_button.dart';
import '../../../core/components/circle_icon_button.dart';
import '../../../core/design_systems/theme/app_colors.dart';
import '../providers/auth_provider.dart';

class SignInEmailLinkScreen extends StatefulWidget {
  const SignInEmailLinkScreen({super.key});

  @override
  State<SignInEmailLinkScreen> createState() => _SignInEmailLinkScreenState();
}

class _SignInEmailLinkScreenState extends State<SignInEmailLinkScreen> {
  final TextEditingController _emailController = TextEditingController();

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
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 100),

                    if (authProvider.errorMessage != null)
                      Text(
                        "Vui lòng nhập email của bạn",
                        style: const TextStyle(color: Colors.red),
                      ),
                    const Text(
                      'Hãy nhập email của bạn',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Địa chỉ email",
                        filled: true,
                        fillColor: Colors.white, // nền trắng
                        border: OutlineInputBorder(
                          // bo góc
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          borderSide: BorderSide.none, // bo góc 12
                        ),
                      ),
                    ),
                    const Spacer(),

                    CustomButton(
                      text: 'Tiếp tục',
                      backgroundColor: AppColors.peachCoral,
                      textColor: Colors.white,
                      onPressed: () async {
                        // final email = _emailController.text.trim();
                        // bool success = await authProvider.sendSignInLinkToEmail(email, context);
                        // if (success) {
                        //   showDialog(
                        //     context: context,
                        //     barrierDismissible: false,
                        //     builder: (context) => const EmailSentDialog(),
                        //   );
                        // }
                      },
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
