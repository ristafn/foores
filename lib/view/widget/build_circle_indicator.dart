import 'package:flutter/material.dart';

class BuildCircleIndicator extends StatelessWidget {
  const BuildCircleIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: Center(child: CircularProgressIndicator()));
  }
}
