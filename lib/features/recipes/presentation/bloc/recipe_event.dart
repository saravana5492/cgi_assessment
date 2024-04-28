part of 'recipe_bloc.dart';

@immutable
sealed class RecipeEvent extends Equatable {}

class RecipeFetchRecipes extends RecipeEvent {
  @override
  List<Object?> get props => [];
}
