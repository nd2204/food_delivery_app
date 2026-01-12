class FoodCategory {
  final String title;
  final double startingPrice;
  final String imageUrl; // can be asset or network

  const FoodCategory({
    required this.title,
    required this.startingPrice,
    required this.imageUrl,
  });
}
