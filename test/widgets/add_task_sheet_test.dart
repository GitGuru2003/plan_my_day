import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plan_my_day/widgets/add_task_sheet.dart';
import 'package:provider/provider.dart';
import 'package:plan_my_day/providers/task_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// Create a Mock class for AudioPlayer

void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // Initialize the binding
  databaseFactory = databaseFactoryFfi; // Initialize the database factory

  testWidgets('AddTaskSheet shows title and description fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => TaskProvider(),
        child: MaterialApp(
          home: Scaffold(
            body: AddTaskSheet(isLargeScreen: false),
          ),
        ),
      ),
    );

    expect(find.byType(TextField),
        findsNWidgets(2)); // Title and Description fields
    expect(find.byKey(const Key('add_task_title')),
        findsOneWidget); // Check for unique title key
  });

}
