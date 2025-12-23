import 'dart:async';
import 'workout_model.dart';

class WorkoutService {
  Future<List<WorkoutModel>> fetchWorkouts() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      WorkoutModel(
        id: '1',
        title: 'Chest Day',
        description: 'Bench press, push-ups, chest fly',
      ),
      WorkoutModel(
        id: '2',
        title: 'Leg Day',
        description: 'Squats, lunges, leg press',
      ),
    ];
  }
}
