
import 'package:untitled5/models/models.dart';

abstract class CubitState {}

class EmptyState extends CubitState {}

class LoadingState extends CubitState {}

class LoadedState extends CubitState {
  Welcome? loadedWelcome;

  LoadedState({
    required this.loadedWelcome,
  });
}

class ErrorState extends CubitState {}
