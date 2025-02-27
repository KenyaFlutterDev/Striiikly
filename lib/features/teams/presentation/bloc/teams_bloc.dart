import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'teams_event.dart';
part 'teams_state.dart';

class TeamsBloc extends Bloc<TeamsEvent, TeamsState> {
  TeamsBloc() : super(TeamsInitial()) {
    on<TeamsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
