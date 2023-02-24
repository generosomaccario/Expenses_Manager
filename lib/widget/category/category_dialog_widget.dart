import 'package:expenses_manager/widget/category/color_picker_widget.dart';
import 'package:flutter/material.dart';

class AddCategoryDialog extends StatefulWidget {
  const AddCategoryDialog({super.key, required this.addCategoryCallback});
  final Function(String, int) addCategoryCallback;

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  String categoryName = '';
  int categoryColor = 000000;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Aggiungi categoria'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Nome categoria'),
            onChanged: (value) => setState(() => categoryName = value),
          ),
          const SizedBox(height: 40),
          const Text('Colore:'),
          const SizedBox(height: 20),
          ColorPickerWidget(
            callback: (color) => setState(() => categoryColor = color),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('ANNULLA'),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
            child: const Text('AGGIUNGI'),
            onPressed: () {
              if (categoryName != '' && categoryColor != 000000) {
                widget.addCategoryCallback(categoryName, categoryColor);
                Navigator.pop(context);
              }
            }),
      ],
    );
  }
}
