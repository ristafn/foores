import 'package:flutter/material.dart';
import 'package:foores/model/recipe.dart';
import 'package:foores/model/services.dart';
import 'package:foores/view/widget/build_circle_indicator.dart';
import 'package:foores/view/widget/build_grid_view.dart';
import 'package:foores/view/widget/build_list_view.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _textController = TextEditingController();
  String searchQuery = '';
  var services;

  @override
  void initState() {
    services = Services();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fetchSearchRecipe = services.fetchSearchRecipe(
        url:
            'https://masak-apa.tomorisakura.vercel.app/api/search/?q=$searchQuery');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 80.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
          ),
          tooltip: 'Kembali',
        ),
        title: TextFormField(
          controller: _textController,
          onFieldSubmitted: (newQuery) {
            setState(() {
              searchQuery = newQuery;
            });
          },
          onChanged: (String newQuery) {
            setState(() {
              searchQuery = newQuery;
            });
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            suffixIcon: Icon(
              Icons.search,
            ),
            hintText: 'Cari resep makanan...',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.white24),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.white24),
            ),
          ),
        ),
      ),
      body: FutureBuilder<Recipe>(
        future: fetchSearchRecipe,
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

  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
