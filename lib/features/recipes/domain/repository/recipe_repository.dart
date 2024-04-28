import 'package:cgi_assessment/core/error/failure.dart';
import 'package:cgi_assessment/features/recipes/domain/entity/recipe.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class RecipeRepository {
  Future<Either<Failure, List<Recipe>>> fetchAllRecipes();
}
