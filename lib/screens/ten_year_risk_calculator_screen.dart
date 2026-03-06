import 'package:flutter/material.dart';
import '../services/ten_year_risk_service.dart';

class TenYearRiskCalculatorScreen extends StatefulWidget {
  const TenYearRiskCalculatorScreen({super.key});

  @override
  State<TenYearRiskCalculatorScreen> createState() =>
      _TenYearRiskCalculatorScreenState();
}

class _TenYearRiskCalculatorScreenState
    extends State<TenYearRiskCalculatorScreen> {
  final ageController = TextEditingController();
  final bpController = TextEditingController();
  final cholesterolController = TextEditingController();

  bool smoker = false;
  bool diabetic = false;
  bool active = true;

  Map<String, dynamic>? result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Up to 10-Year Risk Calculator"),
        backgroundColor: const Color(0xFFb71c1c),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _input(ageController, "Age"),
            _input(bpController, "Systolic BP"),
            _input(cholesterolController, "Cholesterol"),

            SwitchListTile(
              title: const Text("Smoker"),
              value: smoker,
              onChanged: (v) => setState(() => smoker = v),
            ),
            SwitchListTile(
              title: const Text("Diabetic"),
              value: diabetic,
              onChanged: (v) => setState(() => diabetic = v),
            ),
            SwitchListTile(
              title: const Text("Physically Active"),
              value: active,
              onChanged: (v) => setState(() => active = v),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFb71c1c),
              ),
              onPressed: () {
                setState(() {
                  result = TenYearRiskService.calculate(
                    age: int.parse(ageController.text),
                    systolicBP: int.parse(bpController.text),
                    cholesterol: int.parse(cholesterolController.text),
                    smoker: smoker,
                    diabetic: diabetic,
                    active: active,
                  );
                });
              },
              child: const Text("Calculate 10-Year Risk"),
            ),

            const SizedBox(height: 20),

            if (result != null)
              Card(
                child: ListTile(
                  title: Text(
                    result!["risk_level"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    "Risk Score: ${result!["risk_score"]}\nModel: ${result!["model_type"]}",
                  ),
                ),
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
}
