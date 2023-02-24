class ExpenseModel {
  int? id;
  String name;
  String date;
  double price;
  int categoryId;

  ExpenseModel({
    this.id,
    required this.name,
    required this.date,
    required this.price,
    required this.categoryId,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'],
      name: json['name'],
      date: json['date'],
      price: json['price'],
      categoryId: json['category_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'price': price,
      'category_id': categoryId,
    };
  }
}
