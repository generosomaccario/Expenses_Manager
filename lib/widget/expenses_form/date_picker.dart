import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpensesDatePickerWidget extends StatefulWidget {
  const ExpensesDatePickerWidget({super.key, required this.callback});
  final Function(String) callback;

  @override
  State<ExpensesDatePickerWidget> createState() =>
      _ExpensesDatePickerWidgetState();
}

class _ExpensesDatePickerWidgetState extends State<ExpensesDatePickerWidget> {
  TextEditingController controller = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(0),
      lastDate: DateTime(3000),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        controller.text = DateFormat('dd/MM/yyyy').format(picked);
        widget.callback(controller.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: const InputDecoration(
          hintText: 'Data spesa', suffixIcon: Icon(Icons.calendar_month)),
      onTap: () {
        _selectDate(context);
      },
    );
  }
}
