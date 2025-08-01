import 'package:flutter/material.dart';

import '../../domain/entities/timeline_event.dart';

class EventCard extends StatelessWidget {
  final TimelineEvent event;
  final VoidCallback onTap;
  final double width;

  const EventCard({
    super.key,
    required this.event,
    required this.onTap,
    this.width = 150.0,
  });

  @override
  Widget build(BuildContext context) {
    final isVivienda = event.type == EventType.vivienda;
    final color = isVivienda ? Colors.green : Colors.blue;
    final icon = isVivienda ? Icons.home : Icons.work;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border(left: BorderSide(color: color, width: 4)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with icon and badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    event.title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, size: 16, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Date information
            Text(
              _formatDateRange(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.outline,
                fontWeight: FontWeight.w500,
              ),
            ),

            // Description if available
            if (event.description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                event.description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDateRange() {
    // Simple date formatting without locale dependency
    final startFormatted =
        '${_getMonthName(event.startDate.month)} ${event.startDate.year}';

    if (event.endDate != null) {
      final endFormatted =
          '${_getMonthName(event.endDate!.month)} ${event.endDate!.year}';
      return '$startFormatted - $endFormatted';
    }

    return startFormatted;
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
