import 'package:cgi_assessment/features/recipes/data/datasources/recipe_remote_datasource.dart';
import 'package:cgi_assessment/features/recipes/domain/repository/recipe_repository.dart';
import 'package:cgi_assessment/features/recipes/domain/usecases/fetch_all_recipes.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  RecipeRepository,
  RecipeRemoteDatasource,
  FetchAllRecipesUseCase
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
])
void main() {}
