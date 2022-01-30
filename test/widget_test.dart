// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/category/category.dart';
import 'package:flutter_todo_app/category/category_tile.dart';
import 'package:flutter_todo_app/main.dart';
import 'package:flutter_todo_app/screens/todo_screen.dart';
import 'package:flutter_todo_app/todo/todo.dart';
import 'package:flutter_todo_app/todo/todo_row.dart';

void main() {
  testWidgets('Add, Edit and Remove Category', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Todos'), findsOneWidget);
    expect(find.text('Please create a category to add todos'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text("Enter category details."), findsOneWidget);

    await tester.tap(find.byWidgetPredicate((widget) => widget is TextButton));
    await tester.pump();
    expect(find.text("Can't be empty"), findsOneWidget);

    await tester.enterText(
        find.byWidgetPredicate((widget) => widget is EditableText), 'Shopping');
    await tester.tap(find.byWidgetPredicate((widget) => widget is TextButton));
    await tester.pump();
    expect(find.text("Please create a category to add todos"), findsNothing);
    expect(find.text("Shopping"), findsOneWidget);

    await tester
        .longPress(find.byWidgetPredicate((widget) => widget is CategoryTile));
    await tester.pump();
    expect(find.text("Please choose the action regarding this category."),
        findsOneWidget);

    await tester.tap(find.text('Edit'));
    await tester.pump();

    expect(find.text("Enter category details."), findsOneWidget);

    await tester.enterText(
        find.byWidgetPredicate((widget) => widget is EditableText), 'School');
    await tester.tap(find.byWidgetPredicate((widget) => widget is TextButton));
    await tester.pump();
    expect(find.text("Shopping"), findsNothing);
    expect(find.text("School"), findsOneWidget);

    await tester
        .longPress(find.byWidgetPredicate((widget) => widget is CategoryTile));
    await tester.pump();
    expect(find.text("Please choose the action regarding this category."),
        findsOneWidget);

    await tester.tap(find.text('Delete'));
    await tester.pump();

    expect(find.text("Shopping"), findsNothing);
    expect(find.text("School"), findsNothing);
    expect(find.text("Please create a category to add todos"), findsOneWidget);
  });

  testWidgets('Add Todo', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: TodoScreen(
            category:
                Category(123, 'Bills', Icons.ac_unit, Colors.amber, []))));

    expect(find.text('No todos in this category yet.'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text("Enter todo description."), findsOneWidget);

    await tester.tap(find.byWidgetPredicate((widget) => widget is TextButton));
    await tester.pump();
    expect(find.text("Can't be empty"), findsOneWidget);

    await tester.enterText(
        find.byWidgetPredicate((widget) => widget is EditableText),
        'Electricity');
    await tester.tap(find.byWidgetPredicate((widget) => widget is TextButton));
    await tester.pump();
    expect(find.text("Please create a category to add todos"), findsNothing);
    expect(find.byWidgetPredicate((widget) => widget is TodoRow),
        findsNWidgets(1));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text("Enter todo description."), findsOneWidget);

    await tester.tap(find.byWidgetPredicate((widget) => widget is TextButton));
    await tester.pump();
    expect(find.text("Can't be empty"), findsOneWidget);

    await tester.enterText(
        find.byWidgetPredicate((widget) => widget is EditableText), 'Gas');
    await tester.tap(find.byWidgetPredicate((widget) => widget is TextButton));
    await tester.pump();
    expect(find.text("Please create a category to add todos"), findsNothing);
    expect(find.byWidgetPredicate((widget) => widget is TodoRow),
        findsNWidgets(2));
  });

  testWidgets('Delete Todo', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: TodoScreen(
            category: Category(123, 'Bills', Icons.ac_unit, Colors.amber,
                [Todo(123, 'Test', false)]))));
    expect(
        find.byWidgetPredicate((widget) => widget is TodoRow), findsOneWidget);

    await tester
        .longPress(find.byWidgetPredicate((widget) => widget is TodoRow));
    await tester.pump();

    await tester.tap(find.text('Delete'));
    await tester.pump();

    expect(find.text('No todos in this category yet.'), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is TodoRow), findsNothing);
  });

  testWidgets('Edit Todo', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: TodoScreen(
            category: Category(123, 'Bills', Icons.ac_unit, Colors.amber,
                [Todo(123, 'Electricity', false)]))));

    expect(find.text('Electricity'), findsOneWidget);

    await tester
        .longPress(find.byWidgetPredicate((widget) => widget is TodoRow));
    await tester.pump();

    await tester.tap(find.text('Edit'));
    await tester.pump();

    await tester.enterText(
        find.byWidgetPredicate((widget) => widget is EditableText), 'Gas');
    await tester.tap(find.byWidgetPredicate((widget) => widget is TextButton));
    await tester.pump();

    expect(find.text('Gas'), findsOneWidget);
    expect(
        find.byWidgetPredicate((widget) => widget is TodoRow), findsOneWidget);
  });
  testWidgets('Check Todo', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: TodoScreen(
            category: Category(123, 'Bills', Icons.ac_unit, Colors.amber, [
      Todo(123, 'Electricity', false),
      Todo(124, 'Water', false),
      Todo(125, 'Gas', false)
    ]))));

    expect(
        find.byWidgetPredicate(
            (widget) => widget is TodoRow && widget.todo.done),
        findsNothing);
    expect(
        find.byWidgetPredicate(
            (widget) => widget is TodoRow && !widget.todo.done),
        findsNWidgets(3));
    expect(
        find.descendant(
            of: find.byWidgetPredicate(
                (widget) => widget is TodoRow && widget.todo.desc == 'Gas'),
            matching: find.byWidgetPredicate(
                (widget) => widget is Checkbox && widget.value == true)),
        findsNothing);

    await tester.tap(find.descendant(
        of: find.byWidgetPredicate(
            (widget) => widget is TodoRow && widget.todo.desc == 'Gas'),
        matching: find.byWidgetPredicate((widget) => widget is Checkbox)));

    await tester.pump();

    expect(
        find.byWidgetPredicate(
            (widget) => widget is TodoRow && widget.todo.done),
        findsOneWidget);
    expect(
        find.byWidgetPredicate(
            (widget) => widget is TodoRow && !widget.todo.done),
        findsNWidgets(2));

    expect(
        find.descendant(
            of: find.byWidgetPredicate(
                (widget) => widget is TodoRow && widget.todo.desc == 'Gas'),
            matching: find.byWidgetPredicate(
                (widget) => widget is Checkbox && widget.value == true)),
        findsOneWidget);
  });

  testWidgets('Uncheck Todo', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: TodoScreen(
            category: Category(123, 'Bills', Icons.ac_unit, Colors.amber, [
      Todo(123, 'Electricity', true),
      Todo(124, 'Water', true),
      Todo(125, 'Gas', false)
    ]))));

    expect(
        find.byWidgetPredicate(
            (widget) => widget is TodoRow && widget.todo.done),
        findsNWidgets(2));
    expect(
        find.byWidgetPredicate(
            (widget) => widget is TodoRow && !widget.todo.done),
        findsNWidgets(1));
    expect(
        find.descendant(
            of: find.byWidgetPredicate(
                (widget) => widget is TodoRow && widget.todo.desc == 'Water'),
            matching: find.byWidgetPredicate(
                (widget) => widget is Checkbox && widget.value == false)),
        findsNothing);

    await tester.tap(find.descendant(
        of: find.byWidgetPredicate(
            (widget) => widget is TodoRow && widget.todo.desc == 'Water'),
        matching: find.byWidgetPredicate((widget) => widget is Checkbox)));

    await tester.pump();

    expect(
        find.byWidgetPredicate(
            (widget) => widget is TodoRow && widget.todo.done),
        findsNWidgets(1));
    expect(
        find.byWidgetPredicate(
            (widget) => widget is TodoRow && !widget.todo.done),
        findsNWidgets(2));

    expect(
        find.descendant(
            of: find.byWidgetPredicate(
                (widget) => widget is TodoRow && widget.todo.desc == 'Water'),
            matching: find.byWidgetPredicate(
                (widget) => widget is Checkbox && widget.value == false)),
        findsOneWidget);
  });
}
