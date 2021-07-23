import 'package:flutter/material.dart';
import 'package:foores/model/recipe.dart';
import 'package:foores/view/widget/build_ink_well.dart';

class BuildListView extends StatelessWidget {
  final Recipe food;
  final double fontSize;
  final int maxLines;

  const BuildListView({
    Key? key,
    required this.food,
    required this.fontSize,
    required this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Result> _listFood = food.results!;
    return ListView.builder(
      itemBuilder: (context, index) {
        return BuildInkWell(
          listFood: _listFood,
          index: index,
          fontSize: fontSize,
          maxLines: maxLines,
        );
      },
      itemCount: _listFood.length,
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 10.0,
        bottom: 10.0,
      ),
    );
  }
}
