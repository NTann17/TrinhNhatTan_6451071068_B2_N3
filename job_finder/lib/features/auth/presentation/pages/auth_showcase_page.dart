import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../auth.dart';

enum _FlowStage { idle, logo, splash, login }

class AuthShowcasePage extends StatefulWidget {
  const AuthShowcasePage({super.key});

  @override
  State<AuthShowcasePage> createState() => _AuthShowcasePageState();
}

class _AuthShowcasePageState extends State<AuthShowcasePage> {
  final _authService = const FirebaseAuthService();
  _FlowStage _stage = _FlowStage.idle;

  void _showLogoThenSplash() {
    setState(() => _stage = _FlowStage.logo);
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) setState(() => _stage = _FlowStage.splash);
    });
  }

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'brandontoluia@gmail.com');
  final _passwordController = TextEditingController(text: 'jobspot123');
  bool _rememberMe = true;
  bool _obscurePassword = true;
  bool _isLoggingIn = false;
  String? _loginError;

  @override
  void initState() {
    super.initState();
    // Auto-start the flow: Logo -> Splash -> Login
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showLogoThenSplash();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _isLoggingIn = true;
      _loginError = null;
    });

    try {
      await _authService.signInWithEmailPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) {
        return;
      }
    } on AuthFailure catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _loginError = error.message;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoggingIn = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compact = context.isCompact;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F6),
      body: SafeArea(
        child: compact
            ? SingleChildScrollView(child: _buildCompactLayout(theme))
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                child: _buildDesktopLayout(theme),
              ),
      ),
    );
  }

  Widget _buildDesktopLayout(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 18),
            child: const LogoScreen(),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: SplashScreen(onArrowTap: () => setState(() => _stage = _FlowStage.login)),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 18),
            child: LoginScreen(
              formKey: _formKey,
              emailController: _emailController,
              passwordController: _passwordController,
              rememberMe: _rememberMe,
              obscurePassword: _obscurePassword,
              onToggleRemember: (value) => setState(() => _rememberMe = value),
              onTogglePassword: () => setState(() => _obscurePassword = !_obscurePassword),
              onLogin: _handleLogin,
              isLoading: _isLoggingIn,
              errorText: _loginError,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompactLayout(ThemeData theme) {
    switch (_stage) {
      case _FlowStage.idle:
        return GestureDetector(
          onTap: _showLogoThenSplash,
          behavior: HitTestBehavior.opaque,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const LogoScreen(),
              const SizedBox(height: 18),
              SplashScreen(onArrowTap: () => setState(() => _stage = _FlowStage.login)),
              const SizedBox(height: 18),
              LoginScreen(
                formKey: _formKey,
                emailController: _emailController,
                passwordController: _passwordController,
                rememberMe: _rememberMe,
                obscurePassword: _obscurePassword,
                onToggleRemember: (value) => setState(() => _rememberMe = value),
                onTogglePassword: () => setState(() => _obscurePassword = !_obscurePassword),
                onLogin: _handleLogin,
                isLoading: _isLoggingIn,
                errorText: _loginError,
              ),
            ],
          ),
        );
      case _FlowStage.logo:
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const LogoScreen(fullScreen: true),
        );
      case _FlowStage.splash:
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: SplashScreen(onArrowTap: () => setState(() => _stage = _FlowStage.login)),
          ),
        );
      case _FlowStage.login:
        return LoginScreen(
          formKey: _formKey,
          emailController: _emailController,
          passwordController: _passwordController,
          rememberMe: _rememberMe,
          obscurePassword: _obscurePassword,
          onToggleRemember: (value) => setState(() => _rememberMe = value),
          onTogglePassword: () => setState(() => _obscurePassword = !_obscurePassword),
          onLogin: _handleLogin,
          isLoading: _isLoggingIn,
          errorText: _loginError,
        );
    }
  }
}

// Illustration painter removed — splash illustration now uses image asset
