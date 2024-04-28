import 'package:cgi_assessment/core/error/exception.dart';
import 'package:cgi_assessment/core/network/network_constants.dart';
import 'package:cgi_assessment/features/recipes/data/datasources/recipe_remote_datasource.dart';
import 'package:cgi_assessment/features/recipes/data/model/recipe_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../../helpers/json_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late RecipeRemoteDatasourceImpl recipeRemoteDatasourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    recipeRemoteDatasourceImpl =
        RecipeRemoteDatasourceImpl(httpClient: mockHttpClient);
  });

  group('get recipes list', () {
    test('should return recipes list when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(Endpoint.recipes))).thenAnswer(
          (_) async => http.Response(
              readJson('helpers/dummy_data/dummy_recipes_array_response.json'),
              200));

      // act
      final result = await recipeRemoteDatasourceImpl.fetchRecipes();

      // assert
      expect(result, isA<List<RecipeModel>>());
    });

    test(
        'should throw a server execption when the status code is 200 and invalid response',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(Endpoint.recipes)))
          .thenAnswer((_) async => http.Response('', 200));

      // act
      final result = recipeRemoteDatasourceImpl.fetchRecipes();

      // assert
      expect(result, throwsA(isA<ServerException>()));
    });

    test('should throw a server execption when the status code is not 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(Endpoint.recipes)))
          .thenAnswer((_) async => http.Response("Not found.", 404));

      // act
      final result = recipeRemoteDatasourceImpl.fetchRecipes();

      // assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
