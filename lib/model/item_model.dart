class ItemModel{
  int id;
  String name;
  bool isAdd;
  int price;
  ItemModel(this.id, this.name, this.isAdd, this.price);

  @override
  String toString() {
    return 'ItemModel{id: $id, name: $name, isAdd: $isAdd, price: $price}';
  }
}



List<ItemModel> items = [
  ItemModel(1, 'Chicken Fries', false, 10),
  ItemModel(2, 'Bubble Tea', false, 12),
  ItemModel(3, 'Potatoes', false, 14),
  ItemModel(4, 'Cole Slaw', false, 8),
  ItemModel(5, 'Mac and Cheese', false, 5),
  ItemModel(6, 'Biscuit', false, 7),
  ItemModel(7, 'Pot Pie', false, 9),
  ItemModel(8, 'Extra Crispy Tenders', false, 15),
  ItemModel(9, 'Sandwich', false, 12),
  ItemModel(10, 'Cookies', false, 16),
  ItemModel(11, 'Popcorn', false, 6),
  ItemModel(12, 'Coke', false, 3),
  ItemModel(13, 'Pepsi', false, 4),
];