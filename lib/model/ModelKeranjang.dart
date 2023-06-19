class ModelKeranjang {
  int? id;
  int? customerId;
  int? pid;
  String? name;
  int? price;
  int? quantity;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? productPrice;

  ModelKeranjang(
      {this.id,
      this.customerId,
      this.pid,
      this.name,
      this.price,
      this.quantity,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.productPrice});

  ModelKeranjang.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    pid = json['pid'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productPrice = json['product_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['pid'] = this.pid;
    data['name'] = this.name;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['product_price'] = this.productPrice;
    return data;
  }

  void setId(int? id) {
    this.id = id;
  }

  void setCustomerId(int? customerId) {
    this.customerId = customerId;
  }

  void setPid(int? pid) {
    this.pid = pid;
  }

  void setName(String? name) {
    this.name = name;
  }

  void setPrice(int? price) {
    this.price = price;
  }

  void setQuantity(int? quantity) {
    this.quantity = quantity;
  }

  void setImage(String? image) {
    this.image = image;
  }

  void setCreatedAt(String? createdAt) {
    this.createdAt = createdAt;
  }

  void setUpdatedAt(String? updatedAt) {
    this.updatedAt = updatedAt;
  }

  void setProductPrice(String? productPrice) {
    this.productPrice = productPrice;
  }
}
