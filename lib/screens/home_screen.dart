import 'package:flutter/material.dart';
import 'package:plan_my_day/screens/calendar_screen.dart';
import '../widgets/task_list.dart';
import 'settings_screen.dart';
import '../widgets/add_task_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<({Widget screen, String title, IconData icon})> _screens = const [
    (
      screen: TaskList(),
      title: 'Tasks',
      icon: Icons.task_alt,
    ),
    (
      screen: CalendarScreen(),
      title: 'Calendar',
      icon: Icons.calendar_today,
    ),
    (
      screen: SettingsScreen(),
      title: 'Settings',
      icon: Icons.settings,
    ),
  ];

  void _showAddTask() {
    final width = MediaQuery.of(context).size.width;
    final isLargeScreen = width > 600;

    if (isLargeScreen) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: AddTaskSheet(isLargeScreen: isLargeScreen),
        ),
      );
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (context) => AddTaskSheet(isLargeScreen: isLargeScreen),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isLargeScreen = width > 600;

    if (isLargeScreen) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              extended: width > 800,
              backgroundColor: Theme.of(context).colorScheme.surface,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              leading: const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Icon(
                  Icons.check_circle_outline,
                  size: 32,
                ),
              ),
              destinations: [
                for (final screen in _screens)
                  NavigationRailDestination(
                    icon: Icon(screen.icon),
                    label: Text(screen.title),
                  ),
              ],
            ),
            Expanded(
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(_screens[_selectedIndex].title),
                  actions: [
                    if (_selectedIndex == 0)
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: _showAddTask,
                      ),
                    const SizedBox(width: 8),
                  ],
                ),
                body: _screens[_selectedIndex].screen,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_selectedIndex].title),
        centerTitle: true,
        actions: [
          if (_selectedIndex == 0)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _showAddTask,
            ),
        ],
      ),
      body: _screens[_selectedIndex].screen,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: [
          for (final screen in _screens)
            NavigationDestination(
              icon: Icon(screen.icon),
              label: screen.title,
            ),
        ],
      ),
    );
  }
}
