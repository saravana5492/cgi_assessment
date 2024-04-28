import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  final int id;
  final String name;
  final List<String> ingredients;
  final List<String> instructions;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final int servings;
  final String difficulty;
  final String cuisine;
  final int caloriesPerServing;
  final List<String> tags;
  final int userId;
  final String image;
  final double rating;
  final int reviewCount;
  final List<String> mealType;

  const Recipe({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.servings,
    required this.difficulty,
    required this.cuisine,
    required this.caloriesPerServing,
    required this.tags,
    required this.userId,
    required this.image,
    required this.rating,
    required this.reviewCount,
    required this.mealType,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        ingredients,
        instructions,
        prepTimeMinutes,
        cookTimeMinutes,
        servings,
        difficulty,
        cuisine,
        caloriesPerServing,
        tags,
        userId,
        image,
        rating,
        reviewCount,
        mealType,
      ];
}
