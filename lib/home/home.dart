import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/models/api.dart';

import '../bloc/cubit.dart';
import '../bloc/cubit_state.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final titleController = TextEditingController();

  void addUser() {
    var title = titleController.text;
    titleController.text = '';
    // final check = usersList.every((user) => user.title != title);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, CubitState>(listener: ((context, state) {
      if (state is LoadedState) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Users is Loaded')));
      }
    }), builder: (context, state) {
      if (state is EmptyState) {
        final UserCubit userCubit = context.watch<UserCubit>();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home Screen'),
          ),
          body: Column(
            children: [
              const Text('Set valid API base URL in order to continue'),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                    filled: true,
                    labelText: 'URL',
                    fillColor: Colors.white10,
                    border: OutlineInputBorder()),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                ApiWelcome().graph();
              },
              label: const Text('Start counting process')),
        );
      }
      if (state is LoadingState) {
        return Center(
          child: Column(
            children: [
              const Text(''),
              FloatingActionButton.extended(
                  onPressed: () {
                  },
                  label: const Text('Start counting process')),
            ],
          ),
        );
      }
      if (state is LoadedState) {
        return Center();
      }
      if (state is ErrorState) {
        return Center(
          child: Column(
            children:  [
              const Text('Error'),
              FloatingActionButton.extended(
                  onPressed: () {
                  },
                  label: const Text('Start counting process')),
            ],
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}
