import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:grupp_5/components/models/steps_model.dart';
import 'package:grupp_5/components/providers/provider.dart';
import 'package:grupp_5/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:grupp_5/components/db/recipe_database.dart';
import '/constants/routes.dart';

import '../components/models/recipe_model.dart';

class RecipeView extends StatefulWidget {
  const RecipeView({Key? key}) : super(key: key);

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  late List<Recipe> recipes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshRecipes();
  }

  @override
  void dispose() {
    RecipeDatabase.instance.close();
    super.dispose();
  }

  Future refreshRecipes() async {
    setState(() => isLoading = true);
    this.recipes = await RecipeDatabase.instance.readAllRecipes();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: Consumer<RecipeProvider>(
          builder: (context, recipe, child) {
            if (recipe.filterRecipe == null) {
              return const Text(
                'Recipe',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              );
            } else {
              return Text(
                recipe.filterRecipe!.results[0].title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              );
            }
          },
        ),
        actions: [
          Consumer<RecipeProvider>(
            builder: (context, recipe, child) {
              if (recipe.filterRecipe == null) {
                return IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border,
                    color: Colors.black,
                  ),
                );
              } else {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      //add to db
                      RecipeDatabase.instance
                          .create(recipe.filterRecipe!.results[0]);
                      recipe.filterRecipe!.results[0].isFavorite =
                          !recipe.filterRecipe!.results[0].isFavorite;
                    });
                  },
                  icon: recipe.filterRecipe!.results[0].isFavorite
                      ? const Icon(
                          Icons.favorite,
                          color: secondaryColor,
                        )
                      : const Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                        ),
                );
              }
            },
          ),
          //consumer with favourite icon set isFavourite to true when pressed and vice versa
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          recipeImage(),
          recipeInfo(),
          recipeIngredients(),
          recipeInstructions(),
        ],
      ),
    );
  }

  Widget recipeImage() {
    return Consumer<RecipeProvider>(
      builder: (context, recipe, child) {
        if (recipe.filterRecipe?.results == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container(
            width: 320,
            height: 220,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(recipe.filterRecipe!.results[0].image),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          );
        }
      },
    );
  }

  Widget recipeInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<RecipeProvider>(
        builder: (context, recipe, child) {
          if (recipe.filterRecipe != null) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: secondaryColor.withOpacity(0.4),
                    ),
                    Text(
                      '${recipe.filterRecipe!.results[0].readyInMinutes} min',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.people,
                      color: secondaryColor.withOpacity(0.4),
                    ),
                    Text(
                      '${recipe.filterRecipe!.results[0].servings} servings',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget recipeIngredients() {
    return Consumer<RecipeProvider>(
      builder: (context, recipe, child) {
        if (recipe.filterRecipe != null) {
          return Expanded(
            child: Column(
              children: [
                const Text(
                  'Ingredients',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: recipe
                        .filterRecipe!.results[0].extendedIngredients.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Checkbox(
                            value: recipe
                                .filterRecipe!.results[0].ingredientDone[index],
                            onChanged: (value) {
                              setState(() {
                                recipe.filterRecipe!.results[0]
                                    .ingredientDone[index] = value!;
                              });
                            },
                          ),
                          title: Html(
                            data: recipe.filterRecipe!.results[0]
                                .extendedIngredients[index],
                            style: {
                              '#': Style(
                                fontSize: const FontSize(14),
                              ),
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget recipeInstructions() {
    return Consumer<RecipeProvider>(
      builder: (context, recipe, child) {
        if (recipe.filterRecipe != null) {
          return Expanded(
            child: Column(
              children: [
                const Text(
                  'Instructions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: recipe.filterRecipe!.results[0].steps.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Text(
                            recipe.filterRecipe!.results[0].steps[index].number
                                .toString(),
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          title: Html(
                            data: recipe
                                .filterRecipe!.results[0].steps[index].step,
                            style: {
                              '#': Style(
                                fontSize: const FontSize(14),
                              ),
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
