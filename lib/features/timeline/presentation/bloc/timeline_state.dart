import 'package:equatable/equatable.dart';

import '../../domain/entities/timeline_event.dart';

abstract class TimelineState extends Equatable {
  const TimelineState();

  @override
  List<Object> get props => [];
}

class TimelineInitial extends TimelineState {}

class TimelineLoading extends TimelineState {}

class TimelineLoaded extends TimelineState {
  final List<TimelineEvent> events;

  const TimelineLoaded({required this.events});

  @override
  List<Object> get props => [events];
}

class TimelineError extends TimelineState {
  final String message;

  const TimelineError({required this.message});

  @override
  List<Object> get props => [message];
}
