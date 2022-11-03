//firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grupp_5/components/db/recipe_database.dart';
import 'package:grupp_5/components/models/recipe_db_model.dart';
import 'package:grupp_5/components/providers/provider.dart';
import 'package:grupp_5/constants/constants.dart';
import 'package:grupp_5/constants/routes.dart';
import 'package:grupp_5/views/login_register_view/auth.dart';
import 'package:provider/provider.dart';

//stateful
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  late List<RecipeDb> recipeDb;
  final User? user = Auth().currentUser;

  @override
  void initState() {
    super.initState();
    refreshRecipes();
  }

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Future refreshRecipes() async {
    setState(() => isLoading = true);
    this.recipeDb = await RecipeDatabase.instance.readAllRecipes();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              _userUid(),
              _signOutButton(),
              _categoriesGridView(),
              _savedRecipesGridView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userUid() {
    return Text('Welcome ${user?.email}', style: const TextStyle(fontSize: 20));
  }

  Widget _savedRecipesGridView() {
    return Column(children: [
      const Text('Saved Recipes', style: TextStyle(fontSize: 20)),
      isLoading
          ? loadingAnimation
          : recipeDb.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('No saved recipes'),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: recipeDb.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final recipe = recipeDb[index];
                    return GestureDetector(
                      onTap: () {
                        Provider.of<RecipeProvider>(context, listen: false)
                            .setRecipeId(recipe.id.toString());
                        Provider.of<RecipeProvider>(context, listen: false)
                            .getSavedRecipe();
                        Navigator.of(context).pushNamed(recipeSavedViewRoute);
                      },
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(recipe.image),
                            Text(recipe.title),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    ]);
  }

  //categories gridview scroll
  Widget _categoriesGridView() {
    return Consumer<RecipeProvider>(
      builder: (context, recipeProvider, child) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recipeProvider.recipes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // recipeProvider.setCategory(recipeProvider.categories[index]);
                // Navigator.pushNamed(context, '/category');
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      recipeProvider.recipes[index].image,
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      recipeProvider.recipes[index].title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },

      // return GridView.count(
      //   crossAxisCount: 2,
      //   childAspectRatio: 1.0,
      //   mainAxisSpacing: 4.0,
      //   crossAxisSpacing: 4.0,
      //   shrinkWrap: true,
      //   physics: const NeverScrollableScrollPhysics(),
      //   children: _categories.map((category) {
      //     return _categoryItem(category);
      //   }).toList(),
      // ),
    );
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sign Out'),
    );
  }
}
