import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'result_screen.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

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

  int gender = 1;
  int smoking = 0;
  int activity = 1;

  bool isLoading = false;

  Future<void> submitData() async {
    if (!_formKey.currentState!.validate()) return;

    final inputData = {
      "age": int.tryParse(ageController.text) ?? 0,
      "gender": gender,
      "systolic_bp": int.tryParse(sysBPController.text) ?? 0,
      "diastolic_bp": int.tryParse(diaBPController.text) ?? 0,
      "cholesterol": int.tryParse(cholesterolController.text) ?? 0,
      "glucose": int.tryParse(glucoseController.text) ?? 0,
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

  Future<void> syncSmartwatchData() async {
    await Permission.activityRecognition.request();

    try {
      Pedometer.stepCountStream.listen((StepCount event) {
        int steps = event.steps;

        setState(() {
          if (steps > 7000) {
            activity = 1;
          } else {
            activity = 0;
          }
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Steps synced from phone sensor")),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Step sensor not available")));
    }
  }

  @override
  void dispose() {
    ageController.dispose();
    sysBPController.dispose();
    diaBPController.dispose();
    cholesterolController.dispose();
    glucoseController.dispose();
    super.dispose();
  }

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

                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: syncSmartwatchData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Sync Step Data"),
                      ),
                    ),

                    const SizedBox(height: 16),

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
