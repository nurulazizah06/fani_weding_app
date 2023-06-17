class ProductResponse {
  int? id;
  String? name;
  String? category;
  String? keterangan;
  String? price;
  String? image;
  Null? createdAt;
  Null? updatedAt;

  ProductResponse(
      {this.id,
      this.name,
      this.category,
      this.keterangan,
      this.price,
      this.image,
      this.createdAt,
      this.updatedAt});

  ProductResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    keterangan = json['keterangan'];
    price = json['price'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category'] = this.category;
    data['keterangan'] = this.keterangan;
    data['price'] = this.price;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
