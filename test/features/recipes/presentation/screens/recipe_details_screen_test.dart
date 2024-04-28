import 'dart:io';

import 'package:cgi_assessment/core/utils/array_to_string.dart';
import 'package:cgi_assessment/features/recipes/domain/entity/recipe.dart';
import 'package:cgi_assessment/features/recipes/presentation/screens/recipe_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    HttpOverrides.global = null;
  });

  testWidgets('details screen should contain recipe details',
      (widgetTester) async {
    // arrange
    const testRecipeEntity = Recipe(
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

    // act
    await widgetTester.pumpWidget(const MaterialApp(
      home: RecipeDetailsScreen(
        recipe: testRecipeEntity,
      ),
    ));

    // assert
    expect(find.text(testRecipeEntity.name), findsOneWidget);
    expect(find.text("Prep: ${testRecipeEntity.prepTimeMinutes} mins"),
        findsOneWidget);
    expect(find.text("Cook: ${testRecipeEntity.cookTimeMinutes} mins"),
        findsOneWidget);
    expect(find.text(testRecipeEntity.tags[0]), findsOneWidget);
    expect(find.text(arrayToString(testRecipeEntity.ingredients, ", ")),
        findsOneWidget);
    expect(find.text(arrayToString(testRecipeEntity.instructions, "\n")),
        findsOneWidget);
    expect(find.text("Calories: ${testRecipeEntity.caloriesPerServing} cals"),
        findsOneWidget);
    expect(find.text("Cuisine: ${testRecipeEntity.cuisine}"), findsOneWidget);
  });
}
