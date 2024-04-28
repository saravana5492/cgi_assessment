import 'package:cgi_assessment/core/error/failure.dart';
import 'package:cgi_assessment/features/recipes/domain/entity/recipe.dart';
import 'package:cgi_assessment/features/recipes/domain/repository/recipe_repository.dart';
import 'package:fpdart/fpdart.dart';

class FetchAllRecipesUseCase {
  final RecipeRepository recipeRepository;
  FetchAllRecipesUseCase({required this.recipeRepository});

  Future<Either<Failure, List<Recipe>>> execute() async {
    return await recipeRepository.fetchAllRecipes();
  }
}
