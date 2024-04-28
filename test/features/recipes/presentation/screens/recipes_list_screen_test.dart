import 'dart:convert';
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:cgi_assessment/features/recipes/data/model/recipe_model.dart';
import 'package:cgi_assessment/features/recipes/presentation/bloc/recipe_bloc.dart';
import 'package:cgi_assessment/features/recipes/presentation/screens/recipes_list_screen.dart';
import 'package:cgi_assessment/features/recipes/presentation/widgets/recipe_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/json_reader.dart';

class RecipeMockBloc extends MockBloc<RecipeEvent, RecipeState>
    implements RecipeBloc {}

void main() {
  late RecipeMockBloc recipeMockBloc;

  setUp(() {
    recipeMockBloc = RecipeMockBloc();
    HttpOverrides.global = null;
  });

  Widget _makeTestWidget(Widget body) {
    return BlocProvider<RecipeBloc>(
      create: (context) => recipeMockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('test recipes list screen', () {
    testWidgets('should show loader initial', (widgetTester) async {
      // arrange
      when(() => recipeMockBloc.state).thenReturn(RecipeLoading());

      // act
      await widgetTester.pumpWidget(_makeTestWidget(const RecipesListScreen()));

      // assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show list of recipes on success', (widgetTester) async {
      // arrange
      final recipesJson =
          readJson('helpers/dummy_data/dummy_recipes_array_response.json');
      final parsed = json.decode(recipesJson)["recipes"];
      var recipes = fromResponseJson(parsed).map((e) => e.toEntity()).toList();

      when(() => recipeMockBloc.state)
          .thenReturn(RecipeSuccess(recipes: recipes));

      // act
      await widgetTester.pumpWidget(_makeTestWidget(const RecipesListScreen()));

      // assert
      expect(find.byKey(const Key('recipes-list')), findsOneWidget);
      expect(find.byType(RecipeListItem), findsWidgets);
      expect(find.text(recipes[0].name), findsOneWidget);
      expect(find.text("${recipes[0].caloriesPerServing} Calories"),
          findsOneWidget);
      expect(find.text(recipes[1].name), findsOneWidget);
      expect(find.text("${recipes[3].caloriesPerServing} Calories"),
          findsOneWidget);
    });

    testWidgets('should show error text on failure', (widgetTester) async {
      // arrange
      when(() => recipeMockBloc.state)
          .thenReturn(RecipeFailure(message: "Something went wrong"));

      // act
      await widgetTester.pumpWidget(_makeTestWidget(const RecipesListScreen()));

      // assert
      expect(find.text("Something went wrong"), findsOneWidget);
    });
  });
}
