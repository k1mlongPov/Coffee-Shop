class CategoryModel {
  final int id;
  final String name;
  final String imageIcon;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageIcon,
  });
}

final List<CategoryModel> listCategory = [
  CategoryModel(
    id: 1,
    name: 'Coffee',
    imageIcon: 'asset/icons/coffee-icon.png',
  ),
  CategoryModel(
    id: 2,
    name: 'Tea & Milk',
    imageIcon: 'asset/icons/iced-tea-icon.png',
  ),
  CategoryModel(
    id: 3,
    name: 'Smoothies',
    imageIcon: 'asset/icons/avocado-icon.png',
  ),
  CategoryModel(
    id: 4,
    name: 'Juices',
    imageIcon: 'asset/icons/juice-icon.png',
  ),
  CategoryModel(
    id: 5,
    name: 'Soft Drinks',
    imageIcon: 'asset/icons/coke-icon.png',
  ),
];
