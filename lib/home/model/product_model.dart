import 'package:get/get.dart';

class ProductModel {
  final int id;
  final String title;
  final List<double> prices;
  final double rate;
  final List<String> sizes;
  late int counter;
  final String image;
  late bool isFavorite;
  final int categoryId;
  final String soldCounter;
  final String description;

  final RxString selectedSize;
  final RxDouble selectedPrice;

  ProductModel({
    required this.id,
    required this.title,
    required this.prices,
    required this.rate,
    required this.sizes,
    required this.counter,
    required this.image,
    required this.categoryId,
    required this.soldCounter,
    required this.description,
    String? initialsizes,
  })  : selectedSize = (initialsizes ?? sizes[0]).obs,
        selectedPrice = (prices.isNotEmpty ? prices[0] : 0.0).obs;

  void selectSize(String size) {
    selectedSize.value = size;
    final index = sizes.indexOf(size);
    if (index != -1 && index < prices.length) {
      selectedPrice.value = prices[index];
    } else {
      selectedPrice.value = 0.0;
    }
  }

  double getPriceBySize(String size) {
    final index = sizes.indexOf(size);
    return index != -1 ? prices[index] : 0.0;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'prices': prices,
      'rate': rate,
      'sizes': sizes,
      'counter': counter,
      'image': image,
      'categoryId': categoryId,
      'soldCounter': soldCounter,
      'description': description,
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      categoryId: json['categoryId'],
      counter: json['counter'],
      description: json['description'],
      id: json['id'],
      image: json['image'],
      prices:
          (json['prices'] as List).map((e) => (e as num).toDouble()).toList(),
      rate: json['rate'],
      sizes: List<String>.from(json['sizes']),
      soldCounter: json['soldCounter'],
      title: json['title'],
    );
  }
}
/*
final List<ProductModel> products = [
  ProductModel(
      id: 1,
      title: 'Black Coffee',
      prices: [1, 1.25, 1.50],
      rate: 3.5,
      sizes: ['S', 'M', 'L'],
      counter: 1,
      image: 'asset/images/black_coffee.png',
      categoryId: 1,
      soldCounter: '10',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'),
  ProductModel(
      id: 2,
      title: 'Iced Latte Coffee',
      prices: [1.25, 1.50, 1.75],
      rate: 4.0,
      sizes: ['S', 'M', 'L'],
      counter: 1,
      image: 'asset/images/iced_latte_coffee.png',
      categoryId: 1,
      soldCounter: '15',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'),
  ProductModel(
    id: 3,
    title: 'Iced Mocha',
    prices: [1.25, 1.50, 1.75],
    rate: 4.5,
    sizes: ['S', 'M', 'L'],
    counter: 1,
    image: 'asset/images/iced_mocha.png',
    categoryId: 1,
    soldCounter: '30',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ),
  ProductModel(
    id: 4,
    title: 'Ameriacano',
    prices: [1, 1.25, 1.50],
    rate: 3.5,
    sizes: ['S', 'M', 'L'],
    counter: 1,
    image: 'asset/images/ameriacano_coffee.png',
    categoryId: 1,
    soldCounter: '25',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ),
  ProductModel(
    id: 5,
    title: 'Green Milk Tea',
    prices: [1, 1.25, 1.50],
    rate: 4.5,
    sizes: ['S', 'M', 'L'],
    counter: 1,
    image: 'asset/images/green_milk_tea.jpg',
    categoryId: 2,
    soldCounter: '20',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ),
  ProductModel(
    id: 6,
    title: 'Lemmon Tea',
    prices: [0.75, 1, 1.25],
    rate: 3.5,
    sizes: ['S', 'M', 'L'],
    counter: 1,
    image: 'asset/images/lemon_tea.jpg',
    categoryId: 2,
    soldCounter: '10',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ),
  ProductModel(
    id: 7,
    title: 'Mint Tea',
    prices: [1, 1.25, 1.50],
    rate: 3.0,
    sizes: ['S', 'M', 'L'],
    counter: 1,
    image: 'asset/images/mint_tea.jpg',
    categoryId: 2,
    soldCounter: '15',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ),
  ProductModel(
    id: 8,
    title: 'Butterfly Tea',
    prices: [1.25, 1.50, 1.75],
    rate: 4.0,
    sizes: ['S', 'M', 'L'],
    counter: 1,
    image: 'asset/images/butterfly_tea.jpg',
    categoryId: 2,
    soldCounter: '30',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ),
  ProductModel(
    id: 9,
    title: 'Strawberry',
    prices: [1.25, 1.50, 1.75],
    rate: 4.5,
    sizes: ['S', 'M', 'L'],
    counter: 1,
    image: 'asset/images/stawberry_smoothie.jpg',
    categoryId: 3,
    soldCounter: '10',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ),
  ProductModel(
    id: 10,
    title: 'Kiwi Apple',
    prices: [1.25, 1.50, 1.75],
    rate: 3.5,
    sizes: ['S', 'M', 'L'],
    counter: 1,
    image: 'asset/images/kiwi_apple_smoothies.jpg',
    categoryId: 3,
    soldCounter: '20',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ),
  ProductModel(
    id: 11,
    title: 'Watermelon',
    prices: [1.25, 1.50, 1.75],
    rate: 3.5,
    sizes: ['S', 'M', 'L'],
    counter: 1,
    image: 'asset/images/watermelon_smoothie.jpg',
    categoryId: 3,
    soldCounter: '5',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ),
  ProductModel(
    id: 12,
    title: 'Banana',
    prices: [1.25, 1.50, 1.75],
    rate: 3.5,
    sizes: ['S', 'M', 'L'],
    counter: 1,
    image: 'asset/images/banana_smoothie.jpg',
    categoryId: 3,
    soldCounter: '10',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ),
  ProductModel(
    id: 13,
    title: 'Orange Juice',
    prices: [1, 1.25, 1.50],
    rate: 3.5,
    sizes: ['S', 'M', 'L'],
    counter: 1,
    image: 'asset/images/orange_juice.jpg',
    categoryId: 4,
    soldCounter: '20',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ),
  ProductModel(
    id: 14,
    title: 'Apple Juice',
    prices: [1, 1.25, 1.50],
    rate: 3.5,
    sizes: ['S', 'M', 'L'],
    counter: 1,
    image: 'asset/images/apple_juice.png',
    categoryId: 4,
    soldCounter: '10',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ),
  ProductModel(
    id: 15,
    title: 'Pineapple Juice',
    prices: [1, 1.25, 1.50],
    rate: 3.5,
    sizes: ['S', 'M', 'L'],
    counter: 1,
    image: 'asset/images/pineapple_juice.jpg',
    categoryId: 4,
    soldCounter: '10',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ),
  ProductModel(
    id: 16,
    title: 'Lemon Juice',
    prices: [1, 1.25, 1.50],
    rate: 3.5,
    sizes: ['S', 'M', 'L'],
    counter: 1,
    image: 'asset/images/lemon_juice.jpg',
    categoryId: 4,
    soldCounter: '10',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ),
  ProductModel(
    id: 17,
    title: 'Coca Cola',
    prices: [0.75, 1, 1.25],
    rate: 3.5,
    sizes: ['S', 'M', 'L'],
    counter: 1,
    image: 'asset/images/Coke.jpg',
    categoryId: 5,
    soldCounter: '30',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ),
  ProductModel(
    id: 18,
    title: 'Pepsi',
    prices: [0.75, 1, 1.25],
    rate: 3.5,
    sizes: ['S', 'M', 'L'],
    counter: 1,
    image: 'asset/images/pepsi.png',
    categoryId: 5,
    soldCounter: '15',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ),
  ProductModel(
    id: 19,
    title: 'Fanta Orange',
    prices: [0.75, 1, 1.25],
    rate: 3.5,
    sizes: ['S', 'M', 'L'],
    counter: 1,
    image: 'asset/images/orange_fanta.jpg',
    categoryId: 5,
    soldCounter: '10',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ),
  ProductModel(
    id: 20,
    title: 'Sprite',
    prices: [0.75, 1, 1.25],
    rate: 3.5,
    sizes: ['S', 'M', 'L'],
    counter: 1,
    image: 'asset/images/sprite.jpg',
    categoryId: 5,
    soldCounter: '15',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ),
].obs;
*/