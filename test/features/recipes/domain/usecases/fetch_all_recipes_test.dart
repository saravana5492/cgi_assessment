import 'package:cgi_assessment/core/error/failure.dart';
import 'package:cgi_assessment/features/recipes/domain/entity/recipe.dart';
import 'package:cgi_assessment/features/recipes/domain/usecases/fetch_all_recipes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late FetchAllRecipesUseCase fetchAllRecipesUseCase;
  late MockRecipeRepository mockRecipeRepository;

  const testRecipesList = [
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
    ),
  ];

  setUp(() {
    mockRecipeRepository = MockRecipeRepository();
    fetchAllRecipesUseCase =
        FetchAllRecipesUseCase(recipeRepository: mockRecipeRepository);
    provideDummy<Either<Failure, List<Recipe>>>(right(testRecipesList));
  });

  test('should get list of recipes from the repository', () async {
    // arrange
    when(mockRecipeRepository.fetchAllRecipes())
        .thenAnswer((_) async => right(testRecipesList));

    // act
    final result = await fetchAllRecipesUseCase.execute();

    // assert
    expect(result, right(testRecipesList));
  });
}
