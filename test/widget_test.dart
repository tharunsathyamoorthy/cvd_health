import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cardio_prediction_app/main.dart';

void main() {
  testWidgets('App shows Home title and menu', (WidgetTester tester) async {
    await tester.pumpWidget(const CardioApp());

    expect(find.text('Home'), findsOneWidget);
    expect(find.byIcon(Icons.menu), findsOneWidget);
  });
}
