// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:expenses_manager/models/category_model.dart';
import 'package:expenses_manager/models/expenses_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpenseWidget extends StatefulWidget {
  const AddExpenseWidget(
      {Key? key, required this.categoriesList, required this.onExpenseAdded})
      : super(key: key);

  final List<CategoryModel> categoriesList;
  final Function(ExpenseModel) onExpenseAdded;

  @override
  State<AddExpenseWidget> createState() => _AddExpenseWidgetState();
}

class _AddExpenseWidgetState extends State<AddExpenseWidget> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  int? _selectedCategoryId = -1;
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Aggiungi voce di spesa'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Spesa',
              ),
              keyboardType: TextInputType.number,
            ),
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(
                labelText: 'Categoria',
              ),
              value: _selectedCategoryId == -1 ? null : _selectedCategoryId,
              onChanged: (categoryId) {
                setState(() {
                  _selectedCategoryId = categoryId;
                });
              },
              items: widget.categoriesList
                  .map((category) => DropdownMenuItem<int>(
                        value: category.id,
                        child: Text(category.name),
                      ))
                  .toList(),
            ),
            ListTile(
              title: const Text('Data'),
              subtitle: Text(
                '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
              ),
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(0),
                  lastDate: DateTime(3000),
                );
                if (picked != null && picked != _selectedDate) {
                  setState(() {
                    _selectedDate = picked;
                  });
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annulla'),
        ),
        ElevatedButton(
          onPressed: () {
            final name = _nameController.text;
            final price = double.tryParse(_priceController.text) ?? 0.0;

            if (name.isNotEmpty && price > 0.0 && _selectedCategoryId != -1) {
              final expense = ExpenseModel(
                name: name,
                price: price,
                date: DateFormat('dd/MM/yyy').format(_selectedDate),
                categoryId: _selectedCategoryId ?? -1,
              );

              widget.onExpenseAdded(expense);

              Navigator.pop(context);
            }
          },
          child: const Text('Aggiungi'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
