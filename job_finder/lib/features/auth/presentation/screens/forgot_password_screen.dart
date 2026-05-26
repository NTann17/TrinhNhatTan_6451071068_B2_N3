import 'package:flutter/material.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/validators.dart';
import '../../auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _authService = const FirebaseAuthService();
  bool _isSubmitting = false;
  String? _errorText;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorText = null;
    });

    try {
      await _authService.sendPasswordResetEmail(email: _email.text.trim());

      if (!mounted) {
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CheckEmailScreen(email: _email.text.trim()),
        ),
      );
    } on AuthFailure catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _errorText = error.message;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F6),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                const Text('Forgot Password?', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                const Text('To reset your password, you need your email or mobile number that can be authenticated', style: TextStyle(color: Colors.black54)),
                const SizedBox(height: 20),
                // illustration: reset password image
                Center(
                  child: SizedBox(
                    height: 110,
                    child: Image.asset(
                      'assets/images/reset_password.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                AppTextField(
                  label: 'Email',
                  hintText: 'Enter your email',
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 16),
                if (_errorText != null) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF0F0),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFFFD2D2)),
                    ),
                    child: Text(
                      _errorText!,
                      style: const TextStyle(color: Color(0xFFB42318), fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                AppButton(
                  text: 'RESET PASSWORD',
                  backgroundColor: AppColors.primary,
                  isLoading: _isSubmitting,
                  onPressed: () {
                    _resetPassword();
                  },
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(54),
                    side: const BorderSide(color: AppColors.border),
                    foregroundColor: AppColors.primaryDark,
                    backgroundColor: const Color(0xFFF7F7FB),
                    textStyle: const TextStyle(fontWeight: FontWeight.w700),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('BACK TO LOGIN'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
