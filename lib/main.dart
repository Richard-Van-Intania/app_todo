import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'to-do',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListProvider);
    final newTodoController = useTextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const Text(
                'to-do',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 100.0, fontWeight: FontWeight.w100),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: TextField(
                  key: UniqueKey(),
                  controller: newTodoController,
                  decoration: const InputDecoration(labelText: "what's next?", labelStyle: TextStyle(fontSize: 25.0)),
                  onSubmitted: (value) {
                    if (value.trim().isNotEmpty && value.trim().length < 100) {
                      ref.read(todoListProvider.notifier).add(value);
                      newTodoController.clear();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("to-do can't be empty")));
                    }
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                  child: ListView(
                children: [
                  for (var i = 0; i < todos.length; i++) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Card(
                        child: ListTile(
                          leading: Checkbox(
                            value: todos[i].completed,
                            onChanged: (value) => ref.read(todoListProvider.notifier).toggle(todos[i].id),
                          ),
                          title: Text(
                            todos[i].description,
                            style: TextStyle(fontSize: 20.0, decoration: todos[i].completed ? TextDecoration.lineThrough : TextDecoration.none),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_forever),
                            onPressed: () {
                              ref.read(todoListProvider.notifier).remove(todos[i]);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
