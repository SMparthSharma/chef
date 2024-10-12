class RecipeModel{
  late String foodLabel;
  late String image;
  late String recipe;
  late double calories;

  RecipeModel(
      {this.image="pizza",
      this.foodLabel="pizza",
      this.calories=500.0,
      this.recipe="milk",
      });
  factory RecipeModel.fromMap(Map recipe){
    return RecipeModel(
      foodLabel: recipe["label"],
      image: recipe["image"],
      calories: recipe["calories"],
      recipe: recipe["url"]

    );
  }

}

