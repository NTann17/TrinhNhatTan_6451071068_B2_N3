import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthFailure implements Exception {
  final String message;

  const AuthFailure(this.message);

  @override
  String toString() => message;
}

class FirebaseAuthService {
  const FirebaseAuthService();

  FirebaseAuth _auth() {
    if (Firebase.apps.isEmpty) {
      throw const AuthFailure(
        'Firebase chưa được cấu hình. Hãy chạy flutterfire configure trước khi dùng đăng ký/đăng nhập.',
      );
    }

    return FirebaseAuth.instanceFor(app: Firebase.app());
  }

  Future<UserCredential> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth().signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      throw AuthFailure(_mapMessage(error));
    }
  }

  Future<UserCredential> registerWithEmailPassword({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth().createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = credential.user;
      if (user != null && fullName.trim().isNotEmpty) {
        await user.updateDisplayName(fullName.trim());
        await user.reload();
      }

      return credential;
    } on FirebaseAuthException catch (error) {
      throw AuthFailure(_mapMessage(error));
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _auth().sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (error) {
      throw AuthFailure(_mapMessage(error));
    }
  }

  Future<void> signOut() async {
    try {
      await _auth().signOut();
    } on FirebaseAuthException catch (error) {
      throw AuthFailure(_mapMessage(error));
    }
  }

  String _mapMessage(FirebaseAuthException error) {
    switch (error.code) {
      case 'email-already-in-use':
        return 'Email này đã được sử dụng.';
      case 'invalid-email':
        return 'Email không hợp lệ.';
      case 'weak-password':
        return 'Mật khẩu phải mạnh hơn.';
      case 'user-not-found':
        return 'Không tìm thấy tài khoản với email này.';
      case 'wrong-password':
        return 'Mật khẩu không đúng.';
      case 'invalid-credential':
        return 'Thông tin đăng nhập không đúng.';
      case 'too-many-requests':
        return 'Thử lại sau vài phút vì có quá nhiều yêu cầu.';
      case 'network-request-failed':
        return 'Không thể kết nối mạng.';
      case 'user-disabled':
        return 'Tài khoản này đã bị vô hiệu hóa.';
      default:
        return error.message ?? 'Đã xảy ra lỗi xác thực.';
    }
  }
}