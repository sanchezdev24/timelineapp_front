import '../models/timeline_event_model.dart';

abstract class TimelineLocalDataSource {
  /// Gets the cached list of [TimelineEventModel]
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<TimelineEventModel>> getTimelineEvents();

  /// Caches the timeline events
  Future<void> cacheTimelineEvents(List<TimelineEventModel> events);

  /// Adds a single timeline event
  Future<void> addTimelineEvent(TimelineEventModel event);

  /// Updates a timeline event
  Future<void> updateTimelineEvent(TimelineEventModel event);

  /// Deletes a timeline event
  Future<void> deleteTimelineEvent(String eventId);
}
