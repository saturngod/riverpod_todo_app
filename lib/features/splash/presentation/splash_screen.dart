import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpodtodo/core/network/api_service_provider.dart';
import 'package:riverpodtodo/router/router.dart';
import 'package:riverpodtodo/features/splash/model/auth_model.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final status = await ref.read(authModelProvider.notifier).checkAuthStatus();

    // Check if the widget is still mounted before using context
    if (!mounted) return;

    if (status == AuthStatus.authenticated) {
      final token = await ref.read(authModelProvider.notifier).getAuthToken();
      if (token != null) {
        ref.read(apiServiceProvider).setAuthToken(token);
        if (mounted) {
          context.goNamed(RouteNames.list); // Navigate to the list screen
          return;
        }
      }
    }

    if (mounted) {
      context.goNamed(RouteNames.login); // Navigate to the login screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return _defaultLoading();
  }

  Widget _defaultLoading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
