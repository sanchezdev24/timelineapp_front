import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/timeline/presentation/bloc/timeline_bloc.dart';
import 'features/timeline/presentation/bloc/timeline_event.dart';
import 'features/timeline/presentation/pages/timeline_page.dart';
import 'injection_container.dart' as di;
import 'theme/theme.dart';
import 'theme/util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.platformBrightnessOf(context);

    TextTheme textTheme = createTextTheme(context, "Antic", "Antic");
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'Timeline Personal',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),

      home: BlocProvider(
        create: (_) =>
            GetIt.instance<TimelineBloc>()..add(LoadTimelineEvents()),
        child: const TimelinePage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
