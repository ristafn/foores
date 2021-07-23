import 'package:foores/model/recipe_detail.dart';
import 'package:http/http.dart' as http;
import 'package:foores/model/recipe.dart';

class Services {
  Future<Recipe> fetchDataFood() async {
    String url = 'https://masak-apa-tomorisakura.vercel.app/api/recipes';
    final response = await http.get(Uri.parse(url));
    return recipeFromJson(response.body);
  }

  Future<RecipeDetail> fetchDetailFood({required String url}) async {
    final response = await http.get(Uri.parse(url));
    return recipeDetailFromJson(response.body);
  }

  Future<Recipe> fetchSearchRecipe({required String url}) async {
    final response = await http.get(Uri.parse(url));
    return recipeFromJson(response.body);
  }
}
