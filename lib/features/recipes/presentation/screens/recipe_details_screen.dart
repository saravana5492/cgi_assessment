import 'package:cached_network_image/cached_network_image.dart';
import 'package:cgi_assessment/features/recipes/domain/entity/recipe.dart';
import 'package:flutter/material.dart';

class RecipeDetailsScreen extends StatelessWidget {
  const RecipeDetailsScreen({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                recipe.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              CachedNetworkImage(
                imageUrl: recipe.image,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width - 36,
                height: 250,
              ),
              const SizedBox(height: 12),
              Text(
                  "⏰ Prep: ${recipe.prepTimeMinutes} mins  |  Cook: ${recipe.cookTimeMinutes} mins"),
              const SizedBox(height: 12),
              Wrap(
                children: recipe.tags
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Chip(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          label: Text(e),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 12),
              const Text("🥗 Ingredients:",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Text(recipe.ingredients.join(", ")),
              const SizedBox(height: 20),
              Text(
                "🥙 Calories: ${recipe.caloriesPerServing} cals  |  Cuisine: ${recipe.cuisine}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text("📜 Instructions:",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Text(recipe.instructions.join("\n")),
            ],
          ),
        ),
      ),
    );
  }
}
