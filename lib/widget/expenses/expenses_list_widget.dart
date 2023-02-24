import 'package:expenses_manager/models/category_model.dart';
import 'package:expenses_manager/models/expenses_model.dart';
import 'package:expenses_manager/theme/style.dart';
import 'package:flutter/material.dart';

class ExpensesListWidget extends StatefulWidget {
  const ExpensesListWidget({
    Key? key,
    required this.expensesList,
    required this.deleteCallback,
    required this.categoriesList,
  }) : super(key: key);
  final List<ExpenseModel> expensesList;
  final List<CategoryModel> categoriesList;
  final Function(int) deleteCallback;

  @override
  State<ExpensesListWidget> createState() => _ExpensesListWidgetState();
}

double radius = kBorderRadius;

class _ExpensesListWidgetState extends State<ExpensesListWidget> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<DraggableScrollableNotification>(
        onNotification: (notification) {
          if (notification.extent == 1) {
            radius = 0;
          } else {
            radius = kBorderRadius;
          }
          return true;
        },
        child: DraggableScrollableSheet(
            initialChildSize: 0.68,
            minChildSize: 0.68,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                  padding: kPaddingAll +
                      EdgeInsets.only(
                          bottom: MediaQuery.of(context).padding.bottom),
                  decoration: BoxDecoration(
                      color: kScaffoldColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radius),
                          topRight: Radius.circular(radius))),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: widget.expensesList.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: kMarginBottom,
                          width: double.infinity,
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: kPaddingAll,
                                    decoration: BoxDecoration(
                                        color: Color(widget.categoriesList
                                            .where((category) =>
                                                category.id ==
                                                widget.expensesList
                                                    .elementAt(index)
                                                    .categoryId)
                                            .first
                                            .color),
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          widget.expensesList
                                              .elementAt(index)
                                              .name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          widget.expensesList
                                              .elementAt(index)
                                              .date,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          '${widget.expensesList.elementAt(index).price} €',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: kPaddingAll,
                                  decoration: BoxDecoration(
                                      color: Color(widget.categoriesList
                                              .where((category) =>
                                                  category.id ==
                                                  widget.expensesList
                                                      .elementAt(index)
                                                      .categoryId)
                                              .first
                                              .color)
                                          .withAlpha(100),
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10))),
                                  child: GestureDetector(
                                    onTap: () {
                                      widget.deleteCallback(widget.expensesList
                                              .elementAt(index)
                                              .id ??
                                          -1);
                                    },
                                    child: const Icon(Icons.delete_forever),
                                  ),
                                )
                              ],
                            ),
                          ));
                    },
                  ));
            }));
  }
}
