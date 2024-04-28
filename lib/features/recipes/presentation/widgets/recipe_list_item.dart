import 'package:cached_network_image/cached_network_image.dart';
import 'package:cgi_assessment/core/theme/color.dart';
import 'package:cgi_assessment/features/recipes/domain/entity/recipe.dart';
import 'package:cgi_assessment/features/recipes/presentation/screens/recipe_details_screen.dart';
import 'package:flutter/material.dart';

class RecipeListItem extends StatelessWidget {
  const RecipeListItem({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RecipeDetailsScreen(recipe: recipe),
          ),
        );
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.only(bottom: 10),
        height: 120,
        width: MediaQuery.of(context).size.width - 40,
        decoration: const BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: recipe.image,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "It can be servable for ${recipe.servings}, and ${recipe.cuisine} type of food. The difficulty level is ${recipe.difficulty}",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          "${recipe.caloriesPerServing} Calories",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
