import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'achievements_event.dart';
part 'achievements_state.dart';

class AchievementsBloc extends Bloc<AchievementsEvent, AchievementsState> {
  AchievementsBloc() : super(AchievementsInitial()) {
    on<AchievementsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
