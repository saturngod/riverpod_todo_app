import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpodtodo/login/provider/login_state_provider.dart';
import 'package:riverpodtodo/login/viewmodel/login_view_model.dart';
import 'package:riverpodtodo/router/router.dart';

class LoginScreen extends ConsumerWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginStateProvider);

    ref.listen<LoginState>(loginStateProvider, (previous, next) {
      if (next.isLoggedIn) {
        context.goNamed(RouteNames.list);
      }
    });

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                hintText: 'Username',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),
          ),
          if (loginState.isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            )
          else
            ElevatedButton(
              onPressed: () {
                _login(usernameController.text, passwordController.text, ref);
              },
              child: const Text('Login'),
            ),
          if (loginState.errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                loginState.errorMessage ?? "invalid login",
                style: const TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }

  void _login(String username, String password, WidgetRef ref) {
    ref.read(loginStateProvider.notifier).login(
          usernameController.text,
          passwordController.text,
        );
  }
}
