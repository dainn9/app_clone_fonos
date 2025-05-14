import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import '../core/design_systems/design_system_export.dart';
import '../core/navigation/routers.dart';
import '../features/signin_signup/providers/auth_provider.dart';
import '../firebase_options.dart';
import 'app.dart';

void run() async {
  // Đảm bảo các binding của Flutter được khởi tạo
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Khởi tạo các dịch vụ toàn cục
  // await ApiService.init(); // Ví dụ: Khởi tạo API service
  // Logger.init(); // Khởi tạo logger

  // In thông báo khởi động
  // Logger.log('Application is starting...');

  //initial router
  FonosRouter.setupRouter();
  // Khởi chạy ứng dụng
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: App(),
    ),
  );
}