class Product {
  final String image;
  final String name;
  final String price;
  final bool isPurchased;

  Product(
      {required this.image,
      required this.name,
      required this.price,
      required this.isPurchased});
}

//EN ISPURCHASED HABRA QUE HACER LA COMPROBACION LLAMANDO AL BACKEND
List<Product> sampleSkinsProducts = [
  Product(
      image: 'lib/images/Skin_rosa.png',
      name: 'ROSA',
      price: '80 puntos',
      isPurchased: true),
  Product(
      image: 'lib/images/Skin_dorada.png',
      name: 'DORADO',
      price: '20 puntos',
      isPurchased: false),
  // Agrega más productos aquí
];

List<Product> sampleTablerosProducts = [
  Product(
      image: 'lib/images/Skin_rosa.png',
      name: 'ROSA',
      price: '80 puntos',
      isPurchased: true),
  // Agrega más productos aquí
];

List<Product> sampleDadosProducts = [
  Product(
      image: 'lib/images/Skin_dorada.png',
      name: 'ROSA',
      price: '20 puntos',
      isPurchased: true),
  // Agrega más productos aquí
];
