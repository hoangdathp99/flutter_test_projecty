class Filter {
  final int? minPrice;
  final int? maxPrice;

  Filter({this.minPrice, this.maxPrice});

  Map<String, String> toJson() =>
      {'price_min': minPrice!.toString(), 'price_max': maxPrice!.toString()};
}
