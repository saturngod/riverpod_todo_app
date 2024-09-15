import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpodtodo/router/router.dart';
import 'package:riverpodtodo/splash/model/auth_model.dart';
import 'package:riverpodtodo/splash/provider/auth_model_provider.dart';

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
    final authModel = await ref.read(authModelProvider.future);
    final status = await authModel.checkAuthStatus();

    // Check if the widget is still mounted before using context
    if (!mounted) return;

    if (status == AuthStatus.authenticated) {
      context.goNamed(RouteNames.list); // Navigate to the list screen
    } else {
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