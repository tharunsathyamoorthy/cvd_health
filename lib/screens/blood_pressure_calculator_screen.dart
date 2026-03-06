import 'package:flutter/material.dart';

class BloodPressureCalculatorScreen extends StatelessWidget {
  const BloodPressureCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sys = TextEditingController();
    final dia = TextEditingController();
    String result = '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Pressure Calculator'),
        backgroundColor: const Color(0xFFb71c1c),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _input(sys, 'Systolic BP'),
            _input(dia, 'Diastolic BP'),

            ElevatedButton(
              onPressed: () {
                final s = int.parse(sys.text);
                final d = int.parse(dia.text);

                if (s < 120 && d < 80) {
                  result = 'Normal';
                } else if (s < 140 || d < 90) {
                  result = 'Elevated';
                } else {
                  result = 'High Blood Pressure';
                }

                showResult(context, result);
              },
              child: const Text('Calculate'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(TextEditingController c, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void showResult(BuildContext context, String result) {
    showDialog(
      context: context,
      builder:
          (_) =>
              AlertDialog(title: const Text('Result'), content: Text(result)),
    );
  }
}
