import 'package:flutter/material.dart';

import '../../domain/entities/timeline_event.dart';
import 'event_card.dart';

class TimelineCanvas extends StatefulWidget {
  final List<TimelineEvent> events;
  final Function(TimelineEvent) onEventTap;

  const TimelineCanvas({
    super.key,
    required this.events,
    required this.onEventTap,
  });

  @override
  State<TimelineCanvas> createState() => _TimelineCanvasState();
}

class _TimelineCanvasState extends State<TimelineCanvas> {
  final ScrollController _scrollController = ScrollController();
  final DateTime _timelineStart = DateTime(2015, 1, 1);
  final DateTime _timelineEnd = DateTime(2025, 12, 31);
  final double _timelineWidth = 4000.0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.events.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.timeline,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'No hay eventos en la línea de tiempo',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Presiona "Agregar Evento" para empezar',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: _timelineWidth,
          height: 500,
          child: Stack(
            children: [
              // Timeline line
              Positioned(
                top: 250,
                left: 0,
                right: 0,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Year markers
              ...List.generate(11, (index) {
                final year = 2015 + index;
                final position = _getPositionFromDate(DateTime(year, 1, 1));

                return Positioned(
                  left: position,
                  top: 235,
                  child: Column(
                    children: [
                      Container(
                        width: 2,
                        height: 30,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        year.toString(),
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              }),

              // Month markers
              ...List.generate(11, (yearIndex) {
                final year = 2015 + yearIndex;
                return Stack(
                  children: List.generate(12, (monthIndex) {
                    final month = monthIndex + 1;
                    final position = _getPositionFromDate(
                      DateTime(year, month, 1),
                    );

                    if (monthIndex == 0)
                      return const SizedBox(); // Skip January (year marker)

                    return Positioned(
                      left: position,
                      top: 240,
                      child: Column(
                        children: [
                          Container(
                            width: 1,
                            height: 15,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _getMonthName(month),
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                          ),
                        ],
                      ),
                    );
                  }),
                );
              }),

              // Events
              ...widget.events.map((event) {
                final position = _getPositionFromDate(event.startDate);
                final isVivienda = event.type == EventType.vivienda;

                return Positioned(
                  left: position,
                  top: isVivienda ? 300 : 80, // Vivienda below, Trabajo above
                  child: EventCard(
                    event: event,
                    onTap: () => widget.onEventTap(event),
                    width: _calculateEventWidth(event),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  double _getPositionFromDate(DateTime date) {
    final totalMs =
        _timelineEnd.millisecondsSinceEpoch -
        _timelineStart.millisecondsSinceEpoch;
    final dateMs =
        date.millisecondsSinceEpoch - _timelineStart.millisecondsSinceEpoch;

    // Ensure position is within bounds
    final ratio = (dateMs / totalMs).clamp(0.0, 1.0);
    return ratio * _timelineWidth;
  }

  double _calculateEventWidth(TimelineEvent event) {
    if (event.endDate == null) {
      return 150.0; // Default width for single-date events
    }

    final startPos = _getPositionFromDate(event.startDate);
    final endPos = _getPositionFromDate(event.endDate!);
    final width = (endPos - startPos).abs();

    return width < 150 ? 150 : width; // Minimum width of 150
  }

  String _getMonthName(int month) {
    const months = [
      '',
      'Ene',
      'Feb',
      'Mar',
      'Abr',
      'May',
      'Jun',
      'Jul',
      'Ago',
      'Sep',
      'Oct',
      'Nov',
      'Dic',
    ];
    return months[month];
  }
}
