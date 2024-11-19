import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yayatopia/core/exceptions/exception.dart';
import 'package:yayatopia/model/picks/pick.dart';
import 'package:yayatopia/repositories/remote/home/top_picks_repository.dart';

part 'picks_state.dart';

class PicksCubit extends Cubit<PicksState> {
  PicksCubit() : super(PicksInit());
  getYayaTopPicks() async {
    emit(PicksLoading());
    try {
      emit(PicksFectched(picks: await TopPicksRepository().getYayaTopPicks()));
    } on GetFailedException catch (_) {
      emit(PicksError());
    }
  }
}
