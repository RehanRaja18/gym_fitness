import 'package:flutter/material.dart';

import '../../../workouts/data/workout_model.dart';
import 'workout_details_screen.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  static final List<Workout> workouts = [
    Workout(
      id: '1',
      title: 'Chest & Triceps',
      level: 'Intermediate',
      duration: 45,
      exercises: [
        'Bench Press',
        'Incline Dumbbell Press',
        'Chest Fly',
        'Tricep Dips',
        'Cable Pushdowns',
      ],
    ),
    Workout(
      id: '2',
      title: 'Leg Day',
      level: 'Hard',
      duration: 50,
      exercises: [
        'Squats',
        'Leg Press',
        'Lunges',
        'Leg Curls',
        'Calf Raises',
      ],
    ),
    Workout(
      id: '3',
      title: 'Cardio Burn',
      level: 'Beginner',
      duration: 30,
      exercises: [
        'Jump Rope',
        'Treadmill',
        'Cycling',
        'Burpees',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: workouts.length,
      itemBuilder: (context, index) {
        final workout = workouts[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            title: Text(workout.title),
            subtitle: Text(
              '${workout.duration} mins • ${workout.level}',
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => WorkoutDetailsScreen(
                    workout: workout,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
