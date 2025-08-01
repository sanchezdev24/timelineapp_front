import 'package:equatable/equatable.dart';

import '../../domain/entities/timeline_event.dart';

abstract class TimelineBlocEvent extends Equatable {
  const TimelineBlocEvent();

  @override
  List<Object> get props => [];
}

class LoadTimelineEvents extends TimelineBlocEvent {}

class AddTimelineEventRequested extends TimelineBlocEvent {
  final TimelineEvent event;

  const AddTimelineEventRequested(this.event);

  @override
  List<Object> get props => [event];
}

class UpdateTimelineEventRequested extends TimelineBlocEvent {
  final TimelineEvent event;

  const UpdateTimelineEventRequested(this.event);

  @override
  List<Object> get props => [event];
}

class DeleteTimelineEventRequested extends TimelineBlocEvent {
  final String eventId;

  const DeleteTimelineEventRequested(this.eventId);

  @override
  List<Object> get props => [eventId];
}
