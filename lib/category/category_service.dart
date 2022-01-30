import 'package:flutter_todo_app/category/category.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryService {
  Future<List<Category>> getFromStorage() async {
    List<Category> cats = [];
    var instance = await SharedPreferences.getInstance();
    instance.getKeys().forEach((key) {
      cats.add(Category.fromJson(instance.getString(key)!));
    });
    return cats;
  }

  Future<void> saveToStorage(Category category) async {
    var instance = await SharedPreferences.getInstance();

    instance.setString(category.id.toString(), category.toJson());
  }

  Future<void> removeFromStorage(int id) async {
    var instance = await SharedPreferences.getInstance();
    instance.remove(id.toString());
  }
}
