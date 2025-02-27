import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'contributions_event.dart';
part 'contributions_state.dart';

class ContributionsBloc extends Bloc<ContributionsEvent, ContributionsState> {
  ContributionsBloc() : super(ContributionsInitial()) {
    on<ContributionsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
