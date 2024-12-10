import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plan_my_day/providers/task_provider.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import 'location_picker.dart';

class AddTaskSheet extends StatefulWidget {
  final bool isLargeScreen;

  const AddTaskSheet({
    super.key,
    required this.isLargeScreen,
  });

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late String _category;
  DateTime _dueDate = DateTime.now();
  Priority _priority = Priority.medium;
  LatLng? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final padding = MediaQuery.of(context).padding;
    final taskProvider = Provider.of<TaskProvider>(context);

    return Container(
      constraints: BoxConstraints(
        maxWidth: widget.isLargeScreen ? 600 : double.infinity,
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: padding.top + 16,
                left: 24,
                right: 24,
                bottom: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Task',
                    key: const Key('add_task_title'),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  IconButton.filledTonal(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: 'Title',
                        hint: 'What needs to be done?',
                        icon: Icons.title,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                        onSaved: (value) => _title = value!,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: 'Description',
                        hint: 'Add some details about your task',
                        icon: Icons.description,
                        maxLines: 3,
                        onSaved: (value) => _description = value ?? '',
                      ),
                      const SizedBox(height: 16),
                      _buildDropdownField(taskProvider),
                      const SizedBox(height: 16),
                      _buildPrioritySelector(),
                      const SizedBox(height: 16),
                      LocationPicker(
                        onLocationSelected: (location) {
                          setState(() {
                            _selectedLocation = location;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildDateSelector(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: padding.bottom + 16,
                top: 16,
              ),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                border: Border(
                  top: BorderSide(
                    color: colorScheme.outlineVariant.withOpacity(0.5),
                  ),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _submitForm,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Add Task',
                    key: Key('add_task_button'),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    int? maxLines,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextFormField(
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: colorScheme.primary.withOpacity(0.8),
          fontWeight: FontWeight.w500,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
          fontSize: 14,
        ),
        prefixIcon: Icon(
          icon,
          color: colorScheme.primary.withOpacity(0.7),
        ),
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.outline.withOpacity(0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.primary.withOpacity(0.7),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.error,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
      maxLines: maxLines ?? 1,
      validator: validator,
      onSaved: onSaved,
    );
  }

  Widget _buildDropdownField(TaskProvider taskProvider) {
    return DropdownButtonFormField<String>(
      key: const Key('category_dropdown'),
      decoration: InputDecoration(
        labelText: 'Category',
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
          fontWeight: FontWeight.w500,
        ),
        hintText: 'Select a category',
        prefixIcon: Icon(
          Icons.category,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
        ),
        filled: true,
        fillColor: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
      items: taskProvider.categories.map((category) {
        return DropdownMenuItem(
          value: category,
          child: Text(category),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _category = value!;
        });
      },
      validator: (value) {
        if (value == null) {
          return 'Please select a category';
        }
        return null;
      },
    );
  }

  Widget _buildPrioritySelector() {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      key: Key('priority_selector'),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Priority',
            style: TextStyle(
              color: colorScheme.primary.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          SegmentedButton<Priority>(
            style: ButtonStyle(
              side: WidgetStateProperty.all(BorderSide.none),
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return colorScheme.primaryContainer.withOpacity(0.7);
                }
                return colorScheme.surface.withOpacity(0.7);
              }),
            ),
            selected: {_priority},
            onSelectionChanged: (Set<Priority> selected) {
              setState(() {
                _priority = selected.first;
              });
            },
            segments: Priority.values.map((priority) {
              return ButtonSegment<Priority>(
                value: priority,
                label: Text(priority.name.toUpperCase()),
                icon: Icon(Icons.flag, color: priority.color),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Due Date',
            style: TextStyle(
              color: colorScheme.primary.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_dueDate.day}/${_dueDate.month}/${_dueDate.year}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              FilledButton.tonalIcon(
                icon: const Icon(Icons.calendar_today, size: 18),
                label: const Text('Change'),
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _dueDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(
                      const Duration(days: 365),
                    ),
                  );
                  if (date != null) {
                    setState(() {
                      _dueDate = date;
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final task = Task(
        title: _title,
        description: _description,
        category: _category,
        priority: _priority,
        dueDate: _dueDate,
        location: _selectedLocation,
      );

      Provider.of<TaskProvider>(context, listen: false).addTask(task);
      Navigator.pop(context);
    }
  }
}
