import 'package:cgi_assessment/core/error/failure.dart';
import 'package:cgi_assessment/features/recipes/domain/entity/recipe.dart';
import 'package:cgi_assessment/features/recipes/presentation/bloc/recipe_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockFetchAllRecipesUseCase mockFetchAllRecipesUseCase;
  late RecipeBloc recipeBloc;

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
    mockFetchAllRecipesUseCase = MockFetchAllRecipesUseCase();
    recipeBloc = RecipeBloc(fetchAllRecipesUseCase: mockFetchAllRecipesUseCase);
    provideDummy<Either<Failure, List<Recipe>>>(right(testRecipesEntity));
  });

  test('initial state should be intial', () {
    // assert
    expect(recipeBloc.state, RecipeInitial());
  });

  blocTest<RecipeBloc, RecipeState>(
    'should emit [RecipeLoading, RecipeSuccess] when get data successfully',
    build: () {
      when(mockFetchAllRecipesUseCase.execute())
          .thenAnswer((_) async => right(testRecipesEntity));
      return recipeBloc;
    },
    act: (bloc) => bloc.add(RecipeFetchRecipes()),
    wait: const Duration(microseconds: 500),
    expect: () => <RecipeState>[
      RecipeLoading(),
      RecipeSuccess(recipes: testRecipesEntity)
    ],
  );

  blocTest<RecipeBloc, RecipeState>(
    'should emit [RecipeLoading, RecipeFailure] when get data successfully',
    build: () {
      when(mockFetchAllRecipesUseCase.execute())
          .thenAnswer((_) async => left(const ServerFailure("Server failure")));
      return recipeBloc;
    },
    act: (bloc) => bloc.add(RecipeFetchRecipes()),
    wait: const Duration(microseconds: 500),
    expect: () => <RecipeState>[
      RecipeLoading(),
      RecipeFailure(message: "Server failure")
    ],
  );
}
