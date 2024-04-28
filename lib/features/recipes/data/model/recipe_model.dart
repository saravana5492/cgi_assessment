import 'package:cgi_assessment/features/recipes/domain/entity/recipe.dart';

List<RecipeModel> fromResponseJson(List<dynamic> listDynamic) {
  return List<RecipeModel>.from(
      listDynamic.map((x) => RecipeModel.fromJson(x)));
}

class RecipeModel extends Recipe {
  const RecipeModel({
    required super.id,
    required super.name,
    required super.ingredients,
    required super.instructions,
    required super.prepTimeMinutes,
    required super.cookTimeMinutes,
    required super.servings,
    required super.difficulty,
    required super.cuisine,
    required super.caloriesPerServing,
    required super.tags,
    required super.userId,
    required super.image,
    required super.rating,
    required super.reviewCount,
    required super.mealType,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        id: json["id"],
        name: json["name"],
        ingredients: List<String>.from(json["ingredients"].map((x) => x)),
        instructions: List<String>.from(json["instructions"].map((x) => x)),
        prepTimeMinutes: json["prepTimeMinutes"],
        cookTimeMinutes: json["cookTimeMinutes"],
        servings: json["servings"],
        difficulty: json["difficulty"],
        cuisine: json["cuisine"],
        caloriesPerServing: json["caloriesPerServing"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        userId: json["userId"],
        image: json["image"],
        rating: json["rating"]?.toDouble(),
        reviewCount: json["reviewCount"],
        mealType: List<String>.from(json["mealType"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "ingredients": List<String>.from(ingredients.map((x) => x)),
        "instructions": List<String>.from(instructions.map((x) => x)),
        "prepTimeMinutes": prepTimeMinutes,
        "cookTimeMinutes": cookTimeMinutes,
        "servings": servings,
        "difficulty": difficulty,
        "cuisine": cuisine,
        "caloriesPerServing": caloriesPerServing,
        "tags": List<String>.from(tags.map((x) => x)),
        "userId": userId,
        "image": image,
        "rating": rating,
        "reviewCount": reviewCount,
        "mealType": List<String>.from(mealType.map((x) => x)),
      };

  Recipe toEntity() => Recipe(
        id: id,
        name: name,
        ingredients: ingredients,
        instructions: instructions,
        prepTimeMinutes: prepTimeMinutes,
        cookTimeMinutes: cookTimeMinutes,
        servings: servings,
        difficulty: difficulty,
        cuisine: cuisine,
        caloriesPerServing: caloriesPerServing,
        tags: tags,
        userId: userId,
        image: image,
        rating: rating,
        reviewCount: reviewCount,
        mealType: mealType,
      );
}
