import 'package:flutter/material.dart';
import '../../../workouts/data/workout_model.dart';

class WorkoutDetailsScreen extends StatelessWidget {
  final Workout workout;

  const WorkoutDetailsScreen({
    super.key,
    required this.workout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(workout.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoRow('Level', workout.level),
            _infoRow('Duration', '${workout.duration} minutes'),
            const SizedBox(height: 24),

            const Text(
              'Exercises',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: ListView.builder(
                itemCount: workout.exercises.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.fitness_center),
                    title: Text(workout.exercises[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        '$label: $value',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
