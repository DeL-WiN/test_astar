import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/bloc/cubit.dart';
import 'package:untitled5/home/home.dart';
import 'package:untitled5/models/api.dart';
import 'package:untitled5/shema/shema.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
        create: (context) => UserCubit(apiWelcome: ApiWelcome()),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Home(),
        ));
  }
}
