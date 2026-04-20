import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/app_providers.dart';
import '../../../shared/widgets/brand_background.dart';
import '../../../shared/widgets/brand_panel.dart';
import '../../../shared/widgets/brand_wordmark.dart';
import '../../../shared/widgets/safe_asset_image.dart';
import '../../../theme/app_colors.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

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
          .signUp(
            fullName: fullName,
            email: email,
            password: password,
          );
      shouldNavigate = true;
    } catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint('[SignUpPage] submit failed with ${error.runtimeType}: $error');
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
        debugPrint('[SignUpPage] submit finished (elapsed=${elapsedMs}ms, success=$shouldNavigate)');
      }
    }

    if (shouldNavigate && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.go('/interests');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BrandBackground(
        child: SafeArea(
          child: Stack(
            children: [
              const Positioned.fill(
                child: SafeAssetImage(
                  path: 'assets/images/onboarding/discover_tunisia.jpg',
                  title: 'Create account',
                  borderRadius: 0,
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.20),
                        Colors.white.withValues(alpha: 0.68),
                        AppColors.offWhite,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => context.pop(),
                          icon: const Icon(Icons.arrow_back_rounded),
                        ),
                        const Spacer(),
                        const BrandWordmark(),
                        const Spacer(),
                        TextButton(
                          onPressed: () => context.push('/login'),
                          child: const Text('Sign In'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 70),
                    BrandPanel(
                      radius: 32,
                      padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
                      color: Colors.white.withValues(alpha: 0.94),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Create your account',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Join our community of cultural explorers and build an itinerary that reflects your travel style.',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: 'Full name',
                                prefixIcon: Icon(Icons.person_rounded),
                              ),
                              validator: (value) =>
                                  (value == null || value.trim().length < 3)
                                  ? 'Enter your full name.'
                                  : null,
                            ),
                            const SizedBox(height: 14),
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email address',
                                prefixIcon: Icon(Icons.email_rounded),
                              ),
                              validator: (value) =>
                                  (value == null || !value.contains('@'))
                                  ? 'Enter a valid email.'
                                  : null,
                            ),
                            const SizedBox(height: 14),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscure,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock_rounded),
                                suffixIcon: IconButton(
                                  onPressed: () =>
                                      setState(() => _obscure = !_obscure),
                                  icon: Icon(
                                    _obscure
                                        ? Icons.visibility_rounded
                                        : Icons.visibility_off_rounded,
                                  ),
                                ),
                              ),
                              validator: (value) =>
                                  (value == null || value.length < 6)
                                  ? 'Minimum 6 characters.'
                                  : null,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _isSubmitting ? null : _submit,
                              child: Text(
                                _isSubmitting
                                    ? 'Creating account...'
                                    : 'Create Account',
                              ),
                            ),
                            const SizedBox(height: 14),
                            Center(
                              child: Text(
                                'After signup, the app will take you directly to interests selection.',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
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
