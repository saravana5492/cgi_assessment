import 'dart:convert';

import 'package:cgi_assessment/features/recipes/data/model/recipe_model.dart';
import 'package:cgi_assessment/features/recipes/domain/entity/recipe.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/json_reader.dart';

void main() {
  const testRecipeModel = RecipeModel(
    id: 1,
    name: "Classic Margherita Pizza",
    ingredients: [
      "Pizza dough",
      "Tomato sauce",
    ],
    instructions: [
      "Preheat the oven to 475°F (245°C).",
      "Roll out the pizza dough and spread tomato sauce evenly."
    ],
    prepTimeMinutes: 20,
    cookTimeMinutes: 30,
    servings: 4,
    difficulty: "Easy",
    cuisine: "Italian",
    caloriesPerServing: 300,
    tags: ["Pizza"],
    userId: 45,
    image: "https://cdn.dummyjson.com/recipe-images/1.webp",
    rating: 4.6,
    reviewCount: 3,
    mealType: ["Dinner"],
  );

  test('should be a subsclass of Recipe Entity', () async {
    // assert
    expect(testRecipeModel, isA<Recipe>());
  });

  test('should return valid model from json', () async {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('helpers/dummy_data/dummy_recipe_response.json'));

    // act
    final result = RecipeModel.fromJson(jsonMap);

    // assert
    expect(result, equals(testRecipeModel));
  });

  test('should return a json map which contains proper data', () async {
    // act
    final result = testRecipeModel.toJson();

    final Map<String, dynamic> expectedJsonMap =
        json.decode(readJson('helpers/dummy_data/dummy_recipe_response.json'));

    // assert
    expect(result, expectedJsonMap);
  });
}
