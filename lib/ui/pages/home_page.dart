import 'package:burger_orders/ui/pages/burgers_page.dart';
import 'package:burger_orders/viewmodels/color_scheme_view_model.dart';
import 'package:burger_orders/ui/widgets/standard_button.dart';
import 'package:burger_orders/ui/pages/orders_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 2),
              FittedBox(
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<ColorSchemeViewModel>(
                        builder:
                            (
                              BuildContext context,
                              ColorSchemeViewModel value,
                              Widget? child,
                            ) {
                              if (value.current.brightness ==
                                  Brightness.light) {
                                return Image.asset(
                                  "lib/ui/images/burger_logo.png",
                                  scale: 1.75,
                                );
                              } else {
                                return Image.asset(
                                  "lib/ui/images/burger_logo_yellow.png",
                                  scale: 1.75,
                                );
                              }
                            },
                      ),

                      Column(
                        children: [
                          Text("BURGER\nORDERS", style: textTheme.titleLarge),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              StandardButton(
                iconData: MaterialCommunityIcons.hamburger,
                text: "Burgers",
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => BurgersPage(),
                  ),
                ),
              ),
              StandardButton(
                iconData: MaterialCommunityIcons.text_box_outline,
                text: "Orders",
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => OrdersPage(),
                  ),
                ),
              ),
              StandardButton(
                iconData: MaterialCommunityIcons.theme_light_dark,
                text: "Theme",
                onPressed: () {
                  Provider.of<ColorSchemeViewModel>(
                    context,
                    listen: false,
                  ).change();
                },
              ),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
