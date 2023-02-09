
import 'package:flutter/material.dart';
import 'package:kau_carpool/helper/resources/color_manager.dart';

class CustomToggleButton extends StatefulWidget {
  int selectedIndex = 0;
  final ValueChanged<int> onItemSelected;
  String tab1 = "";
  String tab2 = "";
  CustomToggleButton({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.tab1,
    required this.tab2,
  }) : super(key: key);
  @override
  _CustomToggleButtonState createState() => _CustomToggleButtonState();
}

const double width = 250.0;
const double height = 50.0;
const double findAlign = -1;
const double offerAlign = 1;
Color selectedColor = ColorManager.white;
Color normalColor = ColorManager.darkGrey;

class _CustomToggleButtonState extends State<CustomToggleButton> {
  late double xAlign;
  Color findColor = selectedColor;
  Color offerColor = normalColor;
  @override
  void initState() {
    super.initState();
    xAlign = findAlign;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: Alignment(xAlign, 0),
              duration: const Duration(milliseconds: 300),
              child: Container(
                width: width * 0.5,
                height: height,
                decoration: BoxDecoration(
                  color: ColorManager.lightPrimary,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  xAlign = findAlign;
                  findColor = selectedColor;
                  offerColor = normalColor;
                  widget.selectedIndex = 0;
                  widget.onItemSelected(widget.selectedIndex);
                });
                // widget.selectedIndex = 0;
                // widget.onToggleCallback(widget.selectedIndex);
                // print(widget.selectedIndex);
              },
              child: Align(
                alignment: const Alignment(-1, 0),
                child: Container(
                  width: width * 0.5,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    widget.tab1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: findColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  xAlign = offerAlign;
                  offerColor = selectedColor;
                  findColor = normalColor;
                  widget.selectedIndex = 1;
                  widget.onItemSelected(widget.selectedIndex);
                });
                // widget.selectedIndex = 1;
                // print(widget.selectedIndex);
              },
              child: Align(
                alignment: const Alignment(1, 0),
                child: Container(
                  width: width * 0.5,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    widget.tab2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: offerColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
