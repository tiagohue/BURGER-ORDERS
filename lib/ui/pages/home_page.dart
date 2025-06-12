import 'package:burger_orders/ui/pages/burgers_page.dart';
import 'package:burger_orders/providers/color_scheme_view_provider.dart';
import 'package:burger_orders/ui/pages/chart_page.dart';
import 'package:burger_orders/ui/widgets/standard_button.dart';
import 'package:burger_orders/ui/pages/order/orders_page.dart';
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
                      Consumer<ColorSchemeProvider>(
                        builder:
                            (
                              BuildContext context,
                              ColorSchemeProvider value,
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
                iconData: MaterialCommunityIcons.chart_bar,
                text: "Chart",
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => ChartPage(),
                  ),
                ),
              ),
              StandardButton(
                iconData: MaterialCommunityIcons.theme_light_dark,
                text: "Theme",
                onPressed: () {
                  Provider.of<ColorSchemeProvider>(
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
