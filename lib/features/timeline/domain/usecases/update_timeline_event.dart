import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/timeline_event.dart';
import '../repositories/timeline_repository.dart';

class UpdateTimelineEvent implements UseCase<void, UpdateTimelineEventParams> {
  final TimelineRepository repository;

  UpdateTimelineEvent(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateTimelineEventParams params) async {
    return await repository.updateTimelineEvent(params.event);
  }
}

class UpdateTimelineEventParams extends Equatable {
  final TimelineEvent event;

  const UpdateTimelineEventParams({required this.event});

  @override
  List<Object> get props => [event];
}
