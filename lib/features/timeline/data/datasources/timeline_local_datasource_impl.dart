import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/timeline_event_model.dart';
import 'timeline_local_datasource.dart';

const cachedTimelineEvents = 'CACHED_TIMELINE_EVENTS';

class TimelineLocalDataSourceImpl implements TimelineLocalDataSource {
  final SharedPreferences sharedPreferences;

  TimelineLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<TimelineEventModel>> getTimelineEvents() {
    final jsonString = sharedPreferences.getString(cachedTimelineEvents);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return Future.value(
        jsonList.map((json) => TimelineEventModel.fromJson(json)).toList(),
      );
    } else {
      return Future.value([]);
    }
  }

  @override
  Future<void> cacheTimelineEvents(List<TimelineEventModel> events) {
    final jsonList = events.map((event) => event.toJson()).toList();
    return sharedPreferences.setString(
      cachedTimelineEvents,
      json.encode(jsonList),
    );
  }

  @override
  Future<void> addTimelineEvent(TimelineEventModel event) async {
    final events = await getTimelineEvents();
    events.add(event);
    await cacheTimelineEvents(events);
  }

  @override
  Future<void> updateTimelineEvent(TimelineEventModel event) async {
    final events = await getTimelineEvents();
    final index = events.indexWhere((e) => e.id == event.id);

    if (index != -1) {
      events[index] = event;
      await cacheTimelineEvents(events);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteTimelineEvent(String eventId) async {
    final events = await getTimelineEvents();
    events.removeWhere((event) => event.id == eventId);
    await cacheTimelineEvents(events);
  }
}
