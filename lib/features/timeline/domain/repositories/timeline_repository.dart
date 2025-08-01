import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/timeline_event.dart';

abstract class TimelineRepository {
  Future<Either<Failure, List<TimelineEvent>>> getTimelineEvents();
  Future<Either<Failure, void>> addTimelineEvent(TimelineEvent event);
  Future<Either<Failure, void>> updateTimelineEvent(TimelineEvent event);
  Future<Either<Failure, void>> deleteTimelineEvent(String eventId);
}
