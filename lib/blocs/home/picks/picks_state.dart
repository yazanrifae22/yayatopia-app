part of 'picks_cubit.dart';

class PicksState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PicksInit extends PicksState {}

class PicksLoading extends PicksState {}

class PicksFectched extends PicksState {
  final List<Pick> picks;
  PicksFectched({required this.picks});
}

class PicksError extends PicksState {}
