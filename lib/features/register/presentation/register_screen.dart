import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpodtodo/features/register/viewmodel/register_view_model.dart';
import 'package:riverpodtodo/router/router.dart';

class RegisterScreen extends ConsumerWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(registerViewModelProvider);

    ref.listen<RegisterState>(registerViewModelProvider, (previous, next) {
      if (next.isSuccess) {
        _showSuccessDialog(context);
      }
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTitle(),
            _buildLoginCard(ref),
            const SizedBox(height: 8),
            if (registerState.isLoading)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              )
            else
              _buildActionButtons(context, ref, registerState),
            if (registerState.errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  registerState.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Register',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLoginCard(WidgetRef ref) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                hintText: 'Username',
              ),
              onChanged: (value) => ref.read(registerViewModelProvider.notifier).updateUsername(value),
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
              onChanged: (value) => ref.read(registerViewModelProvider.notifier).updatePassword(value),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Confirm Password',
              ),
              onChanged: (value) => ref.read(registerViewModelProvider.notifier).updateConfirmPassword(value),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref, RegisterState registerState) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: registerState.isFormValid ? () => _register(ref) : null,
          child: const Text('Register'),
        ),
        TextButton(
          onPressed: () {
            context.goNamed(RouteNames.login);
          },
          child: const Text('Back to Login'),
        ),
      ],
    );
  }

  void _register(WidgetRef ref) {
    ref.read(registerViewModelProvider.notifier).register();
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Register has been successful. Ready to login'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.goNamed(RouteNames.login);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}