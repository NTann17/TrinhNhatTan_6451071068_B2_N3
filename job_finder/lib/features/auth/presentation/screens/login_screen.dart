import 'package:flutter/material.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/validators.dart';
import '../../auth.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool rememberMe;
  final bool obscurePassword;
  final ValueChanged<bool> onToggleRemember;
  final VoidCallback onTogglePassword;
  final Future<void> Function() onLogin;
  final bool isLoading;
  final String? errorText;

  const LoginScreen({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.rememberMe,
    required this.obscurePassword,
    required this.onToggleRemember,
    required this.onTogglePassword,
    required this.onLogin,
    this.isLoading = false,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Welcome Back', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(
              'Login to continue exploring jobs that fit your profile.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            AppTextField(
              label: 'Email',
              hintText: 'Enter your email',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: Validators.validateEmail,
            ),
            const SizedBox(height: 18),
            AppTextField(
              label: 'Password',
              hintText: 'Enter your password',
              controller: passwordController,
              obscureText: obscurePassword,
              validator: Validators.validatePassword,
              suffixIcon: IconButton(
                onPressed: onTogglePassword,
                icon: Icon(
                  obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: rememberMe,
                    onChanged: (value) => onToggleRemember(value ?? false),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    activeColor: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Remember me',
                    style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
                    );
                  },
                  child: const Text('Forgot Password ?'),
                ),
              ],
            ),
            const SizedBox(height: 18),
            if (errorText != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF0F0),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFFFD2D2)),
                ),
                child: Text(
                  errorText!,
                  style: const TextStyle(color: Color(0xFFB42318), fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 18),
            ],
            AppButton(
              text: 'LOGIN',
              backgroundColor: AppColors.primary,
              isLoading: isLoading,
              onPressed: () {
                onLogin();
              },
            ),
            const SizedBox(height: 14),
            OutlinedButton.icon(
              onPressed: () {},
              icon: Image.asset('assets/images/google.png', width: 30, height: 30),
              label: const Text('SIGN IN WITH GOOGLE'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(54),
                side: const BorderSide(color: AppColors.border),
                foregroundColor: AppColors.primaryDark,
                backgroundColor: const Color(0xFFF7F7FB),
                textStyle: const TextStyle(fontWeight: FontWeight.w700),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
            const SizedBox(height: 14),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "You don't have an account yet? ",
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignupScreen()),
                      );
                    },
                    child: const Text('Sign Up', style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
