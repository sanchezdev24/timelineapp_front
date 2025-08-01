import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/timeline_event.dart';
import '../bloc/timeline_bloc.dart';
import '../bloc/timeline_event.dart';
import '../bloc/timeline_state.dart';
import '../widgets/event_form_dialog.dart';
import '../widgets/timeline_canvas.dart';
import '../widgets/timeline_controls.dart';

class TimelinePage extends StatelessWidget {
  const TimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Línea de Tiempo Personal'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      body: Column(
        children: [
          TimelineControls(onAddEvent: () => _showEventDialog(context)),
          Expanded(
            child: BlocBuilder<TimelineBloc, TimelineState>(
              builder: (context, state) {
                if (state is TimelineInitial) {
                  return const Center(
                    child: Text('Presiona el botón para cargar eventos'),
                  );
                } else if (state is TimelineLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TimelineLoaded) {
                  return TimelineCanvas(
                    events: state.events,
                    onEventTap: (event) =>
                        _showEventDialog(context, event: event),
                  );
                } else if (state is TimelineError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error: ${state.message}',
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<TimelineBloc>().add(
                              LoadTimelineEvents(),
                            );
                          },
                          child: const Text('Reintentar'),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showEventDialog(BuildContext context, {TimelineEvent? event}) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<TimelineBloc>(),
        child: EventFormDialog(event: event),
      ),
    );
  }
}
