part of 'recipe_bloc.dart';

@immutable
sealed class RecipeState extends Equatable {}

final class RecipeInitial extends RecipeState {
  @override
  List<Object?> get props => [];
}

final class RecipeLoading extends RecipeState {
  @override
  List<Object?> get props => [];
}

final class RecipeFailure extends RecipeState {
  final String message;
  RecipeFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

final class RecipeSuccess extends RecipeState {
  final List<Recipe> recipes;
  RecipeSuccess({required this.recipes});

  @override
  List<Object?> get props => [recipes];
}
