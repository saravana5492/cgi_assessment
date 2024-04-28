import 'dart:io';

import 'package:cgi_assessment/core/error/exception.dart';
import 'package:cgi_assessment/core/error/failure.dart';
import 'package:cgi_assessment/features/recipes/data/model/recipe_model.dart';
import 'package:cgi_assessment/features/recipes/data/repository/recipe_repository_impl.dart';
import 'package:cgi_assessment/features/recipes/domain/entity/recipe.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockRecipeRemoteDatasource mockRecipeRemoteDatasource;
  late RecipeRepositoryImpl recipeRepositoryImpl;

  const testRecipesModel = [
    RecipeModel(
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
    )
  ];

  const testRecipesEntity = [
    Recipe(
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
    )
  ];

  setUp(() {
    mockRecipeRemoteDatasource = MockRecipeRemoteDatasource();
    recipeRepositoryImpl =
        RecipeRepositoryImpl(remoteDataSource: mockRecipeRemoteDatasource);
    provideDummy<Either<Failure, List<Recipe>>>(right(testRecipesEntity));
  });

  group('get current recipes list', () {
    test('should return recipes when remote data source in success', () async {
      // arrange
      when(mockRecipeRemoteDatasource.fetchRecipes())
          .thenAnswer((_) async => testRecipesModel);

      // act
      final result = await recipeRepositoryImpl.fetchAllRecipes();
      final recipes = result.fold((l) => null, (r) => r);

      // assert
      expect(recipes, testRecipesEntity);
    });

    test('should return server failure when data source is not success',
        () async {
      // arrange
      when(mockRecipeRemoteDatasource.fetchRecipes())
          .thenThrow(const ServerException('Invalid response'));

      // act
      final result = await recipeRepositoryImpl.fetchAllRecipes();

      // assert
      expect(
          result,
          equals(left<Failure, List<Recipe>>(
              const ServerFailure("Invalid response"))));
    });

    test('should return server failure when not connected to internet',
        () async {
      // arrange
      when(mockRecipeRemoteDatasource.fetchRecipes())
          .thenThrow(const SocketException('Internet connection failed'));

      // act
      final result = await recipeRepositoryImpl.fetchAllRecipes();

      // assert
      expect(
          result,
          equals(left<Failure, List<Recipe>>(
              const ConnectionFailure("Internet connection failed"))));
    });
  });
}
