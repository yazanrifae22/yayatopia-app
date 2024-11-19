import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yayatopia/core/exceptions/exception.dart';
import 'package:yayatopia/model/activity_detail/activity_detail.dart';
import 'package:yayatopia/repositories/remote/home/activity_detail_repository.dart';

part 'activities_state.dart';

class ActivitiesCubit extends Cubit<ActivitiesState> {
  ActivitiesCubit() : super(ActivitiesInit());
  getYayaTopActivities(int id) async {
    emit(ActivitiesLoading());
    try {
      List<dynamic> list =
          await ActivityDetailRepository().getYayaTopActivity(id);
      emit(ActivitiesFectched(
        activity: list[0],
        images: list[1],
      ));

    } on GetFailedException catch (_) {
      emit(ActivitiesError());
    }
  }
}
