import 'package:app_deaf/models/Coures.dart';
import 'package:app_deaf/pages/coures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CouresPage shows list of courses', (WidgetTester tester) async {
    final mockCoures = [
      Coures(id: '1', couresname: 'Course A'),
      Coures(id: '2', couresname: 'Course B'),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: CouresPage(fetchCoures: () async => mockCoures),
      ),
    );

    // Allow the FutureBuilder to resolve
    await tester.pump();
    await tester.pump();

    expect(find.text('Course A'), findsOneWidget);
    expect(find.text('Course B'), findsOneWidget);
  });
}

