import 'dart:io';

import 'package:cgi_assessment/core/error/exception.dart';
import 'package:cgi_assessment/core/error/failure.dart';
import 'package:cgi_assessment/features/recipes/data/datasources/recipe_remote_datasource.dart';
import 'package:cgi_assessment/features/recipes/domain/entity/recipe.dart';
import 'package:cgi_assessment/features/recipes/domain/repository/recipe_repository.dart';
import 'package:fpdart/fpdart.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDatasource remoteDataSource;
  RecipeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Recipe>>> fetchAllRecipes() async {
    try {
      final recipes = await remoteDataSource.fetchRecipes();
      final recipeEntities = recipes.map((value) => value.toEntity()).toList();
      return right(recipeEntities);
    } on ServerException catch (err) {
      return left(ServerFailure(err.message));
    } on SocketException {
      return left(const ConnectionFailure("Internet connection failed"));
    }
  }
}
