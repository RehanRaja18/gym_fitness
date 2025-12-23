import 'package:flutter/material.dart';

import '../../../workouts/data/workout_model.dart';
import '../../../workouts/data/workout_service.dart';


class WorkoutListScreen extends StatefulWidget {
  const WorkoutListScreen({super.key});

  @override
  State<WorkoutListScreen> createState() => _WorkoutListScreenState();
}

class _WorkoutListScreenState extends State<WorkoutListScreen> {
  final WorkoutService _service = WorkoutService();
  late Future<List<WorkoutModel>> _workouts;

  @override
  void initState() {
    super.initState();
    _workouts = _service.fetchWorkouts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workouts')),
      body: FutureBuilder<List<WorkoutModel>>(
        future: _workouts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final workouts = snapshot.data!;

          return ListView.builder(
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              final workout = workouts[index];
              return ListTile(
                title: Text(workout.title),
                subtitle: Text(workout.description),
              );
            },
          );
        },
      ),
    );
  }
}
