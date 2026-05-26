import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _authService = const FirebaseAuthService();
  bool _remember = true;
  bool _isSubmitting = false;
  String? _errorText;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorText = null;
    });

    try {
      await _authService.registerWithEmailPassword(
        fullName: _name.text.trim(),
        email: _email.text.trim(),
        password: _password.text,
      );

      if (!mounted) {
        return;
      }

      Navigator.of(context).pop();
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Text('Create an Account', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                const Text(
                  'Create your Jobspot account to save profiles and apply faster.',
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 20),
                AppTextField(
                  label: 'Full name',
                  hintText: 'Enter your full name',
                  controller: _name,
                  validator: Validators.validateName,
                ),
                const SizedBox(height: 12),
                AppTextField(
                  label: 'Email',
                  hintText: 'Enter your email',
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 12),
                AppTextField(
                  label: 'Password',
                  hintText: 'Create a password',
                  controller: _password,
                  obscureText: true,
                  validator: Validators.validatePassword,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Checkbox(
                      value: _remember,
                      onChanged: (v) => setState(() => _remember = v ?? false),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      activeColor: AppColors.primary,
                    ),
                    const Text('Remember me'),
                    const Spacer(),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Sign in', style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
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
                  const SizedBox(height: 8),
                ],
                AppButton(
                  text: 'SIGN UP',
                  backgroundColor: AppColors.primary,
                  isLoading: _isSubmitting,
                  onPressed: () {
                    _submit();
                  },
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: Image.asset('assets/images/google.png', width: 30, height: 30),
                  label: const Text('SIGN UP WITH GOOGLE'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(54),
                    side: const BorderSide(color: AppColors.border),
                    foregroundColor: AppColors.primaryDark,
                    backgroundColor: const Color(0xFFF7F7FB),
                    textStyle: const TextStyle(fontWeight: FontWeight.w700),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Already have an account? ', style: TextStyle(color: AppColors.textSecondary)),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Sign in', style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
