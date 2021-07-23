import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foores/model/recipe.dart';
import 'package:foores/model/services.dart';
import 'package:foores/view/search.dart';
import 'package:foores/view/widget/build_circle_indicator.dart';
import 'package:foores/view/widget/build_grid_view.dart';
import 'package:foores/view/widget/build_list_view.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final services = Services();
    final fetchDataFood = services.fetchDataFood();

    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 10.0),
          child: Image.asset(
            'assets/logo.png',
          ),
        ),
        title: Text('Foores',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lobster')),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            tooltip: 'Cari',
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Search()));
            },
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<Recipe>(
        future: fetchDataFood,
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    if (constraints.maxWidth <= 600) {
                      // SmallScreen
                      return BuildListView(
                        food: snapshot.data!,
                        fontSize: 15.0,
                        maxLines: 2,
                      );
                    } else if (constraints.maxWidth <= 1200) {
                      // MediumScreen
                      return BuildGridView(
                        food: snapshot.data!,
                        count: 3,
                        fontSize: 15.0,
                        maxLines: 2,
                      );
                    } else {
                      // LargeScreen
                      return BuildGridView(
                        food: snapshot.data!,
                        fontSize: 20.0,
                        count: 4,
                        maxLines: 5,
                      );
                    }
                  },
                )
              : BuildCircleIndicator();
        },
      ),
    );
  }
}