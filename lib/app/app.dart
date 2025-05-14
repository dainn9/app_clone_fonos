import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/design_systems/design_system_export.dart';
import '../core/navigation/routers.dart';
import '../core/utils/app_constants.dart';

class App extends StatelessWidget {
  App({super.key}); // Xóa từ khóa 'const'

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: _navigatorKey,
          debugShowCheckedModeBanner: false,
          title: Appconstants.APP_TITLE,
          theme: BMaterialTheme.light(),
          themeMode: ThemeMode.light,
          onGenerateRoute: FonosRouter.router.generator,
          initialRoute: '/',
        );
      },
    );
  }
}
