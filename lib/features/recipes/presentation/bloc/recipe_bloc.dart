import 'package:cgi_assessment/features/recipes/domain/entity/recipe.dart';
import 'package:cgi_assessment/features/recipes/domain/usecases/fetch_all_recipes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final FetchAllRecipesUseCase _fetchAllRecipesUseCase;

  RecipeBloc({
    required FetchAllRecipesUseCase fetchAllRecipesUseCase,
  })  : _fetchAllRecipesUseCase = fetchAllRecipesUseCase,
        super(RecipeInitial()) {
    on<RecipeFetchRecipes>(_recipeFetchAllRecipes);
  }

  void _recipeFetchAllRecipes(
      RecipeFetchRecipes event, Emitter<RecipeState> emit) async {
    emit(RecipeLoading());
    final res = await _fetchAllRecipesUseCase.execute();
    res.fold(
      (failure) => emit(RecipeFailure(message: failure.message)),
      (recipes) => emit(RecipeSuccess(recipes: recipes)),
    );
  }
}
