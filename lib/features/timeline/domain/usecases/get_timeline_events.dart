import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/timeline_event.dart';
import '../repositories/timeline_repository.dart';

class GetTimelineEvents implements UseCase<List<TimelineEvent>, NoParams> {
  final TimelineRepository repository;

  GetTimelineEvents(this.repository);

  @override
  Future<Either<Failure, List<TimelineEvent>>> call(NoParams params) async {
    return await repository.getTimelineEvents();
  }
}
