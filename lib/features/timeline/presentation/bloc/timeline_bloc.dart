import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/timeline_event.dart';
import '../../domain/usecases/add_timeline_event.dart';
import '../../domain/usecases/delete_timeline_event.dart';
import '../../domain/usecases/get_timeline_events.dart';
import '../../domain/usecases/update_timeline_event.dart';
import 'timeline_event.dart';
import 'timeline_state.dart';

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';

class TimelineBloc extends Bloc<TimelineBlocEvent, TimelineState> {
  final GetTimelineEvents getTimelineEvents;
  final AddTimelineEvent addTimelineEvent;
  final UpdateTimelineEvent updateTimelineEvent;
  final DeleteTimelineEvent deleteTimelineEvent;

  TimelineBloc({
    required this.getTimelineEvents,
    required this.addTimelineEvent,
    required this.updateTimelineEvent,
    required this.deleteTimelineEvent,
  }) : super(TimelineInitial()) {
    on<LoadTimelineEvents>(_onLoadTimelineEvents);
    on<AddTimelineEventRequested>(_onAddTimelineEvent);
    on<UpdateTimelineEventRequested>(_onUpdateTimelineEvent);
    on<DeleteTimelineEventRequested>(_onDeleteTimelineEvent);
  }

  Future<void> _onLoadTimelineEvents(
    LoadTimelineEvents event,
    Emitter<TimelineState> emit,
  ) async {
    emit(TimelineLoading());
    final failureOrEvents = await getTimelineEvents(NoParams());
    emit(_eitherLoadedOrErrorState(failureOrEvents));
  }

  Future<void> _onAddTimelineEvent(
    AddTimelineEventRequested event,
    Emitter<TimelineState> emit,
  ) async {
    final failureOrSuccess = await addTimelineEvent(
      AddTimelineEventParams(event: event.event),
    );

    await failureOrSuccess.fold(
      (failure) async =>
          emit(TimelineError(message: _mapFailureToMessage(failure))),
      (_) async {
        // Reload events after adding
        final failureOrEvents = await getTimelineEvents(NoParams());
        emit(_eitherLoadedOrErrorState(failureOrEvents));
      },
    );
  }

  Future<void> _onUpdateTimelineEvent(
    UpdateTimelineEventRequested event,
    Emitter<TimelineState> emit,
  ) async {
    final failureOrSuccess = await updateTimelineEvent(
      UpdateTimelineEventParams(event: event.event),
    );

    await failureOrSuccess.fold(
      (failure) async =>
          emit(TimelineError(message: _mapFailureToMessage(failure))),
      (_) async {
        // Reload events after updating
        final failureOrEvents = await getTimelineEvents(NoParams());
        emit(_eitherLoadedOrErrorState(failureOrEvents));
      },
    );
  }

  Future<void> _onDeleteTimelineEvent(
    DeleteTimelineEventRequested event,
    Emitter<TimelineState> emit,
  ) async {
    final failureOrSuccess = await deleteTimelineEvent(
      DeleteTimelineEventParams(eventId: event.eventId),
    );

    await failureOrSuccess.fold(
      (failure) async =>
          emit(TimelineError(message: _mapFailureToMessage(failure))),
      (_) async {
        // Reload events after deleting
        final failureOrEvents = await getTimelineEvents(NoParams());
        emit(_eitherLoadedOrErrorState(failureOrEvents));
      },
    );
  }

  TimelineState _eitherLoadedOrErrorState(
    Either<Failure, List<TimelineEvent>> failureOrEvents,
  ) {
    return failureOrEvents.fold(
      (failure) => TimelineError(message: _mapFailureToMessage(failure)),
      (events) => TimelineLoaded(events: events),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return 'Unexpected error';
    }
  }
}
