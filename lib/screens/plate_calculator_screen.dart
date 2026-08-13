import 'package:flutter/material.dart';

class PlateCalculatorScreen extends StatefulWidget {
  const PlateCalculatorScreen({super.key});

  @override
  State<PlateCalculatorScreen> createState() => _PlateCalculatorScreenState();
}

class _PlateCalculatorScreenState extends State<PlateCalculatorScreen> {
  final TextEditingController _weightController = TextEditingController();
  double _selectedBarWeight = 10.0; // پیش‌فرض 10 کیلو
  
  Map<double, int> platesNeeded = {};
  bool calculated = false;

  final List<double> availableBars = [10.0, 15.0, 20.0];
  final List<double> availablePlates = [20, 15, 10, 5, 2.5, 1.25];

  void _calculatePlates() {
    double totalWeight = double.tryParse(_weightController.text) ?? 0.0;

    if (totalWeight <= _selectedBarWeight) {
      setState(() {
        platesNeeded.clear();
        calculated = true;
      });
      return;
    }

    double weightPerSide = (totalWeight - _selectedBarWeight) / 2;
    Map<double, int> result = {};

    for (var plate in availablePlates) {
      if (weightPerSide <= 0) break;
      int count = (weightPerSide ~/ plate);
      if (count > 0) {
        result[plate] = count;
        weightPerSide -= (count * plate);
      }
    }

    setState(() {
      platesNeeded = result;
      calculated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1F1F),
        title: const Text(
          'ماشین‌حساب صفحات هالتر',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'وزن هالتر خود را انتخاب کنید و وزن کل مورد نظر را وارد نمایید:',
                style: TextStyle(color: Colors.grey, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('وزن هالتر: ', style: TextStyle(color: Colors.white)),
                const SizedBox(width: 10),
                DropdownButton<double>(
                  value: _selectedBarWeight,
                  dropdownColor: const Color(0xFF1F1F1F),
                  style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),
                  items: availableBars.map((bar) {
                    return DropdownMenuItem<double>(
                      value: bar,
                      child: Text('${bar.toInt()} کیلوگرم'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedBarWeight = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'وزن کل (کیلوگرم)',
                labelStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.greenAccent),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculatePlates,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'محاسبه صفحات',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'صفحات مورد نیاز برای هر طرف هالتر:',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: !calculated
                  ? const Center(
                      child: Text('هنوز وزنی وارد نشده است.', style: TextStyle(color: Colors.grey)),
                    )
                  : platesNeeded.isEmpty
                      ? const Center(
                          child: Text(
                            'وزن کل باید بیشتر از وزن هالتر انتخاب شده باشد!',
                            style: TextStyle(color: Colors.redAccent),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView(
                          children: platesNeeded.entries.map((entry) {
                            return Card(
                              color: const Color(0xFF1E1E1E),
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                leading: const Icon(Icons.radio_button_checked, color: Colors.greenAccent),
                                title: Text(
                                  'صفحه ${entry.key} کیلویی',
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                                trailing: Text(
                                  '${entry.value} عدد',
                                  style: const TextStyle(color: Colors.greenAccent, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}