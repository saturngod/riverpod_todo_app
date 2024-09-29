import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpodtodo/components/loading_indicator.dart';
import 'package:riverpodtodo/features/list/viewmodel/todo_list_viewmodel.dart';
import 'package:riverpodtodo/features/splash/model/auth_model.dart';
import 'package:riverpodtodo/router/router.dart';

class ListScreen extends ConsumerStatefulWidget {
  const ListScreen({super.key});

  @override
  ConsumerState<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends ConsumerState<ListScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Durations.medium1, () {
      ref.read(todoListViewModelProvider.notifier).fetchTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final TodoListState state = ref.watch(todoListViewModelProvider);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          _buildTodoList(state),
          if (state.isLoading) const LoadingWidget(),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Todo List'),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _showAddListDialog(context),
        ),
        PopupMenuButton<String>(
          onSelected: (value) => _handleMenuSelection(context, value),
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout'),
              ),
            ];
          },
        ),
      ],
    );
  }

  Widget _buildTodoList(TodoListState state) {
    return ListView.builder(
      itemCount: state.todos.length,
      itemBuilder: (context, index) {
        final todo = state.todos[index];
        return InkWell(
          onTap: () {
            context.pushNamed(RouteNames.todo, pathParameters: {'listId': todo.id.toString()});
          },
          child: ListTile(
            title: Text(todo.title),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => ref.read(todoListViewModelProvider.notifier).deleteTodoList("${todo.id}"),
            ),
          ),
        );
      },
    );
  }

  void _showAddListDialog(BuildContext context) {
    final textBoxController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create List'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textBoxController,
                decoration: const InputDecoration(hintText: 'List Name'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(todoListViewModelProvider.notifier).addTodoList(textBoxController.text);
                  Navigator.of(context).pop();
                },
                child: const Text('Add'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleMenuSelection(BuildContext context, String value) {
    if (value == 'logout') {
      final authModel = ref.read(authModelProvider.notifier);
      authModel.logout();
      if (context.mounted) {
        context.goNamed(RouteNames.login);
      }
    }
  }
}