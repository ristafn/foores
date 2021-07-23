import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foores/model/recipe.dart';
import 'package:foores/model/recipe_detail.dart';
import 'package:foores/model/services.dart';
import 'package:foores/view/widget/build_circle_indicator.dart';
import 'package:line_icons/line_icons.dart';

class DetailFood extends StatelessWidget {
  final List<Result> listFood;
  final int index;

  const DetailFood({Key? key, required this.listFood, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final getKey = listFood[index].key!;
    final services = Services();
    final fetchDetailFood = services.fetchDetailFood(
        url: 'https://masak-apa-tomorisakura.vercel.app/api/recipe/$getKey');

    return Scaffold(
      body: FutureBuilder<RecipeDetail>(
        future: fetchDetailFood,
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                  if (constraints.maxWidth <= 600) {
                    return DetailSmallScreen(
                      recipe: snapshot.data!,
                      img: listFood[index].thumb!,
                      index: index,
                    );
                  } else if (constraints.maxWidth <= 1200) {
                    return DetailMediumScreen(
                      recipe: snapshot.data!,
                      img: listFood[index].thumb!,
                      index: index,
                    );
                  } else {
                    return DetailLargeScreen(
                      recipe: snapshot.data!,
                      img: listFood[index].thumb!,
                      index: index,
                    );
                  }
                })
              : BuildCircleIndicator();
        },
      ),
    );
  }
}

class DetailSmallScreen extends StatelessWidget {
  final RecipeDetail recipe;
  final String img;
  final int index;

  const DetailSmallScreen({
    Key? key,
    required this.recipe,
    required this.img,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _results = recipe.results;
    var _author = _results.author;
    List _listIngredients = _results.ingredient;
    List _step = _results.step;

    return BuildCustomScrollView(
      index: index,
      img: img,
      results: _results,
      author: _author,
      listIngredients: _listIngredients,
      step: _step,
    );
  }
}

class DetailMediumScreen extends StatelessWidget {
  final RecipeDetail recipe;
  final String img;
  final int index;

  const DetailMediumScreen({
    Key? key,
    required this.recipe,
    required this.img,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _results = recipe.results;
    var _author = _results.author;
    List _listIngredients = _results.ingredient;
    List _step = _results.step;
    return BuildCustomScrollView2(
      index: index,
      img: img,
      results: _results,
      author: _author,
      listIngredients: _listIngredients,
      step: _step,
      maxWidth: 1,
    );
  }
}

class DetailLargeScreen extends StatelessWidget {
  final RecipeDetail recipe;
  final String img;
  final int index;

  const DetailLargeScreen({
    Key? key,
    required this.recipe,
    required this.img,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _results = recipe.results;
    var _author = _results.author;
    List _listIngredients = _results.ingredient;
    List _step = _results.step;

    return BuildCustomScrollView2(
      results: _results,
      index: index,
      img: img,
      author: _author,
      listIngredients: _listIngredients,
      step: _step,
      maxWidth: 2,
    );
  }
}

class BuildCustomScrollView2 extends StatelessWidget {
  const BuildCustomScrollView2({
    Key? key,
    required Results results,
    required this.index,
    required this.img,
    required Author author,
    required List listIngredients,
    required List step,
    required this.maxWidth,
  })  : _results = results,
        _author = author,
        _listIngredients = listIngredients,
        _step = step,
        super(key: key);

  final Results _results;
  final int index;
  final String img;
  final Author _author;
  final List _listIngredients;
  final List _step;
  final int maxWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: MediaQuery.of(context).size.width / maxWidth,
        padding: const EdgeInsets.only(
          left: 50.0,
          right: 50.0,
        ),
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: const EdgeInsets.only(
                          bottom: 20.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          tooltip: 'kembali',
                        ),
                      )),
                ),
                Text(_results.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                SizedBox(
                  height: 50.0,
                ),
                Hero(
                  tag: 'tgThumb' + index.toString(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      img,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100.0,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.article_outlined),
                            Text(
                              _author.user,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Icon(Icons.fastfood_outlined),
                            Text(
                              _results.servings,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Icon(LineIcons.alternateLevelUp),
                            Text(
                              _results.dificulty,
                              style: TextStyle(
                                color: _results.dificulty == 'Mudah'
                                    ? Colors.green
                                    : _results.dificulty == 'Cukup rumit'
                                        ? Colors.orange[800]!
                                        : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.date_range),
                          Text(
                            _author.datePublished,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 40.0,
                  thickness: 2,
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        top: 20.0,
                        bottom: 20.0,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white24,
                          border: Border(
                              left: BorderSide(
                            color: Colors.black,
                            width: 4.0,
                          ))),
                      child: Text(
                        'Deskripsi',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ExpandableText(
                      _results.desc,
                      style: TextStyle(fontSize: 18.0),
                      expandText: 'Lebih banyak',
                      collapseText: 'Lebih sedikit',
                      maxLines: 5,
                      linkColor: Colors.blue,
                    ),
                  ]),
            ),
          ),
          SliverToBoxAdapter(
              child: Container(
            margin: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 10.0),
            padding: const EdgeInsets.only(
              left: 20.0,
              top: 20.0,
              bottom: 20.0,
            ),
            decoration: BoxDecoration(
                color: Colors.white24,
                border: Border(
                    left: BorderSide(
                  color: Colors.black,
                  width: 4.0,
                ))),
            child: Text(
              'Bahan-bahan',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
          )),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0),
                  child: Text(
                    _listIngredients[index],
                    style: TextStyle(fontSize: 18.0),
                  ));
            }, childCount: _listIngredients.length),
          ),
          SliverToBoxAdapter(
              child: Container(
            margin: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 10.0),
            padding: const EdgeInsets.only(
              left: 20.0,
              top: 20.0,
              bottom: 20.0,
            ),
            decoration: BoxDecoration(
                color: Colors.white24,
                border: Border(
                    left: BorderSide(
                  color: Colors.black,
                  width: 4.0,
                ))),
            child: Text(
              'Langkah-langkah',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
          )),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0),
                  child: Text(
                    _step[index],
                    style: TextStyle(fontSize: 18.0),
                  ));
            }, childCount: _step.length),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 50.0))
        ]),
      ),
    );
  }
}

class BuildCustomScrollView extends StatelessWidget {
  final int index;
  final String img;
  final Results _results;
  final Author _author;
  final List _listIngredients;
  final List _step;

  const BuildCustomScrollView({
    Key? key,
    required this.index,
    required this.img,
    required Results results,
    required Author author,
    required List listIngredients,
    required List step,
  })  : _results = results,
        _author = author,
        _listIngredients = listIngredients,
        _step = step,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Hero(
                    tag: 'tgThumb' + index.toString(),
                    child: Image.network(
                      img,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SafeArea(
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 10.0,
                      left: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      tooltip: 'Kembali',
                    ),
                  ),
                )
              ]),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: <Widget>[
                  Text(_results.title,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                  Divider(
                    height: 50.0,
                    thickness: 1.0,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.article_outlined),
                                    Text(
                                      _author.user,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.fastfood_outlined),
                                    Text(
                                      _results.servings,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.date_range),
                                    Text(
                                      _author.datePublished,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: _results.dificulty == 'Mudah'
                                  ? Colors.green
                                  : _results.dificulty == 'Cukup rumit'
                                      ? Colors.orange[800]!
                                      : Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                _results.dificulty,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 50.0,
                    thickness: 1.0,
                  ),
                ]),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      top: 20.0,
                      bottom: 20.0,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white24,
                        border: Border(
                            left: BorderSide(color: Colors.black, width: 4.0))),
                    child: Text(
                      'Deskripsi',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ExpandableText(
                    _results.desc,
                    expandText: 'Lebih banyak',
                    collapseText: 'Lebih sedikit',
                    maxLines: 5,
                    linkColor: Colors.blue,
                  ),
                ]),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 10.0),
            padding: const EdgeInsets.only(
              left: 20.0,
              top: 20.0,
              bottom: 20.0,
            ),
            decoration: BoxDecoration(
                color: Colors.white24,
                border: Border(
                    left: BorderSide(
                  color: Colors.black,
                  width: 4.0,
                ))),
            child: Text(
              'Bahan-bahan',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Container(
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0),
                child: Text(_listIngredients[index]));
          }, childCount: _listIngredients.length),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 10.0),
            padding: const EdgeInsets.only(
              left: 20.0,
              top: 20.0,
              bottom: 20.0,
            ),
            decoration: BoxDecoration(
                color: Colors.white24,
                border: Border(
                    left: BorderSide(
                  color: Colors.black,
                  width: 4.0,
                ))),
            child: Text(
              'Langkah-langkah',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Container(
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0),
                child: Text(_step[index]));
          }, childCount: _step.length),
        ),
        SliverToBoxAdapter(child: Container(height: 50.0))
      ],
    );
  }
}
