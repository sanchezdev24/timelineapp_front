import 'package:flutter/material.dart';

class TimelineControls extends StatelessWidget {
  final VoidCallback onAddEvent;

  const TimelineControls({super.key, required this.onAddEvent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Leyenda
          Row(
            children: [
              _buildLegendItem(
                context,
                icon: Icons.home,
                label: 'Lugar de Vivienda',
                color: Colors.green,
              ),
              const SizedBox(width: 24),
              _buildLegendItem(
                context,
                icon: Icons.work,
                label: 'Trabajo',
                color: Colors.blue,
              ),
            ],
          ),
          // Botón agregar evento
          ElevatedButton.icon(
            onPressed: onAddEvent,
            icon: const Icon(Icons.add),
            label: const Text('Agregar Evento'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(icon, size: 12, color: Colors.white),
        ),
        const SizedBox(width: 8),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
