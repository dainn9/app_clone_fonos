import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? _user;
  bool _isLoading = false;
  String? _email;

  String? _errorMessage;
  bool _isEmailLinkSent = false;

  User? get user => _user;

  bool get isLoading => _isLoading;

  bool get isLoggedIn => _user != null;

  String? get email => _email;

  String? get errorMessage => _errorMessage;

  bool get isEmailLinkSent => _isEmailLinkSent;

  AuthProvider() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });

    // Kiểm tra xem có đang trong quá trình đăng nhập bằng email link không
    _checkEmailSignInProcess();
  }

  // Lưu email đang được sử dụng để đăng nhập
  Future<void> _saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('emailForSignIn', email);
    _email = email;
  }

  // Lấy email đã lưu
  Future<String?> _getSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('emailForSignIn');
  }

  // Kiểm tra quá trình đăng nhập
  Future<void> _checkEmailSignInProcess() async {
    _email = await _getSavedEmail();
    notifyListeners();
  }

  // Gửi link đăng nhập qua email
  Future<bool> sendSignInLinkToEmail(String email, BuildContext context) async {
    _isLoading = true;
    _errorMessage = null; // ✅ [BỔ SUNG] Reset lỗi
    _isEmailLinkSent = false;
    notifyListeners();

    try {
      // Cấu hình ActionCodeSettings
      var actionCodeSettings = ActionCodeSettings(
        url:
            'https://flutter-login-app-3d444.firebaseapp.com/__/auth/action?mode=action&oobCode=code',
        // Thay thế bằng URL của bạn
        handleCodeInApp: true,
        androidPackageName: 'com.example.app_clone_fonos',
        // Thay thế bằng package name của bạn
        androidInstallApp: true,
        androidMinimumVersion: '12',
        iOSBundleId: 'com.example.app_clone_fonos', // Thay thế bằng bundle ID của bạn
      );

      // Gửi link đăng nhập đến email
      await _auth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: actionCodeSettings,
      );

      // Lưu email để sử dụng sau khi người dùng click vào link
      await _saveEmail(email);

      _isLoading = false;
      _isEmailLinkSent = true;
      notifyListeners();
      return true;
    } catch (e) {
      print('Lỗi gửi email đăng nhập: $e');
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Xác thực đăng nhập khi người dùng click vào link trong email
  Future<bool> verifySignInLink(String link) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Kiểm tra xem link có phải là link đăng nhập không
      if (_auth.isSignInWithEmailLink(link)) {
        // Lấy email đã lưu
        final email = await _getSavedEmail();

        if (email == null) {
          _isLoading = false;
          notifyListeners();
          return false;
        }

        // Hoàn tất quá trình đăng nhập
        final userCredential = await _auth.signInWithEmailLink(
          email: email,
          emailLink: link,
        );

        _user = userCredential.user;

        // Xóa email đã lưu sau khi đăng nhập thành công
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('emailForSignIn');

        _isLoading = false;
        _isEmailLinkSent = true;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print('Lỗi xác thực link đăng nhập: $e');
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Bắt đầu quá trình đăng nhập Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // Lấy thông tin xác thực từ request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Tạo credential cho Firebase
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Đăng nhập vào Firebase với credential
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      _user = userCredential.user;

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Lỗi đăng nhập Google: $e');
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    _user = null;
    notifyListeners();
  }

  Future<User?> getProfile() async {
    final user = _auth.currentUser;
    if (user != null) {
      return user;
    }
    return null;
  }

  void resetState() {
    _isLoading = false;
    _errorMessage = null;
    _isEmailLinkSent = false;
    notifyListeners();
  }
}
