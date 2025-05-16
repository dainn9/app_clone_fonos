
import 'package:app_clone_fonos/features/home/view/main_screen.dart';
import 'package:app_clone_fonos/features/profile/profile_screen.dart';
import 'package:app_clone_fonos/features/signin_signup/views/sign_in_email_link.dart';
import 'package:fluro/fluro.dart';

import '../../features/home/view/home_detail.dart';
import '../../features/home/view/home_view.dart';
import '../../features/onboarding/view/onboarding_screen.dart';
import '../../features/onboarding/view/onboarding_screen_step.dart';
import '../../features/onboarding/view/welcome_screen.dart';
import '../../features/signin_signup/views/register_screen.dart';
import '../../features/signin_signup/views/sign_in_screen.dart';
import '../design_systems/design_system_export.dart';

class FonosRouter {
  static final FluroRouter router = FluroRouter();

  static final Handler _welcomeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return WelcomeScreen();
    },
  );
  //
  static final Handler _onboardingHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return OnboardingScreen();
    },
  );

  static final Handler _onboardingstepHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return OnboardingScreenStep();
    },
  );
  //
  static final Handler _registerHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return RegisterScreen();
    },
  );

  static final Handler _signinHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return SignInScreen();
    },
  );

  // static final Handler _homeCategory = Handler(
  //   handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  //     return HomeCategory();
  //   },
  // );
  //
  static final Handler _homeScreen = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return HomeScreen();
    },
  );

  static final Handler _mainScreen = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return MainScreen();
    },
  );

  static final Handler _signInEmailLink = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return SignInEmailLinkScreen();
    },
  );

  static final Handler _profileScreen = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return ProfileScreen();
    },
  );

  //
  // static final Handler _homedetail = Handler(
  //   handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  //     return HomeDetail();
  //   },
  // );
  //
  // static final Handler _homeauthor = Handler(
  //   handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  //     return HomeAuthor();
  //   },
  // );
  //
  // static final Handler _homelistening = Handler(
  //   handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  //     return HomeListening();
  //   },
  // );
  //
  // static final Handler _homesearch = Handler(
  //   handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  //     return HomeSearch();
  //   },
  // );
  //
  // static final Handler _phonesignin = Handler(
  //   handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  //     return PhoneSignInScreen();
  //   },
  // );

  // static final Handler _verificationcode = Handler(
  //   handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  //     return VerificationCodeScreen();
  //   },
  // );

  static void setupRouter() {
    router.define('/', handler: _welcomeHandler, transitionType: TransitionType.inFromRight);
    router.define('/onboarding', handler: _onboardingHandler, transitionType: TransitionType.inFromRight);
    router.define('/onboarding_step', handler: _onboardingstepHandler, transitionType: TransitionType.inFromRight);
    router.define('/register', handler: _registerHandler, transitionType: TransitionType.inFromLeft);
    router.define('/sign_in', handler: _signinHandler, transitionType: TransitionType.inFromBottom);
    router.define('/main', handler: _mainScreen, transitionType: TransitionType.inFromBottom);
    router.define('/email_link', handler: _signInEmailLink, transitionType: TransitionType.inFromBottom);
    router.define('/profile', handler: _profileScreen, transitionType: TransitionType.inFromBottom);

    // router.define('/home', handler: _homeCategory, transitionType: TransitionType.inFromRight);
    router.define('/home_screen', handler: _homeScreen, transitionType: TransitionType.inFromRight);
    // router.define('/homedetail', handler: _homedetail, transitionType: TransitionType.inFromRight);
    // router.define('/homeauthor', handler: _homeauthor, transitionType: TransitionType.inFromRight);
    // router.define('/homelistening', handler: _homelistening, transitionType: TransitionType.inFromRight);
    // router.define('/phonesignin', handler: _phonesignin, transitionType: TransitionType.inFromRight);
    // router.define('/verificationcode', handler: _verificationcode, transitionType: TransitionType.inFromRight);
  }
}
