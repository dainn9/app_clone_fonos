import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../services/auth_service.dart';
import '../../../services/local_storage_service.dart';


class AuthViewmodel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final AuthService _authService;
  final LocalStorage _localStorage;

  User? _user;
  bool _isLoading = false;
  String? _email;
  String? _errorMessage;
  bool _isEmailLinkSent = false;

  AuthViewmodel(this._authService, this._localStorage) {
    _auth.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
    _init();
  }

  User? get user => _user;

  bool get isLoading => _isLoading;

  bool get isLoggedIn => _user != null;

  String? get email => _email;

  String? get errorMessage => _errorMessage;

  bool get isEmailLinkSent => _isEmailLinkSent;

  void _init() async {
    _email = await _localStorage.getEmailForSignIn();
    notifyListeners();
  }

  Future<bool> sendSignInLinkToEmail(String email, BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    _isEmailLinkSent = false;
    notifyListeners();

    try {
      final actionCodeSettings = ActionCodeSettings(
        url: 'https://flutter-login-app-3d444.firebaseapp.com/__/auth/action?mode=action&oobCode=code',
        handleCodeInApp: true,
        androidPackageName: 'com.example.app_clone_fonos',
        androidInstallApp: true,
        androidMinimumVersion: '12',
        iOSBundleId: 'com.example.app_clone_fonos',
      );

      await _auth.sendSignInLinkToEmail(email: email, actionCodeSettings: actionCodeSettings);

      await _localStorage.saveEmailForSignIn(email);

      _isEmailLinkSent = true;
      _isLoading = false;
      _email = email;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> verifySignInLink(String link) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    if (_auth.isSignInWithEmailLink(link)) {
      final savedEmail = await _localStorage.getEmailForSignIn();
      if (savedEmail == null) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      try {
        final userCredential = await _auth.signInWithEmailLink(email: savedEmail, emailLink: link);
        _user = userCredential.user;
        await _localStorage.removeEmailForSignIn();

        _isLoading = false;
        _isEmailLinkSent = true;
        notifyListeners();
        return true;
      } catch (e) {
        _errorMessage = e.toString();
      }
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> signInWithGoogle() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final googleAuth = await googleUser.authentication;

      if (googleAuth.idToken != null) {
        // Gọi backend để xác thực token
        final success = await _authService.postGoogleLogin(googleAuth.idToken!);
        if (!success) {
          _errorMessage = 'Đăng nhập backend thất bại';
          _isLoading = false;
          notifyListeners();
          return false;
        }
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      _user = userCredential.user;

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    _user = null;
    notifyListeners();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/sign_in',
            (route) => false,
      );
    });
  }

  Future<User?> getProfile() async {
    final user = _auth.currentUser;
    if (user != null) {
      return user;
    }
    return null;
  }

  Future<String?> getIdToken() async {
    if (_user != null) {
      return await _user!.getIdToken();
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
