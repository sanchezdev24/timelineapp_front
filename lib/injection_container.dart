import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/timeline/data/datasources/timeline_local_datasource.dart';
import 'features/timeline/data/datasources/timeline_local_datasource_impl.dart';
import 'features/timeline/data/repositories/timeline_repository_impl.dart';
import 'features/timeline/domain/repositories/timeline_repository.dart';
import 'features/timeline/domain/usecases/add_timeline_event.dart';
import 'features/timeline/domain/usecases/delete_timeline_event.dart';
import 'features/timeline/domain/usecases/get_timeline_events.dart';
import 'features/timeline/domain/usecases/update_timeline_event.dart';
import 'features/timeline/presentation/bloc/timeline_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Timeline
  // Bloc
  sl.registerFactory(
    () => TimelineBloc(
      getTimelineEvents: sl(),
      addTimelineEvent: sl(),
      updateTimelineEvent: sl(),
      deleteTimelineEvent: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetTimelineEvents(sl()));
  sl.registerLazySingleton(() => AddTimelineEvent(sl()));
  sl.registerLazySingleton(() => UpdateTimelineEvent(sl()));
  sl.registerLazySingleton(() => DeleteTimelineEvent(sl()));

  // Repository
  sl.registerLazySingleton<TimelineRepository>(
    () => TimelineRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<TimelineLocalDataSource>(
    () => TimelineLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
