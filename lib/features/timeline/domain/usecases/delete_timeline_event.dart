import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/timeline_repository.dart';

class DeleteTimelineEvent implements UseCase<void, DeleteTimelineEventParams> {
  final TimelineRepository repository;

  DeleteTimelineEvent(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteTimelineEventParams params) async {
    return await repository.deleteTimelineEvent(params.eventId);
  }
}

class DeleteTimelineEventParams extends Equatable {
  final String eventId;

  const DeleteTimelineEventParams({required this.eventId});

  @override
  List<Object> get props => [eventId];
}
