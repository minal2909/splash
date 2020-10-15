import 'package:splash/model/categories_model.dart';

String apiKey = "563492ad6f91700001000001109676414a6f409999eb6c308f8c4a10";

List<CategoriesModel> getCategories() {
  List<CategoriesModel> categories = new List();
  CategoriesModel categoriesModel = new CategoriesModel();

  categoriesModel.imgURL =
      "https://images.pexels.com/photos/545008/pexels-photo-545008.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoriesModel.catagoriesName = "Street art";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.imgURL =
      "https://images.pexels.com/photos/704320/pexels-photo-704320.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoriesModel.catagoriesName = "Wild life";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.imgURL =
      "https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoriesModel.catagoriesName = "Nature";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.imgURL =
      "https://images.pexels.com/photos/466685/pexels-photo-466685.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoriesModel.catagoriesName = "City";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.imgURL =
      "https://images.pexels.com/photos/1434819/pexels-photo-1434819.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260";
  categoriesModel.catagoriesName = "Motivation";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.imgURL =
      "https://images.pexels.com/photos/2116475/pexels-photo-2116475.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoriesModel.catagoriesName = "Bikes";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.imgURL =
      "https://images.pexels.com/photos/1149137/pexels-photo-1149137.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoriesModel.catagoriesName = "Cars";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.imgURL =
      "https://images.pexels.com/photos/1910236/pexels-photo-1910236.jpeg?auto=compress&cs=tinysrg&dpr=2&w=500";
  categoriesModel.catagoriesName = "Art";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.imgURL =
      "https://images.pexels.com/photos/46710/pexels-photo-46710.jpeg?auto=compress&cs=tinysrg&dpr=2&w=500";
  categoriesModel.catagoriesName = "Summer";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.imgURL =
      "https://images.pexels.com/photos/1114900/pexels-photo-1114900.jpeg?auto=compress&cs=tinysrg&dpr=2&w=500";
  categoriesModel.catagoriesName = "Space";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.imgURL =
      "https://images.pexels.com/photos/2833909/pexels-photo-2833909.jpeg?auto=compress&cs=tinysrg&dpr=2&w=500";
  categoriesModel.catagoriesName = "Sunset";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  return categories;
}
