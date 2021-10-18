class Product {
  final String name;
  final String type;
  final double price;
  final String photoUrl;
  final int colorNum;
  final int idNum;
  Product(
      {required this.name,
      required this.type,
      required this.price,
      required this.photoUrl,
      required this.colorNum,
      required this.idNum});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'price': price,
      'photoUrl': photoUrl,
      'colorNum': colorNum,
      'idNum': idNum,
    };
  }

  factory Product.fromMap(Map map) {
    return Product(
      name: map['name'],
      type: map['type'],
      price: map['price'],
      photoUrl: map['photoUrl'],
      colorNum: map['colorNum'],
      idNum: map['idNum'],
    );
  }
}
