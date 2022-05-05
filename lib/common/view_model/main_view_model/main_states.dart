import '../../../auth/models/user_model.dart';
import '../../../core/network/failure.dart';

abstract class MainStates {}

class MainInitialState extends MainStates {}

class MainGetCurrentUserLoadingState extends MainStates {}

class MainGetCurrentUserSuccessState extends MainStates {
  final User user;

  MainGetCurrentUserSuccessState(this.user);
}

class MainGetCurrentUserFailureState extends MainStates {
  final Failure failure;

  MainGetCurrentUserFailureState(this.failure);
}
