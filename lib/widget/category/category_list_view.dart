import 'package:expenses_manager/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:expenses_manager/models/category_model.dart';

class CategoryListWidget extends StatefulWidget {
  const CategoryListWidget(
      {super.key, required this.categoriesList, required this.deleteCallback});
  final List<CategoryModel> categoriesList;
  final Function(int) deleteCallback;

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.categoriesList.isEmpty
        ? Card(
            color: kScaffoldColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
            ),
            elevation: 3,
            child: Container(
              padding: kPaddingAll,
              child: const Text(
                'Aggiungi una categoria con il pulsante + in alto a destra.',
                textAlign: TextAlign.center,
              ),
            ))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(widget.categoriesList.length, (index) {
                return Card(
                    clipBehavior: Clip.antiAlias,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    elevation: 3,
                    child: Container(
                        clipBehavior: Clip.antiAlias,
                        padding: kPaddingAll * 0.5,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 7),
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: Color(widget.categoriesList
                                    .elementAt(index)
                                    .color),
                              ),
                            ),
                            Text(widget.categoriesList.elementAt(index).name),
                            GestureDetector(
                              onTap: () {
                                widget.deleteCallback(
                                    widget.categoriesList.elementAt(index).id ??
                                        -1);
                              },
                              child: const Icon(
                                Icons.clear,
                                size: 17,
                              ),
                            )
                          ],
                        )));
              })
            ],
          );
  }
}
