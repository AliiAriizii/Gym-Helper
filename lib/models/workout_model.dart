class Exercise {
  final String name;
  final int sets;
  final String repsPattern;
  double weight;

  Exercise({
    required this.name,
    required this.sets,
    required this.repsPattern,
    this.weight = 0.0,
  });
}

class WorkoutDay {
  final String dayName;
  final String muscleGroup;
  final List<Exercise> exercises;
  final bool isRestDay;

  WorkoutDay({
    required this.dayName,
    required this.muscleGroup,
    required this.exercises,
    required this.isRestDay,
  });
}
  final List<WorkoutDay> weeklyWorkouts = [
  WorkoutDay(
    dayName: 'شنبه',
    muscleGroup: 'سینه و زیربغل',
    isRestDay: false,
    exercises: [
      Exercise(name: 'پرس سینه', sets: 4, repsPattern: '15-10-10-8'),
      Exercise(name: 'پرس سینه دمبل', sets: 3, repsPattern: '10-10-10'),
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
      // تکرارهای جلو ران از 20 به 12 اصلاح شد تا برای عضله‌سازی مناسب‌تر باشد
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
      // حرکت خطرناک «هالتر از پشت» حذف و با «پرس سرشانه دمبل» جایگزین شد
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
      // تعداد حرکات بازو از ۷ به ۵ حرکتِ استاندارد کاهش پیدا کرد تا انرژی هدر نرود
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
