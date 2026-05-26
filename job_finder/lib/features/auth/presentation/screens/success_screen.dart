import 'package:flutter/material.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/theme/app_colors.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

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
              const Text('Successfully', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700), textAlign: TextAlign.center),
              const SizedBox(height: 8),
              const Text('Your password has been updated, please change your password regularly to avoid this happening', style: TextStyle(color: Colors.black54), textAlign: TextAlign.center),
              const SizedBox(height: 16),
              Center(
                child: SizedBox(
                  height: 90,
                  child: Image.asset(
                    'assets/images/success.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              AppButton(
                text: 'CONTINUE',
                backgroundColor: AppColors.primary,
                onPressed: () {},
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
    );
  }
}
