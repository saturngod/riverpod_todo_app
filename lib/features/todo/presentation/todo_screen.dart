import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodtodo/components/loading_indicator.dart';
import 'package:riverpodtodo/features/todo/viewmodel/todo_viewmodel.dart';

class TodoScreen extends ConsumerStatefulWidget {
  final String listId;
  const TodoScreen({required this.listId,super.key});

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}
class _TodoScreenState extends ConsumerState<TodoScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Durations.medium1, () {
      ref.read(todoViewModelProvider.notifier).fetchTodos(widget.listId);
    });
  }

  @override
  Widget build(BuildContext context) {
    
    final TodoState state = ref.watch(todoViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddListDialog(context)
            )
        ],
      ),
      body:  Stack(
        children: [
          _buildTodos(state),
          if (state.isLoading) const LoadingWidget(),
        ],
      ),
    );
  }

  Widget _buildTodos(TodoState state) {
    return ListView.builder(
      itemCount: state.todos.length,
      itemBuilder: (context, index) {
        final todo = state.todos[index];
        return ListTile(
          title: Text(todo.title),
          subtitle: Text(todo.createdAt.toString()),
          leading: Checkbox(
            value: todo.completed,
            onChanged: (value) {
              if(value != null) {
                ref.read(todoViewModelProvider.notifier).updateTodo(todo, value);
              }
            },
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              ref.read(todoViewModelProvider.notifier).deleteTodo(todo);
            },
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
                  ref.read(todoViewModelProvider.notifier).addTodo(textBoxController.text,int.parse(widget.listId));
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
}