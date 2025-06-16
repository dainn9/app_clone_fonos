import 'package:shared_preferences/shared_preferences.dart';

class OnboardingService {
  static Future<void> setOnboardingSeen(bool seen) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_seen', seen);
  }

  static Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboarding_seen') ?? false;
  }
}