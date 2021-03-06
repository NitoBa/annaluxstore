import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'components/appbar/appbar_widget.dart';
import 'components/gridview_items/gridview_items_widget.dart';
import 'components/list_categories/list_categories_widget.dart';
import 'home_content_controller.dart';

class HomeContentPage extends StatefulWidget {
  final String title;
  const HomeContentPage({Key key, this.title = "HomeContent"})
      : super(key: key);

  @override
  _HomeContentPageState createState() => _HomeContentPageState();
}

class _HomeContentPageState
    extends ModularState<HomeContentPage, HomeContentController> {
  //use 'controller' variable to access controller
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        onPress: () {
          Modular.to.pushNamed("/buy");
        },
      ),
      body: Container(
        //color: Colors.green,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Categorias",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListCategories(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Últimos Itens",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 32),
            GridViewItems()
          ],
        ),
      ),
    );
  }
}
