import 'dart:async';

import 'package:provider/provider.dart';

import '../../../core/design_systems/design_system_export.dart';
import '../../home/view/home_view.dart';
import '../../signin_signup/providers/auth_provider.dart';

// class WelcomeProvider extends StatelessWidget {
//   const WelcomeProvider({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<WelcomeBloc>(
//       create: (context) => WelcomeBloc(),
//       child: WelcomePage(),
//     );
//   }
// }

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();

    // Đặt hẹn giờ để chuyển trang sau 5 giây
    Timer(Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/onboarding');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.peachCoral, // Màu tím như trong hình
      body: SafeArea(
        child: Stack(
          children: [
            // Center widget để căn giữa logo
            Center(
              child: Image.asset(
                'assets/images/logo_white.png', // Đường dẫn đến logo của bạn
                width: 100, // Điều chỉnh kích thước logo
                height: 100, // Điều chỉnh kích thước logo
              ),
            ),
          ],
        ),
      ),
    );
  }
}
