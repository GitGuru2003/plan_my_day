import 'package:flutter/material.dart';

class AddCategoryDialog extends StatefulWidget {
  final Function(String) onCategoryAdded;

  const AddCategoryDialog({super.key, required this.onCategoryAdded});

  @override
  _AddCategoryDialogState createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Category'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: 'Category Name',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final newCategory = _controller.text.trim();
            if (newCategory.isNotEmpty) {
              widget.onCategoryAdded(newCategory);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
} 