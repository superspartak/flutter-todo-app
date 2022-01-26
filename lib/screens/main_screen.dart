import 'package:flutter/material.dart';
import 'package:flutter_todo_app/category/category.dart';
import 'package:flutter_todo_app/category/category_dialog.dart';
import 'package:flutter_todo_app/category/category_tile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.categories}) : super(key: key);

  final List<Category> categories;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    categories = widget.categories;
  }

  void _deleteCategory(int id) {
    setState(() {
      categories = categories.where((element) => element.id != id).toList();
    });
  }

  void _addCategory(Category category) {
    setState(() {
      categories.add(category);
    });
  }

  List<Widget> _tileBuilder() {
    List<Widget> tiles = [];

    for (int i = 0; i < categories.length; i++) {
      tiles.add(CategoryTile(categories[i], _deleteCategory));
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
                  child: GridView.count(
                      crossAxisCount: 2, children: _tileBuilder()))
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
