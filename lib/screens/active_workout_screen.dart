import 'dart:async';
import 'package:flutter/material.dart';
import '../models/workout_model.dart';

class ActiveWorkoutScreen extends StatefulWidget {
  final WorkoutDay workoutDay;

  const ActiveWorkoutScreen({super.key, required this.workoutDay});

  @override
  State<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen> {
  int _remainingSeconds = 0;
  Timer? _timer;
  bool _isResting = false;

  void _startRestTimer(int seconds) {
    _timer?.cancel();
    setState(() {
      _remainingSeconds = seconds;
      _isResting = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel();
        setState(() {
          _isResting = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1F1F),
        title: Text(
          'تمرین امروز: ${widget.workoutDay.muscleGroup}',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          if (_isResting)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.greenAccent.withOpacity(0.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.timer, color: Colors.greenAccent),
                  const SizedBox(width: 10),
                  Text(
                    'استراحت بین ست‌ها: ${_remainingSeconds} ثانیه',
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 15),
                  TextButton(
                    onPressed: () {
                      _timer?.cancel();
                      setState(() {
                        _isResting = false;
                      });
                    },
                    child: const Text('پایان استراحت', style: TextStyle(color: Colors.redAccent)),
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.workoutDay.exercises.length,
              itemBuilder: (context, index) {
                final Exercise exercise = widget.workoutDay.exercises[index];
                return Card(
                  color: const Color(0xFF1E1E1E),
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exercise.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'تعداد ست: ${exercise.sets} | الگو تکرار: ${exercise.repsPattern}',
                          style: const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ثبت ست‌های انجام شده:',
                              style: TextStyle(color: Colors.greenAccent.shade200, fontSize: 13),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                _startRestTimer(60);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2C2C2C),
                                foregroundColor: Colors.greenAccent,
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              ),
                              icon: const Icon(Icons.check, size: 18),
                              label: const Text('ثبت ست (تایمر ۶۰ ثانیه)'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}