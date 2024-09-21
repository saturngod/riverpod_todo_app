import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpodtodo/features/splash/model/auth_model.dart';
import 'package:riverpodtodo/router/router.dart';

class ListScreen extends ConsumerWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final authModel =  ref.read(authModelProvider.notifier);
              authModel.logout();
              if (context.mounted) {
                context.goNamed(RouteNames.login);
              }
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('List Screen'),
      ),
    );
  }
}
