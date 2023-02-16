class Filter {
  final int? minPrice;
  final int? maxPrice;
  final String? searchText;
  Filter({this.minPrice, this.maxPrice,this.searchText});

  Map<String, String> toJson() {
    Map<String, String> temp = {
        'title':searchText.toString(),
        'price_min': minPrice.toString(),
        'price_max': maxPrice.toString()
    };
    temp.removeWhere((key, value) => value == '' || value == 'null');
    return temp;
  }
}
