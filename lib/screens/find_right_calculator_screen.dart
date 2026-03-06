import 'package:flutter/material.dart';

class FindRightCalculatorScreen extends StatefulWidget {
  const FindRightCalculatorScreen({super.key});

  @override
  State<FindRightCalculatorScreen> createState() =>
      _FindRightCalculatorScreenState();
}

class _FindRightCalculatorScreenState extends State<FindRightCalculatorScreen> {
  int selectedIndex = 0; // 0 = Up to 10 year, 1 = Lifetime

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFFb71c1c);

    return Scaffold(
      backgroundColor: Colors.white,

      // ===================== APP BAR =====================
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Find the right calculator'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.home_outlined),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ],
      ),

      // ===================== BODY =====================
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 32, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),

            const Text(
              'What would you like to\nestimate?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 40),

            // ===== OPTION 1 (ACTIVE) =====
            _optionCard(
              title: 'Up to 10 year cardiovascular risk',
              selected: selectedIndex == 0,
              enabled: true,
              onTap: () {
                setState(() => selectedIndex = 0);
              },
            ),

            const SizedBox(height: 20),

            // ===== OPTION 2 (DISABLED) =====
            _optionCard(
              title: 'Lifetime cardiovascular risk',
              selected: false,
              enabled: false,
              onTap: () {},
            ),

            const SizedBox(height: 30),

            Center(
              child: GestureDetector(
                onTap: () {},
                child: const Text(
                  'When to assess lifetime risk?',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const Spacer(),

            // ===================== NEXT BUTTON =====================
            SizedBox(
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // TODO: Navigate to next step
                },
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===================== OPTION CARD =====================
  Widget _optionCard({
    required String title,
    required bool selected,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: enabled ? onTap : null,
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? Colors.green : Colors.grey.shade300,
            width: 2,
          ),
          color: enabled ? Colors.white : Colors.grey.shade200,
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: double.infinity,
              decoration: BoxDecoration(
                color: selected ? Colors.green : Colors.grey.shade300,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Icon(
                selected ? Icons.check_circle : Icons.circle_outlined,
                color: selected ? Colors.white : Colors.grey,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: enabled ? Colors.black : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
