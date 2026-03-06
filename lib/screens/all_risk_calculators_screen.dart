import 'package:flutter/material.dart';
import 'blood_pressure_calculator_screen.dart';
import 'diabetes_calculator_screen.dart';
import 'blood_sugar_calculator_screen.dart';
import 'cholesterol_calculator_screen.dart';
import 'bmi_calculator_screen.dart';
import 'lifestyle_calculator_screen.dart';

class AllRiskCalculatorsPanel extends StatelessWidget {
  const AllRiskCalculatorsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.only(bottom: 14.0),
            child: Text(
              'Common cardiovascular risk factor calculators',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Top Row (2 calculators)
          Container(
            height: 140, // 🔧 FIX: increased from 130 to prevent overflow
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade200),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 5,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  const BloodPressureCalculatorScreen(),
                        ),
                      );
                    },
                    child: _factorCard(
                      icon: Icons.monitor_heart_outlined,
                      title: 'Blood\nPressure',
                      subtitle: 'Assessment',
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: double.infinity,
                  color: Colors.grey[300],
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => const DiabetesCalculatorScreen(),
                        ),
                      );
                    },
                    child: _factorCard(
                      icon: Icons.bloodtype_outlined,
                      title: 'Diabetes',
                      subtitle: 'Type 2\ndiabetes risk',
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Bottom 2x2 Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 7,
            mainAxisSpacing: 10,
            childAspectRatio: 1.0,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BloodSugarCalculatorScreen(),
                    ),
                  );
                },
                child: _gridCard(
                  icon: Icons.water_drop_outlined,
                  title: 'Blood\nSugar',
                  subtitle: 'Glucose\nlevels',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CholesterolCalculatorScreen(),
                    ),
                  );
                },
                child: _gridCard(
                  icon: Icons.science_outlined,
                  title: 'Cholesterol',
                  subtitle: 'Lipid\nprofile',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BmiCalculatorScreen(),
                    ),
                  );
                },
                child: _gridCard(
                  icon: Icons.favorite_outline,
                  title: 'BMI',
                  subtitle: 'Body mass\nindex',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LifestyleCalculatorScreen(),
                    ),
                  );
                },
                child: _gridCard(
                  icon: Icons.health_and_safety_outlined,
                  title: 'Lifestyle',
                  subtitle: 'Smoking &\nactivity',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===== TOP ROW CARD =====
  Widget _factorCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 36, color: const Color(0xFFb71c1c)),
          const SizedBox(height: 7),
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ===== GRID CARD =====
  Widget _gridCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 34, color: const Color(0xFFb71c1c)),
          const SizedBox(height: 7),
          Text(
            title,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(fontSize: 9.5, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
