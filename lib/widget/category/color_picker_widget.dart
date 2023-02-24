import 'package:flutter/material.dart';

class ColorPickerWidget extends StatefulWidget {
  const ColorPickerWidget({
    super.key,
    required this.callback,
    this.showCheck = false,
  });
  final Function(int) callback;
  final bool showCheck;

  @override
  State<ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  int _selectedIndex = -1;
  void setIndex(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Color> listColor = const [
      Color(0xFFBF3A66),
      Color(0xFFFF693A),
      Color(0xFFF4C259),
      Color(0xFF58BD7D),
      Color(0xFF2A6CF4),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...List.generate(listColor.length, (index) {
          return GestureDetector(
              onTap: () {
                setState(() {
                  setIndex(index);
                  widget.callback(listColor.elementAt(index).value);
                });
              },
              child: ColorElement(
                color: listColor.elementAt(index),
                showCheck: _selectedIndex == index,
              ));
        })
      ],
    );
  }
}

class ColorElement extends StatefulWidget {
  const ColorElement({super.key, required this.color, required this.showCheck});
  final Color color;
  final bool showCheck;

  @override
  State<ColorElement> createState() => _ColorElementState();
}

class _ColorElementState extends State<ColorElement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: widget.color,
      ),
      child: Visibility(
          visible: widget.showCheck,
          child: const Icon(
            Icons.check,
            color: Colors.white,
          )),
    );
  }
}
