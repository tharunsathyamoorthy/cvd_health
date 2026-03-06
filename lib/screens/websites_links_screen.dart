import 'package:flutter/material.dart';

class WebsitesLinksScreen extends StatelessWidget {
  const WebsitesLinksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Websites & useful links'),
        backgroundColor: const Color(0xFFB71C1C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: const [
            _SectionTitle('European Society of Cardiology (ESC)'),
            Text(
              'The European Society of Cardiology (ESC) is an independent, non-profit organisation. The ESC represents more than 95,000 men and women in the field of cardiology from Europe, the Mediterranean basin and far beyond.',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 20),

            _SectionTitle('Healthy-Heart.org'),
            Text(
              'Clear, reliable information and practical advice for patients and family care givers on the prevention of cardiovascular disease, provided by the European Society of Cardiology.',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFFB71C1C),
          fontSize: 16,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
