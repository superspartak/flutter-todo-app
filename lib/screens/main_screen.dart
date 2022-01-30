import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/category/category.dart';
import 'package:flutter_todo_app/category/category_dialog.dart';
import 'package:flutter_todo_app/category/category_service.dart';
import 'package:flutter_todo_app/category/category_tile.dart';
import 'package:flutter_todo_app/commons/emptyList.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Category> categories = [];

  @override
  initState() {
    super.initState();
    getCategories();
  }

  Future<void> getCategories() async {
    CategoryService().getFromStorage().then((value) {
      categories = value;
      setState(() {});
    });
  }

  void _deleteCategory(int id) {
    setState(() {
      categories = categories.where((element) => element.id != id).toList();
      CategoryService().removeFromStorage(id);
    });
  }

  void _addCategory(Category category) {
    setState(() {
      categories.add(category);
      CategoryService().saveToStorage(category);
    });
  }

  void _editCategory(int id, String name, Color color, IconData icon) {
    setState(() {
      var updatedCategory =
          categories.firstWhere((element) => element.id == id);
      updatedCategory.name = name;
      updatedCategory.color = color;
      updatedCategory.icon = icon;
      CategoryService().saveToStorage(updatedCategory);
    });
  }

  List<Widget> _tileBuilder() {
    List<Widget> tiles = [];

    for (int i = 0; i < categories.length; i++) {
      tiles.add(CategoryTile(categories[i], _deleteCategory, _editCategory));
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                  child: Icon(
                    Icons.menu_outlined,
                    size: 32,
                  )),
              const Text(
                'Todos',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Expanded(
                  child: categories.isNotEmpty
                      ? GridView.count(
                          crossAxisCount: foundation.kIsWeb ? 5 : 2,
                          children: _tileBuilder())
                      : const EmptyList(
                          'Please create a category to add todos'))
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: openCreateCategoryDialog,
        tooltip: 'Add Category',
        child: const Icon(Icons.add),
      ),
    );
  }

  void openCreateCategoryDialog() {
    showDialog(
        context: context, builder: (context) => CategoryDialog(_addCategory));
  }
}
