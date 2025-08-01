import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/timeline_event.dart';
import '../repositories/timeline_repository.dart';

class AddTimelineEvent implements UseCase<void, AddTimelineEventParams> {
  final TimelineRepository repository;

  AddTimelineEvent(this.repository);

  @override
  Future<Either<Failure, void>> call(AddTimelineEventParams params) async {
    return await repository.addTimelineEvent(params.event);
  }
}

class AddTimelineEventParams extends Equatable {
  final TimelineEvent event;

  const AddTimelineEventParams({required this.event});

  @override
  List<Object> get props => [event];
}
