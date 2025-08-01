import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/timeline_event.dart';
import '../../domain/repositories/timeline_repository.dart';
import '../datasources/timeline_local_datasource.dart';
import '../models/timeline_event_model.dart';

class TimelineRepositoryImpl implements TimelineRepository {
  final TimelineLocalDataSource localDataSource;

  TimelineRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<TimelineEvent>>> getTimelineEvents() async {
    try {
      final localEvents = await localDataSource.getTimelineEvents();
      return Right(localEvents);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addTimelineEvent(TimelineEvent event) async {
    try {
      final eventModel = TimelineEventModel.fromEntity(event);
      await localDataSource.addTimelineEvent(eventModel);
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateTimelineEvent(TimelineEvent event) async {
    try {
      final eventModel = TimelineEventModel.fromEntity(event);
      await localDataSource.updateTimelineEvent(eventModel);
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteTimelineEvent(String eventId) async {
    try {
      await localDataSource.deleteTimelineEvent(eventId);
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
