class ModelRiwayatOrder {
  int? id;
  String? customerId;
  String? name;
  String? number;
  String? email;
  String? method;
  String? address;
  String? totalProducts;
  String? totalPrice;
  String? orderTime;
  String? eventTime;
  String? orderStatus;
  String? proofPayment;
  String? paymentStatus;
  String? createdAt;
  String? updatedAt;

  ModelRiwayatOrder(
      {this.id,
      this.customerId,
      this.name,
      this.number,
      this.email,
      this.method,
      this.address,
      this.totalProducts,
      this.totalPrice,
      this.orderTime,
      this.eventTime,
      this.orderStatus,
      this.proofPayment,
      this.paymentStatus,
      this.createdAt,
      this.updatedAt});

  ModelRiwayatOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    name = json['name'];
    number = json['number'];
    email = json['email'];
    method = json['method'];
    address = json['address'];
    totalProducts = json['total_products'];
    totalPrice = json['total_price'];
    orderTime = json['order_time'];
    eventTime = json['event_time'];
    orderStatus = json['order_status'];
    proofPayment = json['proof_payment'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['name'] = this.name;
    data['number'] = this.number;
    data['email'] = this.email;
    data['method'] = this.method;
    data['address'] = this.address;
    data['total_products'] = this.totalProducts;
    data['total_price'] = this.totalPrice;
    data['order_time'] = this.orderTime;
    data['event_time'] = this.eventTime;
    data['order_status'] = this.orderStatus;
    data['proof_payment'] = this.proofPayment;
    data['payment_status'] = this.paymentStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
