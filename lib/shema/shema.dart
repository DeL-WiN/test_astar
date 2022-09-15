
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/bloc/cubit.dart';
import 'package:untitled5/bloc/cubit_state.dart';

import '../models/api.dart';

class Shema extends StatelessWidget {
  const Shema({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, CubitState>(
        listener: ((context, state){
          if (state is LoadedState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Users is Loaded')));
          }
        }),
      builder: (context, state) {
          if (state is EmptyState) {
            final UserCubit userCubit = context.watch<UserCubit>();
            return Center();
          }
          return const SizedBox.shrink();
      }
    );
  }
}

class Shemaa {
  final apiWelcome = ApiWelcome();

    void shema() {

      var rng = Random();
      var twoDList = List.generate(1, (i) =>
          List.filled(5, rng.nextInt(100)), growable: false);

      for (int x = 0; twoDList.length > x; x++) {
        for (int y = 0; twoDList.length > y; y++) {
          twoDList[x][y]= rng.nextInt(100);

        }
      }
      for (int a = 0; twoDList.length > a; a++) {
        for (int b = 0; twoDList.length > b; b++) {
//         print (twoDList[a][b]);

        }
      }
      print(twoDList);
    }
}