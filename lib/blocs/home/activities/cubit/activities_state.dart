part of 'activities_cubit.dart';

abstract class ActivitiesState extends Equatable {
  const ActivitiesState();

  @override
  List<Object> get props => [];
}

class ActivitiesInit extends ActivitiesState {}

class ActivitiesLoading extends ActivitiesState {}

class ActivitiesFectched extends ActivitiesState {
  final Activity activity;
  final List<Results> images;

  ActivitiesFectched({required this.activity, required this.images});
}

class ActivitiesError extends ActivitiesState {}
