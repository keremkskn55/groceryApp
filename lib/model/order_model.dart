class Order {
  final String name;
  final String surname;
  final String note;
  final String address;
  final String idNum;
  final bool isApproval;
  final bool isDelivered;
  final Map orderOfCustomer;
  Order({
    required this.name,
    required this.surname,
    required this.note,
    required this.address,
    required this.orderOfCustomer,
    required this.idNum,
    required this.isApproval,
    required this.isDelivered,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surname': surname,
      'note': note,
      'address': address,
      'orderOfCustomer': orderOfCustomer,
      'idNum': idNum,
      'isApproval': isApproval,
      'isDelivered': isDelivered
    };
  }

  factory Order.fromMap(Map map) {
    return Order(
      name: map['name'],
      surname: map['surname'],
      note: map['note'],
      address: map['address'],
      orderOfCustomer: map['orderOfCustomer'],
      idNum: map['idNum'],
      isApproval: map['isApproval'],
      isDelivered: map['isDelivered'],
    );
  }
}
