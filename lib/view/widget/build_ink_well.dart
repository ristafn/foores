import 'package:flutter/material.dart';
import 'package:foores/model/recipe.dart';
import 'package:foores/view/detail_food.dart';

class BuildInkWell extends StatelessWidget {
  final List<Result> _listFood;
  final int index;
  final double fontSize;
  final int maxLines;

  const BuildInkWell({
    Key? key,
    required List<Result> listFood,
    required this.index,
    required this.fontSize,
    required this.maxLines,
  })  : _listFood = listFood,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.0),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailFood(
                      listFood: _listFood,
                      index: index,
                    )));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 2 / 1,
              child: Hero(
                tag: 'tgThumb' + index.toString(),
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    child: Image.network(
                      _listFood[index].thumb!,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _listFood[index].title!,
                    maxLines: maxLines,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Estimasi : ' + _listFood[index].times!,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
