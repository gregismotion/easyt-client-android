import 'package:auto_route/auto_route.dart';
import 'package:easyt/routes/router.gr.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      appBarBuilder: (_, tabsRouter) => AppBar(
        title: const Text("EasyT"),
        leading: const AutoBackButton(),
      ),
      routes: const [CollectionsRouter(), NamedTypesRouter()],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.book), label: "Collections"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.ballot), label: "Named types")
            ]);
      },
    );
  }
}
