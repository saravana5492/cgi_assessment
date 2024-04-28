import 'package:cgi_assessment/features/recipes/presentation/bloc/recipe_bloc.dart';
import 'package:cgi_assessment/features/recipes/presentation/widgets/recipe_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipesListScreen extends StatefulWidget {
  const RecipesListScreen({super.key});

  @override
  State<RecipesListScreen> createState() => _RecipesListScreenState();
}

class _RecipesListScreenState extends State<RecipesListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RecipeBloc>().add(RecipeFetchRecipes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipes"),
        centerTitle: false,
      ),
      body: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, state) {
          if (state is RecipeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is RecipeSuccess) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                  key: const Key('recipes-list'),
                  itemCount: state.recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = state.recipes[index];
                    return RecipeListItem(recipe: recipe);
                  }),
            );
          }

          if (state is RecipeFailure) {
            return Center(
              child: Text(
                key: const Key('recipe-error'),
                state.message,
              ),
            );
          }

          return const Center(
            child: Text(
              key: Key('no-recipe'),
              "No Recipes Found.",
            ),
          );
        },
      ),
    );
  }
}
