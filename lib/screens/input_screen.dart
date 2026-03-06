import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'result_screen.dart';
import 'all_risk_calculators_screen.dart';
import 'find_right_calculator_screen.dart';
import 'risk_calculator.dart';
import 'how_to_use_screen.dart';
import 'ten_year_risk_calculator_screen.dart';
import 'resources_screen.dart';
import 'about_cvd_screen.dart';

// ===================== DRAWER ITEM =====================
Widget _drawerItem({
  required IconData icon,
  required String title,
  bool selected = false,
  VoidCallback? onTap,
}) {
  return Container(
    color: selected ? const Color(0xFFb71c1c) : Colors.transparent,
    child: ListTile(
      leading: Icon(icon, color: selected ? Colors.white : Colors.black87),
      title: Text(
        title,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    ),
  );
}

// ===================== CATEGORY CARD =====================
class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 42, color: Colors.grey[700]),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===================== INPUT SCREEN =====================
class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController age = TextEditingController();
  final TextEditingController sysBP = TextEditingController();
  final TextEditingController diaBP = TextEditingController();

  bool isLoading = false;
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    final primary = const Color(0xFFb71c1c);

    return Scaffold(
      backgroundColor: Colors.white,

      // ===================== DRAWER =====================
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 24),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.favorite, color: Color(0xFFb71c1c), size: 40),
                  SizedBox(height: 12),
                  Text(
                    'Cardiovascular Disease Calculator',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),

            _drawerItem(
              icon: Icons.home_outlined,
              title: 'Home',
              selected: true,
              onTap: () {
                Navigator.pop(context);
              },
            ),

            _drawerItem(
              icon: Icons.calculate_outlined,
              title: 'All risk calculators',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => Scaffold(
                          appBar: AppBar(
                            title: const Text('All Risk Calculators'),
                            backgroundColor: const Color(0xFFb71c1c),
                            centerTitle: true,
                          ),
                          body: const AllRiskCalculatorsPanel(),
                        ),
                  ),
                );
              },
            ),

            // ✅ RESOURCES INTEGRATED
            _drawerItem(
              icon: Icons.menu_book_outlined,
              title: 'Resources',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResourcesScreen(),
                  ),
                );
              },
            ),

            _drawerItem(
              icon: Icons.info_outline,
              title: 'About',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutCvdScreen(),
                  ),
                );
              },
            ),
            _drawerItem(
              icon: Icons.send_outlined,
              title: 'Contact us',
              onTap: () {
                Navigator.pop(context);
              },
            ),

            const Spacer(),

            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Text(
                    'Terms & conditions',
                    style: TextStyle(color: Colors.black54),
                  ),
                  SizedBox(height: 4),
                  Text('© ESC', style: TextStyle(color: Colors.black45)),
                ],
              ),
            ),
          ],
        ),
      ),

      // ===================== APP BAR =====================
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
        ),
        title: const Text('Home'),
        centerTitle: true,
      ),

      // ===================== BODY =====================
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/hero_feedback.jpg'),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Give us your\nfeedback',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            shadows: [
                              Shadow(blurRadius: 6, color: Colors.black45),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Choose your risk calculator category',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),

                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.1,
                    children: [
                      _CategoryCard(
                        icon: Icons.calculate_outlined,
                        title: 'Up to 10 year\nrisk calculators',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      const TenYearRiskCalculatorScreen(),
                            ),
                          );
                        },
                      ),
                      _CategoryCard(
                        icon: Icons.calculate,
                        title: 'Risk calculators',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RiskCalculator(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Get help for using calculator and application',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),

                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.1,
                    children: [
                      _CategoryCard(
                        icon: Icons.library_books_outlined,
                        title: 'Find the right\ncalculator',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      const FindRightCalculatorScreen(),
                            ),
                          );
                        },
                      ),
                      _CategoryCard(
                        icon: Icons.phone_iphone,
                        title: 'How to use this\napplication',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HowToUseScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
