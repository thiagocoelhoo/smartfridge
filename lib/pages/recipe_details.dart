import 'package:flutter/material.dart';
import 'package:smartfridge/widgets/carousel.dart';

class RecipeDetailsPage extends StatefulWidget {
  const RecipeDetailsPage({super.key});

  @override
  State<RecipeDetailsPage> createState() => _RecipeDetailsPage();
}

class _RecipeDetailsPage extends State<RecipeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        centerTitle: true,
        title: Text("Recipes"),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("Macarronada com ervilhas", style: TextStyle(fontSize: 26)),
            SizedBox(height: 12),
            Carousel(
              images: [
                Image.asset("assets/images/macarronada.jpg"),
                Image.asset("assets/images/bife acebolado.jpg"),
                Image.asset("assets/images/pao de queijo.jpg"),
                Image.asset("assets/images/lasanha.jpg"),
              ],
              height: 400,
            ),
            SizedBox(height: 20),
            Text("Ingredientes", style: TextStyle(fontSize: 20)),
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Container(
                  color: Theme.of(context).colorScheme.surfaceBright,
                  width: double.infinity,
                  height: 400,
                  child: ListView(
                    children: [
                      ListTile(title: Text("Cebola")),
                      ListTile(title: Text("Molho de tomate")),
                      ListTile(title: Text("Macarrão para espaguete")),
                      ListTile(title: Text("Ervilhas")),
                      ListTile(title: Text("Água")),
                      ListTile(title: Text("Sal")),
                    ],
                  )),
            ),
            SizedBox(height: 20),
            Text("Modo de preparo", style: TextStyle(fontSize: 20)),
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Container(
                  color: Theme.of(context).colorScheme.surfaceBright,
                  width: double.infinity,
                  height: 400,
                  child: ListView(
                    children: [
                      ListTile(title: Text("1 - Adicionar a água e macarrão na panela")),
                      ListTile(title: Text("2 - Fazer o resto da receita")),
                      ListTile(title: Text("3 - Servir")),
                      ListTile(title: Text("4 - :)")),
                    ],
                  )),
            ),
            SizedBox(height: 20),
            MaterialButton(
                color: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                height: 60,
                minWidth: double.infinity,
                onPressed: () {},
                child: Text(
                  "Iniciar receita",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ))
          ],
        ));
  }
}
