import 'package:flutter/material.dart';
import 'package:foores/model/recipe.dart';
import 'package:foores/view/widget/build_ink_well.dart';

class BuildGridView extends StatelessWidget {
  final Recipe food;
  final int count;
  final double fontSize;
  final int maxLines;

  const BuildGridView({
    Key? key,
    required this.food,
    required this.count,
    required this.fontSize,
    required this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Result> _listFood = food.results!;
    return GridView.builder(
      itemBuilder: (context, index) {
        return BuildInkWell(
          listFood: _listFood,
          index: index,
          fontSize: fontSize,
          maxLines: maxLines,
        );
      },
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 10.0,
        bottom: 10.0,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: count, mainAxisSpacing: 10.0, crossAxisSpacing: 10.0),
      itemCount: _listFood.length,
    );
  }
}
