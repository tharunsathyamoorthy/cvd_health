import 'package:flutter/material.dart';

class AboutCvdScreen extends StatelessWidget {
  const AboutCvdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: const Color(0xFFB71C1C),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _SectionTitle('What is Cardiovascular Disease?'),
            _BodyText(
              'Cardiovascular disease (CVD) is a group of disorders of the heart and blood vessels. '
              'It includes conditions such as coronary heart disease, cerebrovascular disease, '
              'peripheral arterial disease, rheumatic heart disease, congenital heart disease, '
              'deep vein thrombosis and pulmonary embolism.',
            ),

            SizedBox(height: 16),

            _SectionTitle('Why is it important?'),
            _BodyText(
              'Cardiovascular disease is the leading cause of death globally. '
              'Most cardiovascular diseases can be prevented by addressing behavioral risk factors '
              'such as tobacco use, unhealthy diet, obesity, physical inactivity, and harmful use of alcohol.',
            ),

            SizedBox(height: 16),

            _SectionTitle('Common Risk Factors'),
            _BodyText(
              '• High blood pressure\n'
              '• High blood sugar (diabetes)\n'
              '• High cholesterol\n'
              '• Smoking\n'
              '• Obesity\n'
              '• Physical inactivity\n'
              '• Family history of heart disease',
            ),

            SizedBox(height: 16),

            _SectionTitle('Prevention'),
            _BodyText(
              'Maintaining a healthy lifestyle can significantly reduce the risk of cardiovascular disease. '
              'This includes eating a balanced diet, engaging in regular physical activity, '
              'maintaining a healthy weight, avoiding smoking, and managing stress.',
            ),

            SizedBox(height: 24),

            Text(
              'Disclaimer',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'This application is intended for informational purposes only and does not replace '
              'professional medical advice, diagnosis, or treatment. '
              'Always consult a qualified healthcare provider for medical concerns.',
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}

// ===================== UI HELPERS =====================

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Color(0xFFB71C1C),
        ),
      ),
    );
  }
}

class _BodyText extends StatelessWidget {
  final String text;
  const _BodyText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 15, height: 1.4));
  }
}
