import 'package:expenses_manager/models/category_model.dart';
import 'package:expenses_manager/models/expenses_model.dart';
import 'package:expenses_manager/theme/style.dart';
import 'package:expenses_manager/widget/expenses/expenses_dialog_widget.dart';
import 'package:flutter/material.dart';

class FloatingButtonWidget extends StatefulWidget {
  const FloatingButtonWidget(
      {super.key,
      required this.categoriesList,
      required this.addExpenseCallback});
  final List<CategoryModel> categoriesList;
  final Function(ExpenseModel) addExpenseCallback;

  @override
  State<FloatingButtonWidget> createState() => _FloatingButtonWidgetState();
}

String name = '';
String date = '';
double price = 0;
CategoryModel? category;

class _FloatingButtonWidgetState extends State<FloatingButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: kPaddingAll,
        child: ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AddExpenseWidget(
                      categoriesList: widget.categoriesList,
                      onExpenseAdded: (expenseModelValue) {
                        widget.addExpenseCallback(expenseModelValue);
                      },
                    );
                  });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.add),
                Text('Aggiungi spesa'),
              ],
            )));
  }
}
