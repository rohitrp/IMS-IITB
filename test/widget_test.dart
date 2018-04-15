// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:iitb_ims/main.dart';
import 'package:iitb_ims/login.dart';

void main() {
  testWidgets('Home screen test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new MyApp());

    expect(find.text('Login'), findsNWidgets(2));
    expect(find.text('Signup'), findsOneWidget);
  });

  testWidgets('Login screen test', (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new LoginPage())
    );

    await tester.pumpWidget(testWidget);

    expect(find.text("Login"), findsOneWidget);
    expect(find.text("Your email"), findsOneWidget);
    expect(find.text('Your password'), findsOneWidget);


  });
}
