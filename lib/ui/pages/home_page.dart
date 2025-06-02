import 'package:app_de_pedidos_de_hamburguer/ui/widgets/current_color_scheme.dart';
import 'package:app_de_pedidos_de_hamburguer/ui/widgets/standard_button.dart';
import 'package:app_de_pedidos_de_hamburguer/ui/pages/burguers_page.dart';
import 'package:app_de_pedidos_de_hamburguer/ui/pages/orders_page.dart';
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
                      Consumer<CurrentColorScheme>(
                        builder:
                            (
                              BuildContext context,
                              CurrentColorScheme value,
                              Widget? child,
                            ) {
                              if (value.current.brightness ==
                                  Brightness.light) {
                                return Image.asset(
                                  "lib/ui/images/burguer_logo.png",
                                  scale: 1.75,
                                );
                              } else {
                                return Image.asset(
                                  "lib/ui/images/burguer_logo_yellow.png",
                                  scale: 1.75,
                                );
                              }
                            },
                      ),

                      Column(
                        children: [
                          Text("BURGUER\nORDERS", style: textTheme.titleLarge),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              StandardButton(
                iconData: MaterialCommunityIcons.hamburger,
                text: "Burguers",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => BurguersPage(),
                    ),
                  );
                },
              ),
              StandardButton(
                iconData: MaterialIcons.view_list,
                text: "Orders",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => OrdersPage(),
                    ),
                  );
                },
              ),
              StandardButton(
                iconData: MaterialCommunityIcons.theme_light_dark,
                text: "Theme",
                onPressed: () {
                  Provider.of<CurrentColorScheme>(
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
