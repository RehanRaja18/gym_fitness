import 'package:flutter/material.dart';
import 'workout_list_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Center(
        child: ElevatedButton(
          child: const Text('View Workouts'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const WorkoutListScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
