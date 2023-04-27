import 'package:flutter/material.dart';
import 'package:oca_app/components/products.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Shop extends StatelessWidget {
  final String user_email;
  const Shop({super.key, required this.user_email});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          tabBarTheme: TabBarTheme(
              labelColor: const Color.fromARGB(255, 28, 100,
                  116), // Cambia este color al que prefieras para el texto seleccionado
              unselectedLabelColor: Colors
                  .white, // Cambia este color al que prefieras para el texto no seleccionado
              indicator: BoxDecoration(
                color: const Color.fromARGB(255, 195, 250, 254),
                borderRadius: BorderRadius.circular(50),
              ))),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 195, 250, 254),
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Tienda'),
            backgroundColor: const Color.fromARGB(255, 28, 100, 116),
            bottom: PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: Material(
                color: const Color.fromARGB(255, 28, 100, 116), //<-- SEE HERE
                child: _tabBar,
              ),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow),
                    SizedBox(width: 4),
                    Text(
                      '1234', // Reemplaza esto con la cantidad de monedas del usuario
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: TabBarView(
            children: [
              SkinsTab(products: sampleSkinsProducts),
              TablerosTab(products: sampleTablerosProducts),
              DadosTab(products: sampleDadosProducts)
            ],
          ),
        ),
      ),
    );
  }
}

TabBar get _tabBar => const TabBar(
      tabs: [
        Tab(text: 'Skins'),
        Tab(text: 'Tableros'),
        Tab(text: 'Dados'),
      ],
    );

class SkinsTab extends StatelessWidget {
  final List<Product> products;

  const SkinsTab({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          Product product = products[index];
          return ProductCard(
            image: product.image,
            productName: product.name,
            productPrice: product.price,
            productisPurchased: product.isPurchased,
          );
        },
        staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
    );
  }
}

class TablerosTab extends StatelessWidget {
  final List<Product> products;

  const TablerosTab({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          Product product = products[index];
          return ProductCard(
            image: product.image,
            productName: product.name,
            productPrice: product.price,
            productisPurchased: product.isPurchased,
          );
        },
        staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
    );
  }
}

class DadosTab extends StatelessWidget {
  final List<Product> products;

  const DadosTab({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          Product product = products[index];
          return ProductCard(
            image: product.image,
            productName: product.name,
            productPrice: product.price,
            productisPurchased: product.isPurchased,
          );
        },
        staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String image;
  final String productName;
  final String productPrice;
  final bool productisPurchased;

  const ProductCard({
    super.key,
    required this.image,
    required this.productName,
    required this.productPrice,
    required this.productisPurchased,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 195, 250, 254),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 150,
            child: Image.asset(image, width: 200, height: 200),
          ),
          Text(productName),
          Text(productPrice),
          if (!productisPurchased) // Muestra el botón solo si el producto no ha sido comprado
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => const Color.fromARGB(255, 87, 177, 198))),
              onPressed: () {},
              child: const Text('Comprar'),
            ),
          if (productisPurchased)
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => const Color.fromARGB(255, 115, 130, 134))),
              onPressed: null,
              child: const Text('Comprado'),
            )
        ],
      ),
    );
  }
}
