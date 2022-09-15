

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/models/models.dart';

import '../models/api.dart';
import 'cubit_state.dart';

class UserCubit extends Cubit<CubitState> {
  final ApiWelcome? apiWelcome;
  UserCubit({required this.apiWelcome}) : super(EmptyState());

  Future<void> loadingUser() async {
    try{
      emit(LoadingState());
      final Welcome? loadedList = await apiWelcome?.getHttp();
      emit(LoadedState(loadedWelcome: loadedList));
    }catch(_){
      emit(ErrorState());
    }
  }
}