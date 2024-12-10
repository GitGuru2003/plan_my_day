import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import '../models/task.dart';
import '../helpers/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Personal',
    'Work',
    'Shopping',
    'Health'
  ];

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  List<String> get categories => List.from(_categories);

  TaskProvider() {
    _loadTasks();
    _loadCategories();
  }

  List<Task> get tasks {
    if (_selectedCategory == 'All') {
      return _tasks;
    }
    return _tasks.where((task) => task.category == _selectedCategory).toList();
  }

  String get selectedCategory => _selectedCategory;

  Future<void> _loadTasks() async {
    _tasks = await DatabaseHelper().getTasks();
    notifyListeners();
  }

  Future<void> _loadCategories() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedCategories = prefs.getStringList('categories') ?? [];

      for (var category in savedCategories) {
        if (!_categories.contains(category)) {
          _categories.add(category);
        }
      }
      notifyListeners();
    } catch (e) {
      print("Error loading categories: $e");
    }
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await DatabaseHelper().insertTask(task);
    await _sendNotification(
        'Task Added', 'You have added a new task: ${task.title}');
    _loadTasks();
  }

  Future<void> deleteTask(Task task) async {
    await DatabaseHelper().deleteTask(task.id!);
    await _sendNotification(
        'Task Deleted', 'You have deleted the task: ${task.title}');
    _loadTasks();
  }

  Future<void> _sendNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id', // Replace with your channel ID
      'your_channel_name', // Replace with your channel name
      channelDescription:
          'your_channel_description', // Replace with your channel description
      importance: Importance.max,
      showWhen: false,
      // sound: RawResourceAndroidNotificationSound('assets/delete_task.mp3'),
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x', // Optional payload
    );
  }

  void toggleTaskCompletion(Task task) {
    task.isCompleted = !task.isCompleted;
    updateTask(task);
  }

  Future<void> updateTask(Task task) async {
    await DatabaseHelper().updateTask(task);
    _loadTasks();
  }

  void addCategory(String category) {
    if (!_categories.contains(category)) {
      _categories.add(category);
      _saveCategories();
      notifyListeners();
    }
  }

  Future<void> deleteCategory(String category) async {
    if (_categories.contains(category)) {
      _categories.remove(category);
      _saveCategories();
      notifyListeners();
    }
  }

  Future<void> _saveCategories() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('categories', _categories);
  }
}
