import 'dart:math';
import 'package:flutter/material.dart';

class BmiCalculatorScreen extends StatefulWidget {
  const BmiCalculatorScreen({super.key});

  @override
  State<BmiCalculatorScreen> createState() => _BmiCalculatorScreenState();
}

class _BmiCalculatorScreenState extends State<BmiCalculatorScreen> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  double? bmi;
  String status = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        backgroundColor: const Color(0xFFb71c1c),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _input(heightController, 'Height (cm)'),
            _input(weightController, 'Weight (kg)'),

            const SizedBox(height: 14),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _calculateBMI,
                child: const Text('Calculate'),
              ),
            ),

            if (bmi != null) ...[
              const SizedBox(height: 28),

              /// SPEEDOMETER
              BmiGauge(bmi: bmi!),

              const SizedBox(height: 14),

              /// BMI TEXT (BLACK & BELOW)
              Text(
                'BMI = ${bmi!.toStringAsFixed(1)}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 6),

              /// STATUS TEXT
              Text(
                status,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: status == 'Normal' ? Colors.green : Colors.red,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _input(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  void _calculateBMI() {
    final height = double.tryParse(heightController.text);
    final weight = double.tryParse(weightController.text);

    if (height == null || weight == null || height <= 0 || weight <= 0) return;

    final result = weight / pow(height / 100, 2);

    setState(() {
      bmi = result;
      status = _bmiCategory(result);
    });
  }

  String _bmiCategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }
}

/* ================= BMI SPEEDOMETER ================= */

class BmiGauge extends StatelessWidget {
  final double bmi;

  const BmiGauge({super.key, required this.bmi});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(280, 170),
      painter: _BmiGaugePainter(bmi),
    );
  }
}

class _BmiGaugePainter extends CustomPainter {
  final double bmi;

  _BmiGaugePainter(this.bmi);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;

    final paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 18
          ..strokeCap = StrokeCap.round;

    _drawArc(canvas, center, radius, paint, 0, 18.5, Colors.red);
    _drawArc(canvas, center, radius, paint, 18.5, 25, Colors.green);
    _drawArc(canvas, center, radius, paint, 25, 30, Colors.orange);
    _drawArc(canvas, center, radius, paint, 30, 40, Colors.red.shade900);

    /// NEEDLE
    final angle = _bmiToAngle(bmi);
    final needlePaint =
        Paint()
          ..color = Colors.black
          ..strokeWidth = 3;

    final needleEnd = Offset(
      center.dx + (radius - 25) * cos(angle),
      center.dy + (radius - 25) * sin(angle),
    );

    canvas.drawLine(center, needleEnd, needlePaint);
    canvas.drawCircle(center, 6, Paint()..color = Colors.black);
  }

  void _drawArc(
    Canvas canvas,
    Offset center,
    double radius,
    Paint paint,
    double start,
    double end,
    Color color,
  ) {
    paint.color = color;

    final startAngle = _bmiToAngle(start);
    final sweepAngle = _bmiToAngle(end) - startAngle;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  double _bmiToAngle(double bmi) {
    final value = bmi.clamp(10, 40);
    return pi + (value - 10) / 30 * pi;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
