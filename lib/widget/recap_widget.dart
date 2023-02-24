import 'package:expenses_manager/models/category_model.dart';
import 'package:expenses_manager/theme/style.dart';
import 'package:expenses_manager/widget/category/category_list_view.dart';
import 'package:expenses_manager/widget/chart_widget.dart';
import 'package:flutter/material.dart';

class RecapWidget extends StatefulWidget {
  const RecapWidget({
    super.key,
    required this.categoriesList,
    required this.deleteCallback,
    required this.chartData,
  });
  final Function(int) deleteCallback;
  final List<CategoryModel> categoriesList;
  final List<PieChartData> chartData;

  @override
  State<RecapWidget> createState() => _RecapWidgetState();
}

class _RecapWidgetState extends State<RecapWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: kPaddingAll,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: PieChart(data: widget.chartData),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: CategoryListWidget(
                categoriesList: widget.categoriesList,
                deleteCallback: (id) {
                  widget.deleteCallback(id);
                },
              ),
            )
          ],
        ));
  }
}
