import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'result_screen.dart';

class RiskCalculator extends StatefulWidget {
  const RiskCalculator({super.key});

  @override
  State<RiskCalculator> createState() => _RiskCalculatorState();
}

class _RiskCalculatorState extends State<RiskCalculator> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController ageController = TextEditingController();
  final TextEditingController sysBPController = TextEditingController();
  final TextEditingController diaBPController = TextEditingController();
  final TextEditingController cholesterolController = TextEditingController();
  final TextEditingController glucoseController = TextEditingController();

  int gender = 1; // 1 = Male, 0 = Female
  int smoking = 0; // 1 = Yes, 0 = No
  int activity = 1; // 1 = Active, 0 = Inactive

  bool isLoading = false;

  // ===================== SUBMIT =====================
  Future<void> submitData() async {
    if (!_formKey.currentState!.validate()) return;

    final inputData = {
      "age": int.parse(ageController.text),
      "gender": gender,
      "systolic_bp": int.parse(sysBPController.text),
      "diastolic_bp": int.parse(diaBPController.text),
      "cholesterol": int.parse(cholesterolController.text),
      "glucose": int.parse(glucoseController.text),
      "smoking": smoking,
      "activity": activity,
    };

    try {
      setState(() => isLoading = true);

      final result = await ApiService.predict(inputData);

      setState(() => isLoading = false);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResultScreen(result: result)),
      );
    } catch (e) {
      setState(() => isLoading = false);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Prediction failed: $e")));
    }
  }

  // ===================== UI =====================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("CVD Risk Calculator"),
        centerTitle: true,
        backgroundColor: const Color(0xFFB11226),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB11226), Color(0xFFF5F5F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      "Enter Patient Details",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    buildTextField("Age", ageController),
                    buildTextField("Systolic BP", sysBPController),
                    buildTextField("Diastolic BP", diaBPController),
                    buildTextField("Cholesterol", cholesterolController),
                    buildTextField("Glucose Level", glucoseController),

                    const SizedBox(height: 16),

                    buildRadioGroup(
                      title: "Gender",
                      value: gender,
                      options: const {1: "Male", 0: "Female"},
                      onChanged: (v) => setState(() => gender = v),
                    ),

                    buildRadioGroup(
                      title: "Smoking",
                      value: smoking,
                      options: const {1: "Yes", 0: "No"},
                      onChanged: (v) => setState(() => smoking = v),
                    ),

                    buildRadioGroup(
                      title: "Physical Activity",
                      value: activity,
                      options: const {1: "Active", 0: "Inactive"},
                      onChanged: (v) => setState(() => activity = v),
                    ),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB11226),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: isLoading ? null : submitData,
                        child:
                            isLoading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : const Text(
                                  "Calculate Risk",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ===================== COMMON WIDGETS =====================
  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator:
            (value) => value == null || value.isEmpty ? "Required" : null,
      ),
    );
  }

  Widget buildRadioGroup({
    required String title,
    required int value,
    required Map<int, String> options,
    required Function(int) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children:
              options.entries.map((entry) {
                return Expanded(
                  child: RadioListTile<int>(
                    title: Text(entry.value),
                    value: entry.key,
                    groupValue: value,
                    activeColor: const Color(0xFFB11226),
                    onChanged: (v) => onChanged(v!),
                  ),
                );
              }).toList(),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
