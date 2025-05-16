import 'package:app_clone_fonos/features/home/view/main_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/components/custom_button/custom_button.dart';
import '../../../core/design_systems/design_system_export.dart';
import '../../home/view/home_view.dart';
import '../../signin_signup/providers/auth_provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    // Nếu đã đăng nhập, chuyển đến màn hình chính
    if (authProvider.isLoggedIn) {
      return MainScreen();
    }

    return Scaffold(
      body: Stack(
        children: [
          // Ảnh nền
          Positioned.fill(
            child: Image.asset(
              'assets/images/background_onboarding.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Nội dung cuối màn hình
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo + text
                  Image.asset(
                    'assets/images/logo_text_white.png',
                    width: 100,
                    height: 100,
                  ),
                  const Text(
                    'Nghe hàng ngàn cuốn sách \nnói, thiền định, truyện ngủ\nvà các nội dung khác.',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Nút bắt đầu
                  CustomButton(
                    text: 'Bắt đầu',
                    backgroundColor: AppColors.peachCoral,
                    textColor: Colors.white,
                    onPressed: () async {
                      Navigator.pushNamed(context, '/onboarding_step');
                      // Navigator.pushNamed(context, '/profile');
                    //
                    },
                  ),
                  const SizedBox(height: 10),
                  // Nút đăng nhập
                  CustomButton(
                    text: 'Đăng nhập',
                    onPressed: () {
                      Navigator.pushNamed(context, '/sign_in');
                    },
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
