class ModelKeranjang {
  int? id;
  String? customerId;
  String? pid;
  String? name;
  String? price;
  String? quantity;
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

  int? getId() {
    return id;
  }

  void setId(int? id) {
    this.id = id;
  }

  String? getCustomerId() {
    return customerId;
  }

  void setCustomerId(String? customerId) {
    this.customerId = customerId;
  }

  String? getPid() {
    return pid;
  }

  void setPid(String? pid) {
    this.pid = pid;
  }

  String? getName() {
    return name;
  }

  void setName(String? name) {
    this.name = name;
  }

  String? getPrice() {
    return price;
  }

  void setPrice(String? price) {
    this.price = price;
  }

  String? getQuantity() {
    return quantity;
  }

  void setQuantity(String? quantity) {
    this.quantity = quantity;
  }

  String? getImage() {
    return image;
  }

  void setImage(String? image) {
    this.image = image;
  }

  String? getCreatedAt() {
    return createdAt;
  }

  void setCreatedAt(String? createdAt) {
    this.createdAt = createdAt;
  }

  String? getUpdatedAt() {
    return updatedAt;
  }

  void setUpdatedAt(String? updatedAt) {
    this.updatedAt = updatedAt;
  }

  String? getProductPrice() {
    return productPrice;
  }

  void setProductPrice(String? productPrice) {
    this.productPrice = productPrice;
  }
}
