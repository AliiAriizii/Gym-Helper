import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const GymHelperApp());
}

class GymHelperApp extends StatelessWidget {
  const GymHelperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym Helper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        cardColor: const Color(0xFF0A0A0A),
        primaryColor: const Color(0xFF00F0FF),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00F0FF),
          secondary: Color(0xFFFF0055),
          surface: Color(0xFF121212),
        ),
      ),
      home: const MainDashboard(),
    );
  }
}

class Exercise {
  final String name;
  final int sets;
  final String repsPattern;
  List<bool> completedSets;

  Exercise({required this.name, required this.sets, required this.repsPattern})
      : completedSets = List.generate(sets, (index) => false);
}

class WorkoutDay {
  final String dayName;
  final String muscleGroup;
  final bool isRestDay;
  final List<Exercise> exercises;
  WorkoutDay({
    required this.dayName,
    required this.muscleGroup,
    required this.isRestDay,
    required this.exercises,
  });
}

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _currentIndex = 0;
  final List<Map<String, dynamic>> _weightLogs = [
    {'date': 'امروز', 'weight': 50.0},
  ];
  final TextEditingController _weightController = TextEditingController();

  final List<WorkoutDay> weeklyWorkouts = [
    WorkoutDay(
      dayName: 'شنبه',
      muscleGroup: 'سینه و زیربغل',
      isRestDay: false,
      exercises: [
        Exercise(name: 'پرس سینه', sets: 4, repsPattern: '15-10-10-8'),
        Exercise(name: 'پرس بالا سینه', sets: 3, repsPattern: '10-8-8'),
        Exercise(name: 'قفسه سینه', sets: 3, repsPattern: '12-12-12'),
        Exercise(name: 'زیربغل سیم‌کش جلو', sets: 3, repsPattern: '10-10-10'),
        Exercise(name: 'زیربغل اره‌ای دمبل', sets: 3, repsPattern: '10-10-10'),
        Exercise(name: 'زیربغل پلاور دمبل', sets: 3, repsPattern: '10-10-10'),
      ],
    ),
    WorkoutDay(
      dayName: 'یکشنبه',
      muscleGroup: 'پا',
      isRestDay: false,
      exercises: [
        Exercise(name: 'جلو ران', sets: 4, repsPattern: '12-12-12-12'),
        Exercise(name: 'اسکات با اسمیت', sets: 3, repsPattern: '10-10-10'),
        Exercise(name: 'هاگ پا خوابیده', sets: 3, repsPattern: '10-10-10'),
        Exercise(name: 'پشت ران دستگاه', sets: 3, repsPattern: '10-10-10'),
        Exercise(name: 'ساق پا', sets: 4, repsPattern: '10-10-10-10'),
      ],
    ),
    WorkoutDay(
      dayName: 'دوشنبه',
      muscleGroup: 'سرشانه و کول',
      isRestDay: false,
      exercises: [
        Exercise(name: 'پرس سرشانه دمبل', sets: 4, repsPattern: '10-10-10-10'),
        Exercise(name: 'سرشانه دمبل روی میز', sets: 3, repsPattern: '10-10-10'),
        Exercise(name: 'سرشانه نشر از جانب', sets: 4, repsPattern: '10-10-10-10'),
        Exercise(name: 'سرشانه دمبل جلو', sets: 4, repsPattern: '10-10-10-10'),
        Exercise(name: 'سرشانه خم', sets: 4, repsPattern: '10-10-10-10'),
        Exercise(name: 'کول هالتر', sets: 4, repsPattern: '10-10-10-10'),
      ],
    ),
    WorkoutDay(
      dayName: 'سه‌شنبه',
      muscleGroup: 'استراحت',
      isRestDay: true,
      exercises: [],
    ),
    WorkoutDay(
      dayName: 'چهارشنبه',
      muscleGroup: 'بازو (جلو و پشت)',
      isRestDay: false,
      exercises: [
        Exercise(name: 'جلو بازو سیم‌کش', sets: 3, repsPattern: '10-10-10'),
        Exercise(name: 'جلو بازو هالتر', sets: 3, repsPattern: '10-10-10'),
        Exercise(name: 'جلو بازو دمبل', sets: 3, repsPattern: '10-10-10'),
        Exercise(name: 'پشت بازو سیم‌کش', sets: 3, repsPattern: '10-10-10'),
        Exercise(name: 'پشت بازو پشت سر دمبل', sets: 3, repsPattern: '10-10-10'),
      ],
    ),
    WorkoutDay(
      dayName: 'پنج‌شنبه',
      muscleGroup: 'تعطیل',
      isRestDay: true,
      exercises: [],
    ),
    WorkoutDay(
      dayName: 'جمعه',
      muscleGroup: 'تعطیل',
      isRestDay: true,
      exercises: [],
    ),
  ];

  int _getTodayIndex() {
    var weekday = DateTime.now().weekday;
    switch (weekday) {
      case DateTime.saturday:
        return 0;
      case DateTime.sunday:
        return 1;
      case DateTime.monday:
        return 2;
      case DateTime.tuesday:
        return 3;
      case DateTime.wednesday:
        return 4;
      case DateTime.thursday:
        return 5;
      case DateTime.friday:
        return 6;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildWorkoutScreen(),
      _buildProgressScreen(),
      _buildTimerScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('GYM HELPER', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2, color: Color(0xFF00F0FF))),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00F0FF).withOpacity(0.15),
              blurRadius: 30,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            pages[_currentIndex],
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: const Color(0xFF00F0FF).withOpacity(0.4), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00F0FF).withOpacity(0.2),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNavItem(Icons.fitness_center, 'تمرین', 0),
                        _buildNavItem(Icons.show_chart, 'وزن', 1),
                        _buildNavItem(Icons.timer, 'تایمر', 2),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00F0FF).withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? const Color(0xFF00F0FF) : Colors.grey),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(label, style: const TextStyle(color: Color(0xFF00F0FF), fontWeight: FontWeight.bold)),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutScreen() {
    int todayIdx = _getTodayIndex();

    return DefaultTabController(
      initialIndex: todayIdx,
      length: weeklyWorkouts.length,
      child: Column(
        children: [
          Container(
            color: Colors.black,
            child: TabBar(
              isScrollable: true,
              labelColor: const Color(0xFF00F0FF),
              unselectedLabelColor: Colors.grey,
              indicatorColor: const Color(0xFF00F0FF),
              tabs: weeklyWorkouts.map((w) => Tab(text: w.dayName)).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: weeklyWorkouts.map((day) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 90),
                  child: day.isRestDay
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.bedtime, size: 64, color: Color(0xFFFF0055)),
                              SizedBox(height: 16),
                              Text(
                                'امروز روز استراحت و ریکاوری است 🛌',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      : ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                              child: Text(
                                'عضلات هدف: ${day.muscleGroup}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF00F0FF),
                                ),
                              ),
                            ),
                            ...day.exercises.map((ex) {
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF121212),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: const Color(0xFF00F0FF).withOpacity(0.2)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF00F0FF).withOpacity(0.05),
                                      blurRadius: 8,
                                    )
                                  ],
                                ),
                                child: ExpansionTile(
                                  title: Text(
                                    ex.name,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Text(
                                      'کل ست‌ها: ${ex.sets}   |   تکرار: ${ex.repsPattern}',
                                      style: const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.timer, color: Color(0xFF00F0FF)),
                                    onPressed: () => setState(() => _currentIndex = 2),
                                    tooltip: 'رفتن به تایمر',
                                  ),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Wrap(
                                        spacing: 10,
                                        children: List.generate(ex.sets, (setIndex) {
                                          bool isDone = ex.completedSets[setIndex];
                                          return ChoiceChip(
                                            label: Text('ست ${setIndex + 1}'),
                                            selected: isDone,
                                            selectedColor: const Color(0xFF00F0FF),
                                            labelStyle: TextStyle(
                                              color: isDone ? Colors.black : Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            onSelected: (selected) {
                                              setState(() {
                                                ex.completedSets[setIndex] = selected;
                                              });
                                            },
                                          );
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressScreen() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ثبت وزن جدید (مسیر افزایش حجم)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF00F0FF)),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00F0FF).withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'وزن به کیلوگرم (مثلا 51)',
                      labelStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: const Color(0xFF121212),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF00F0FF), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF00F0FF), width: 2),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00F0FF),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 10,
                  shadowColor: const Color(0xFF00F0FF),
                ),
                onPressed: () {
                  if (_weightController.text.isNotEmpty) {
                    setState(() {
                      _weightLogs.insert(0, {
                        'date': 'جدید',
                        'weight': double.tryParse(_weightController.text) ?? 0.0,
                      });
                    });
                    _weightController.clear();
                  }
                },
                child: const Text('ثبت', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'تاریخچه وزن‌های ثبت شده:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: _weightLogs.length,
              itemBuilder: (context, index) {
                final log = _weightLogs[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF121212),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF00F0FF).withOpacity(0.15)),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFF00F0FF),
                      child: Icon(Icons.monitor_weight, color: Colors.black),
                    ),
                    title: Text('${log['weight']} کیلوگرم', style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('ثبت شده در: ${log['date']}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  int _remainingSeconds = 90;
  Timer? _timer;
  bool _isRunning = false;

  void _startTimer(int seconds) {
    _timer?.cancel();
    setState(() {
      _remainingSeconds = seconds;
      _isRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel();
        setState(() {
          _isRunning = false;
        });
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _weightController.dispose();
    super.dispose();
  }

  Widget _buildTimerScreen() {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    String timeFormatted = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    bool isFinished = _remainingSeconds == 0;

    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 90),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'تایمر استراحت بین ست‌ها',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF00F0FF)),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF121212),
                border: Border.all(color: isFinished ? const Color(0xFFFF0055) : const Color(0xFF00F0FF), width: 3),
                boxShadow: [
                  BoxShadow(
                    color: (isFinished ? const Color(0xFFFF0055) : const Color(0xFF00F0FF)).withOpacity(0.4),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Text(
                timeFormatted,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: isFinished ? const Color(0xFFFF0055) : const Color(0xFF00F0FF),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF0055)),
                  onPressed: _stopTimer,
                  child: const Text('توقف'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00F0FF), foregroundColor: Colors.black),
                  onPressed: () => _startTimer(_remainingSeconds == 0 ? 90 : _remainingSeconds),
                  child: Text(_isRunning ? 'ادامه' : 'شروع', style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text('انتخاب زمان‌های پرکاربرد:', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFF00F0FF))),
                  onPressed: () => _startTimer(45),
                  child: const Text('۴۵ ثانیه', style: TextStyle(color: Color(0xFF00F0FF))),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFF00F0FF))),
                  onPressed: () => _startTimer(90),
                  child: const Text('۹۰ ثانیه', style: TextStyle(color: Color(0xFF00F0FF))),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFF00F0FF))),
                  onPressed: () => _startTimer(120),
                  child: const Text('۲ دقیقه', style: TextStyle(color: Color(0xFF00F0FF))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}