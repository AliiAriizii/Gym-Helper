import 'package:flutter/material.dart';
import '../models/workout_model.dart';
import 'plate_calculator_screen.dart';
import 'active_workout_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  WorkoutDay _getTodayWorkout() {
    int weekday = DateTime.now().weekday;
    String todayName = 'شنبه';
    
    switch (weekday) {
      case 6:
        todayName = 'شنبه';
        break;
      case 7:
        todayName = 'یکشنبه';
        break;
      case 1:
        todayName = 'دوشنبه';
        break;
      case 2:
        todayName = 'سه‌شنبه';
        break;
      case 3:
        todayName = 'چهارشنبه';
        break;
      case 4:
        todayName = 'پنج‌شنبه';
        break;
      case 5:
        todayName = 'جمعه';
        break;
    }

    return weeklyWorkouts.firstWhere(
      (workout) => workout.dayName == todayName,
      orElse: () => weeklyWorkouts[3],
    );
  }

  @override
  Widget build(BuildContext context) {
    final WorkoutDay todayWorkout = _getTodayWorkout();

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1F1F),
        title: const Text(
          'Gym Helper',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.calculate, color: Colors.greenAccent),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PlateCalculatorScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'برنامه‌ی امروز شما:',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${todayWorkout.dayName} (${todayWorkout.muscleGroup})',
                            style: const TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Icon(Icons.fitness_center, color: Colors.greenAccent, size: 40),
                    ],
                  ),
                  
                  // اگر روز استراحت نبود، دکمه شروع تمرین را نشان بده
                  if (!todayWorkout.isRestDay) ...[
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ActiveWorkoutScreen(workoutDay: todayWorkout),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'شروع تمرین امروز 🚀',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'لیست حرکات:',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: todayWorkout.isRestDay
                  ? const Center(
                      child: Text(
                        'امروز روز استراحت است. خوب بخواب و ریکاوری کن! 🔋',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: todayWorkout.exercises.length,
                      itemBuilder: (context, index) {
                        final exercise = todayWorkout.exercises[index];
                        return Card(
                          color: const Color(0xFF1E1E1E),
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            title: Text(
                              exercise.name,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'ست‌ها: ${exercise.sets} | تکرار: ${exercise.repsPattern}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.greenAccent, size: 16),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}