import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/app_providers.dart';
import 'widgets/auth_glass_page.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key, this.redirectTo = '/interests'});

  final String redirectTo;

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;
  bool _isSubmitting = false;

  bool _isCycleError(Object error) {
    final type = error.runtimeType.toString().toLowerCase();
    final text = error.toString().toLowerCase();
    return type.contains('circular') ||
        type.contains('cycle') ||
        text.contains('circular') ||
        text.contains('cycle');
  }

  String _toReadableError(Object error) {
    if (_isCycleError(error)) {
      return 'Circular dependency detected during signup. Check debug logs for provider chain details.';
    }

    final raw = error.toString();
    if (raw.startsWith('Exception: ')) {
      return raw.replaceFirst('Exception: ', '');
    }
    if (raw.startsWith('AuthException: ')) {
      return raw.replaceFirst('AuthException: ', '');
    }
    return raw;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final fullName = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    FocusManager.instance.primaryFocus?.unfocus();
    setState(() => _isSubmitting = true);
    var shouldNavigate = false;
    final startedAt = DateTime.now();

    if (kDebugMode) {
      debugPrint(
        '[SignUpPage] submit started at ${startedAt.toIso8601String()} '
        '(email=$email, fullNameLength=${fullName.length}, passwordLength=${password.length})',
      );
    }

    try {
      await ref
          .read(sessionControllerProvider.notifier)
          .signUp(fullName: fullName, email: email, password: password);
      shouldNavigate = true;
    } catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint(
          '[SignUpPage] submit failed with ${error.runtimeType}: $error',
        );
        debugPrintStack(stackTrace: stackTrace);
      }
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(_toReadableError(error))));
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
      if (kDebugMode) {
        final elapsedMs = DateTime.now().difference(startedAt).inMilliseconds;
        debugPrint(
          '[SignUpPage] submit finished (elapsed=${elapsedMs}ms, success=$shouldNavigate)',
        );
      }
    }

    if (shouldNavigate && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.go(widget.redirectTo);
        }
      });
    }
  }

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }
    context.go('/auth');
  }

  InputDecoration _inputDecoration(String hint, {Widget? suffixIcon}) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
    );

    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
      filled: true,
      fillColor: Colors.white.withOpacity(0.28),
      border: border,
      enabledBorder: border,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF006B7D), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFFFD6D6)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFFFD6D6), width: 2),
      ),
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      errorStyle: const TextStyle(color: Color(0xFFFFD6D6)),
    );
  }

  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Image.asset(
        'assets/images/hkeyetna1.png',
        height: 138,
        fit: BoxFit.contain,
        errorBuilder: (_, _, _) => const SizedBox(height: 138),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthGlassPage(
      onBack: _handleBack,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: _buildLogo()),
            const SizedBox(height: 20),
            const Text(
              'Create your account',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'Join HKEYETNA and get ready for your next adventure.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.9),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _fieldLabel('Full name'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: _inputDecoration('Your name'),
              validator: (value) => (value == null || value.trim().length < 3)
                  ? 'Enter your full name.'
                  : null,
            ),
            const SizedBox(height: 20),
            _fieldLabel('Email'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: _inputDecoration('your@email.com'),
              validator: (value) => (value == null || !value.contains('@'))
                  ? 'Enter a valid email.'
                  : null,
            ),
            const SizedBox(height: 20),
            _fieldLabel('Password'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscure,
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: _inputDecoration(
                '********',
                suffixIcon: IconButton(
                  onPressed: () => setState(() => _obscure = !_obscure),
                  icon: Icon(
                    _obscure
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
              ),
              validator: (value) => (value == null || value.length < 6)
                  ? 'Minimum 6 characters.'
                  : null,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006B7D),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 8,
                ),
                child: Text(
                  _isSubmitting ? 'Creating...' : 'Create account',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'After sign up, you will be redirected to the next step.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.82),
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
                GestureDetector(
                  onTap: _isSubmitting ? null : () => context.push('/login'),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
