// ignore_for_file: depend_on_referenced_packages

import 'package:expenses_manager/helper/database_helper.dart';
import 'package:expenses_manager/models/category_model.dart';
import 'package:expenses_manager/models/expenses_model.dart';
import 'package:sqflite/sqflite.dart';

class DataAccess {
  static final DataAccess instance = DataAccess._init();

  static final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  DataAccess._init();

  Future<Database> get database async {
    return await _databaseHelper.database;
  }

  Future<List<CategoryModel>> getCategories() async {
    final db = await instance.database;

    final categories = await db.query('categories');

    return categories.map((json) => CategoryModel.fromJson(json)).toList();
  }

  Future<List<ExpenseModel>> getExpenses() async {
    final db = await instance.database;

    final expenses = await db.query('expenses');

    return expenses.map((json) => ExpenseModel.fromJson(json)).toList();
  }

  Future<List<ExpenseModel>> getExpensesByCategoryId(int categoryId) async {
    final db = await instance.database;

    final expenses = await db.query(
      'expenses',
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );

    return expenses.map((json) => ExpenseModel.fromJson(json)).toList();
  }

  Future<bool> checkIfCategoryExists(String categoryName) async {
    final db = await instance.database;
    final categories = await db.query(
      'categories',
      where: 'name = ?',
      whereArgs: [categoryName],
    );
    return categories.isNotEmpty;
  }

  Future<bool> checkIfColorExists(int color) async {
    final db = await instance.database;
    final categories = await db.query(
      'categories',
      where: 'color = ?',
      whereArgs: [color],
    );
    return categories.isNotEmpty;
  }

  Future<void> insertCategory(CategoryModel category) async {
    final db = await instance.database;
    await db.insert('categories', category.toJson());
  }

  Future<int> insertExpense(ExpenseModel expense) async {
    final db = await instance.database;
    return await db.insert('expenses', expense.toJson());
  }

  Future<int> updateCategory(CategoryModel category) async {
    final db = await instance.database;
    return await db.update(
      'categories',
      category.toJson(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  Future<int> updateExpense(ExpenseModel expense) async {
    final db = await instance.database;
    return await db.update(
      'expenses',
      expense.toJson(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  Future<int> deleteCategory(int id) async {
    final db = await instance.database;
    return await db.delete('categories', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteExpense(int id) async {
    final db = await instance.database;
    return await db.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteExpensesByCategoryId(int id) async {
    final db = await instance.database;
    return await db.delete(
      'expenses',
      where: 'category_id = ?',
      whereArgs: [id],
    );
  }
}
