import 'package:flutter_test/flutter_test.dart';
import 'package:plan_my_day/providers/task_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    hide Priority;

// Create a Mock class for FlutterLocalNotificationsPlugin
class MockFlutterLocalNotificationsPlugin extends Mock
    implements FlutterLocalNotificationsPlugin {}

// Create a Mock class for SharedPreferences

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  databaseFactory = databaseFactoryFfi;

  group('TaskProvider', () {
    late TaskProvider taskProvider;
    late MockFlutterLocalNotificationsPlugin mockNotificationsPlugin;

    setUp(() {
      mockNotificationsPlugin = MockFlutterLocalNotificationsPlugin();
      taskProvider = TaskProvider();
      SharedPreferences.setMockInitialValues({
        'tasks': [],
      });
      // Replace the notifications plugin in the provider with the mock
      taskProvider.flutterLocalNotificationsPlugin = mockNotificationsPlugin;
    });

    test('Initial selected category should be "All"', () {
      expect(taskProvider.selectedCategory, 'All');
    });

    test('Adding a category should update the categories list', () {
      taskProvider.addCategory('New Category');
      expect(taskProvider.categories.contains('New Category'), true);
    });

    test('Deleting a category should remove it from the categories list', () {
      taskProvider.addCategory('Category to Delete');
      taskProvider.deleteCategory('Category to Delete');
      expect(taskProvider.categories.contains('Category to Delete'), false);
    });
  });
}
