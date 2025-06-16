import 'dart:io';
import 'package:app_clone_fonos/services/book_author_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import '../core/design_systems/design_system_export.dart';
import '../core/navigation/routers.dart';
import '../features/auth/viewmodels/auth_viewmodel.dart';
import '../firebase_options.dart';
import '../services/audiobook_chapter_service.dart';
import '../services/auth_service.dart';
import '../services/book_service.dart';
import '../services/local_storage_service.dart';
import 'app.dart';

void run() async {
  // Đảm bảo các binding của Flutter được khởi tạo
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final localStorage = LocalStorage(); // hoặc await LocalStorage.init();
  final authService = AuthService(localStorage);

  //initial router
  HttpOverrides.global = MyHttpOverrides();
  FonosRouter.setupRouter();
  // Khởi chạy ứng dụng
  runApp(
    MultiProvider(
      providers: [
        Provider<BookService>(create: (_) => BookService()),
        Provider<BookAuthorService>(create: (_) =>BookAuthorService()),
        Provider<AudiobookChapterService>(create: (_) => AudiobookChapterService()),
        ChangeNotifierProvider(create: (_) => AuthViewmodel(authService, localStorage)),
      ],
      child: App(),
    ),
  );
}


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}