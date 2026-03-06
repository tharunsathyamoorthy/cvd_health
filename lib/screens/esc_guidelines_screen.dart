import 'package:flutter/material.dart';

class EscGuidelinesScreen extends StatelessWidget {
  const EscGuidelinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ESC clinical practice guidelines'),
        backgroundColor: const Color(0xFFB71C1C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: const [
            Text(
              'Guidelines present relevant evidence to help physicians weigh the benefits and risks of a particular diagnostic or therapeutic procedure. Click on the link below to access the full text.',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 16),

            _LinkText('Arterial Hypertension (ESC/ESH)'),
            _LinkText('Dyslipidaemia'),
            _LinkText('CVD Prevention in Clinical Practice'),
            _LinkText(
              'Diabetes, Pre-Diabetes and Cardiovascular Diseases (ESC/EASD)',
            ),

            SizedBox(height: 30),
            Text(
              'Download the ESC Guidelines mobile app',
              style: TextStyle(
                color: Color(0xFFB71C1C),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),

            _StoreTile(title: 'Apple App Store'),
            _StoreTile(title: 'Google Play'),
            _StoreTile(title: 'Amazon'),
          ],
        ),
      ),
    );
  }
}

class _LinkText extends StatelessWidget {
  final String text;
  const _LinkText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 15,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

class _StoreTile extends StatelessWidget {
  final String title;
  const _StoreTile({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(title: Text(title), trailing: const Icon(Icons.chevron_right)),
        const Divider(height: 1),
      ],
    );
  }
}
