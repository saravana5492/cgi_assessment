import 'package:cgi_assessment/features/recipes/data/datasources/recipe_remote_datasource.dart';
import 'package:cgi_assessment/features/recipes/data/repository/recipe_repository_impl.dart';
import 'package:cgi_assessment/features/recipes/domain/repository/recipe_repository.dart';
import 'package:cgi_assessment/features/recipes/domain/usecases/fetch_all_recipes.dart';
import 'package:cgi_assessment/features/recipes/presentation/bloc/recipe_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final serviceLocator = GetIt.instance;

void initDependencies() {
  _initRecipe();

  // Http Client
  var httpClient = http.Client();
  serviceLocator.registerLazySingleton(
    () => httpClient,
  );
}

void _initRecipe() {
  // Data source
  serviceLocator.registerFactory<RecipeRemoteDatasource>(
    () => RecipeRemoteDatasourceImpl(
      httpClient: serviceLocator(),
    ),
  );

  // Repository
  serviceLocator.registerFactory<RecipeRepository>(
    () => RecipeRepositoryImpl(
      remoteDataSource: serviceLocator(),
    ),
  );

  // Use case
  serviceLocator.registerFactory(
    () => FetchAllRecipesUseCase(
      recipeRepository: serviceLocator(),
    ),
  );

  // Bloc
  serviceLocator.registerFactory(
    () => RecipeBloc(
      fetchAllRecipesUseCase: serviceLocator(),
    ),
  );
}
