import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/globals.dart';
import '../../repositories/main/main_repo.dart';
import 'main_states.dart';

class MainViewModel extends Cubit<MainStates> {
  MainViewModel() : super(MainInitialState());
  final MainRepository _mainRepository = MainRepository.instance;

  Future<void> getCurrentUser() async {
    emit(MainGetCurrentUserLoadingState());
    (await _mainRepository.getCurrentUser()).fold(
      (failure) => emit(MainGetCurrentUserFailureState(failure)),
      (user) {
        currentUser = user;
        emit(MainGetCurrentUserSuccessState(user));
      },
    );
  }
}
