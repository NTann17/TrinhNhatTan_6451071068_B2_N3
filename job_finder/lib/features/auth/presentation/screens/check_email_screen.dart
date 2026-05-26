import 'package:flutter/material.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/theme/app_colors.dart';
import 'success_screen.dart';

class CheckEmailScreen extends StatelessWidget {
  final String email;
  const CheckEmailScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F6),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              const Text('Check Your Email', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700), textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text('We have sent the reset password to the email address', style: TextStyle(color: Colors.black54), textAlign: TextAlign.center),
              const SizedBox(height: 6),
              Text(email, style: const TextStyle(fontWeight: FontWeight.w600), textAlign: TextAlign.center),
              const SizedBox(height: 16),
              // illustration: check email image
              Center(
                child: SizedBox(
                  height: 90,
                  child: Image.asset(
                    'assets/images/check_email.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              AppButton(
                text: 'OPEN YOUR EMAIL',
                backgroundColor: AppColors.primary,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SuccessScreen()),
                  );
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
              const SizedBox(height: 12),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'You have not received the email? ',
                      style: TextStyle(color: Colors.black54),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Resend',
                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
