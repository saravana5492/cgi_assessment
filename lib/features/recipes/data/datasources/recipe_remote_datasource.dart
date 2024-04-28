import 'dart:convert';

import 'package:cgi_assessment/core/error/exception.dart';
import 'package:cgi_assessment/core/network/network_constants.dart';
import 'package:cgi_assessment/features/recipes/data/model/recipe_model.dart';
import 'package:http/http.dart' as http;

abstract interface class RecipeRemoteDatasource {
  Future<List<RecipeModel>> fetchRecipes();
}

class RecipeRemoteDatasourceImpl implements RecipeRemoteDatasource {
  final http.Client httpClient;
  RecipeRemoteDatasourceImpl({required this.httpClient});

  @override
  Future<List<RecipeModel>> fetchRecipes() async {
    try {
      var url = Uri.parse(Endpoint.recipes);
      var response = await httpClient.get(url);
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body)["recipes"];
        var recipes = fromResponseJson(parsed);
        return recipes;
      } else {
        throw const ServerException("No response found");
      }
    } catch (err) {
      throw ServerException(err.toString());
    }
  }
}
