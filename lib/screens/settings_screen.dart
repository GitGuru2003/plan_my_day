import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/task_provider.dart';
import '../widgets/add_category_dialog.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, TaskProvider>(
      builder: (context, themeProvider, taskProvider, child) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSection(
              title: 'Appearance',
              children: [
                SwitchListTile(
                  title: const Text('Dark Mode'),
                  value: themeProvider.isDarkMode,
                  onChanged: (_) => themeProvider.toggleTheme(),
                ),
                // const Divider(),
                // _buildThemeColorPicker(context, themeProvider),
              ],
            ),
            // const Divider(),
            _buildSection(
              title: 'Categories',
              children: [
                ...taskProvider.categories.map((category) => ListTile(
                      title: Text(category),
                      trailing: category != 'All'
                          ? IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Delete Category'),
                                    content: const Text(
                                        'Are you sure you want to delete this category?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          taskProvider.deleteCategory(category);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : null,
                    )),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AddCategoryDialog(
                        onCategoryAdded: (newCategory) {
                          taskProvider.addCategory(newCategory);
                        },
                      ),
                    );
                  },
                  child: const Text('Add New Category'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...children,
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildThemeColorPicker(
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Theme Color',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final color in themeProvider.colorOptions)
              GestureDetector(
                onTap: () => themeProvider.setThemeColor(color),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: themeProvider.seedColor == color
                          ? Theme.of(context).colorScheme.primary
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: themeProvider.seedColor == color
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 28,
                        )
                      : null,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
