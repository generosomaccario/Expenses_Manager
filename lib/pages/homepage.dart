// ignore_for_file: use_build_context_synchronously

import 'package:expenses_manager/helper/data_access.dart';
import 'package:expenses_manager/models/category_model.dart';
import 'package:expenses_manager/models/expenses_model.dart';
import 'package:expenses_manager/theme/style.dart';
import 'package:expenses_manager/widget/category/category_dialog_widget.dart';
import 'package:expenses_manager/widget/chart_widget.dart';
import 'package:expenses_manager/widget/expenses/expenses_list_widget.dart';
import 'package:expenses_manager/widget/floating_button_widget.dart';
import 'package:expenses_manager/widget/recap_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    updateData();
  }

  List<CategoryModel> categoriesList = [];
  List<ExpenseModel> expensesList = [];
  List<PieChartData> chartData = [];

  void updateData() async {
    final categories = await DataAccess.instance.getCategories();
    final expenses = await DataAccess.instance.getExpenses();

    final newChartData = <PieChartData>[];
    for (final category in categories) {
      final filteredExpenses =
          await DataAccess.instance.getExpensesByCategoryId(category.id ?? -1);
      final sum = filteredExpenses.fold<double>(
          0.0, (acc, expense) => acc + expense.price);
      if (sum > 0) {
        newChartData.add(
          PieChartData(value: sum, color: Color(category.color)),
        );
      }
    }

    setState(() {
      categoriesList = categories;
      expensesList = expenses;
      chartData = newChartData;
    });
  }

  //Add Category
  void addCategory(name, color, context) async {
    final nameExists = await DataAccess.instance.checkIfCategoryExists(name);
    if (nameExists) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Esiste già una categoria con lo stesso nome'),
        duration: Duration(seconds: 2),
      ));
      return;
    }

    final colorExists = await DataAccess.instance.checkIfColorExists(color);
    if (colorExists) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Esiste già una categoria con questo colore'),
        duration: Duration(seconds: 2),
      ));
      return;
    }

    DataAccess.instance.insertCategory(CategoryModel(name: name, color: color));
    updateData();
  }

//Delete Category
  void deleteCategory(id) {
    DataAccess.instance.deleteExpensesByCategoryId(id);
    DataAccess.instance.deleteCategory(id);
    updateData();
  }

//Add Expenses
  void addExpense(expenseModel) {
    DataAccess.instance.insertExpense(expenseModel);
    updateData();
  }

//Delete Expenses
  void deleteexpense(id) {
    DataAccess.instance.deleteExpense(id);
    updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 3,
          centerTitle: false,
          title: const Text('Gestore delle spese'),
          actions: [
            Padding(
              padding: kPaddingAll,
              child: ElevatedButton(
                  child: const Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AddCategoryDialog(
                            addCategoryCallback:
                                (categoryNameValue, categoryColorValue) {
                              addCategory(categoryNameValue, categoryColorValue,
                                  context);
                            },
                          );
                        });
                  }),
            )
          ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: categoriesList.isEmpty
          ? null
          : FloatingButtonWidget(
              addExpenseCallback: (expenseModelValue) {
                addExpense(expenseModelValue);
              },
              categoriesList: categoriesList,
            ),
      body: Stack(
        children: [
          Container(
            color: kRecapColor,
            height: MediaQuery.of(context).size.height * 0.3,
            child: RecapWidget(
              categoriesList: categoriesList,
              chartData: chartData,
              deleteCallback: (id) {
                deleteCategory(id);
              },
            ),
          ),
          SizedBox.expand(
              child: ExpensesListWidget(
            expensesList: expensesList,
            categoriesList: categoriesList,
            deleteCallback: (id) {
              deleteexpense(id);
            },
          ))
        ],
      ),
    );
  }
}
