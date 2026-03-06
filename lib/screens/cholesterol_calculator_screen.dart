import 'package:flutter/material.dart';

class CholesterolCalculatorScreen extends StatelessWidget {
  const CholesterolCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chol = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cholesterol Calculator'),
        backgroundColor: const Color(0xFFb71c1c),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _input(chol, 'Total Cholesterol (mg/dL)'),

            ElevatedButton(
              onPressed: () {
                final value = int.parse(chol.text);
                String result;

                if (value < 200) {
                  result = 'Normal';
                } else if (value < 240) {
                  result = 'Borderline High';
                } else {
                  result = 'High Cholesterol';
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
