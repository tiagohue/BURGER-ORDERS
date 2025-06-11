import 'package:burger_orders/data/models/burger.dart';
import 'package:burger_orders/data/repositories/burger_repository.dart';
import 'package:burger_orders/ui/widgets/add_button.dart';
import 'package:burger_orders/ui/widgets/standard_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BurgersPage extends StatefulWidget {
  const BurgersPage({super.key});

  @override
  State<StatefulWidget> createState() => _BurgersPageState();
}

class _BurgersPageState extends State<BurgersPage> {
  @override
  Widget build(BuildContext context) {
    final repo = context.watch<BurgerRepository>();

    final nameController = TextEditingController();
    final ingredientsController = TextEditingController();
    final priceController = TextEditingController();

    final updateNameController = TextEditingController();
    final updateIngredientsController = TextEditingController();
    final updatePriceController = TextEditingController();

    @override
    // ignore: unused_element
    void dispose() {
      nameController.dispose();
      ingredientsController.dispose();
      priceController.dispose();
      super.dispose();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Burgers")),
        body: Center(
          child: ListView.builder(
            itemCount: repo.burgers.length,
            itemBuilder: (_, index) {
              Burger burger = repo.burgers[index];
              return ListTile(
                title: Text(
                  burger.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(
                  formatReal(burger.price),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // remove button
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => StandardDialog(
                            title: "Delete Burger",
                            content: Text(
                              "Are you sure to delete ${burger.name}?",
                            ),
                            onConfirm: () {
                              repo.delete(burger.id!);

                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Burger deleted!"),
                                ),
                              );
                            },
                            confirmText: "Delete",
                          ),
                        );
                      },
                      icon: Icon(MaterialCommunityIcons.hamburger_minus),
                    ),
                    // edit button
                    IconButton(
                      onPressed: () {
                        updateNameController.text = burger.name;
                        updateIngredientsController.text = burger.ingredients;
                        updatePriceController.text = burger.price.toString();

                        showDialog(
                          context: context,
                          builder: (_) => StandardDialog(
                            title: "Update Burger",
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: updateNameController,
                                  decoration: InputDecoration(
                                    labelText: "Name",
                                  ),
                                ),
                                TextField(
                                  controller: updateIngredientsController,
                                  decoration: InputDecoration(
                                    labelText: "Ingredients",
                                  ),
                                ),
                                TextField(
                                  controller: updatePriceController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: "Price",
                                  ),
                                ),
                              ],
                            ),
                            onConfirm: () {
                              final name = updateNameController.text.trim();
                              final ingredients = updateIngredientsController
                                  .text
                                  .trim();
                              final price =
                                  double.tryParse(
                                    updatePriceController.text.trim(),
                                  ) ??
                                  0.0;

                              if (name.isEmpty ||
                                  ingredients.isEmpty ||
                                  price <= 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Fill in all fields correctly!",
                                    ),
                                  ),
                                );

                                return;
                              }

                              final newBurger = Burger(
                                id: burger.id,
                                name: name,
                                ingredients: ingredients,
                                price: price,
                              );

                              repo.update(newBurger);

                              nameController.clear();
                              ingredientsController.clear();
                              priceController.clear();

                              Navigator.pop(context);
                            },
                            confirmText: "Update",
                          ),
                        );
                      },
                      icon: Icon(MaterialIcons.edit),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        floatingActionButton: AddButton(
          modelName: "Burger",
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: ingredientsController,
                decoration: InputDecoration(labelText: "Ingredients"),
              ),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Price"),
              ),
            ],
          ),
          onCreate: () {
            final name = nameController.text.trim();
            final ingredients = ingredientsController.text.trim();
            final price = double.tryParse(priceController.text.trim()) ?? 0.0;

            if (name.isEmpty || ingredients.isEmpty || price <= 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Fill in all fields correctly!")),
              );

              return;
            }

            final newBurger = Burger(
              name: name,
              ingredients: ingredients,
              price: price,
            );

            repo.create(newBurger);

            nameController.clear();
            ingredientsController.clear();
            priceController.clear();

            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

String formatReal(double valor) {
  return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(valor);
}
