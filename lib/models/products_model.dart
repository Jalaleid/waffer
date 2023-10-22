class ProductsModel {
  String? message;
  List<Products>? products;

  ProductsModel({this.message, this.products});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? "";
    if (json['Products'] != null) {
      products = <Products>[];
      json['Products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.products != null) {
      data['Products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? itemGUID;
  String? itemCode;
  String? itemName;
  String? barCode;
  String? m1;
  String? m2;
  String? m3;
  String? supplier;
  bool? local;
  String? imagePath;
  String? createdAt;
  String? updatedAt;

  Products(
      {this.itemGUID,
      this.itemCode,
      this.itemName,
      this.barCode,
      this.m1,
      this.m2,
      this.m3,
      this.supplier,
      this.local,
      this.imagePath,
      this.createdAt,
      this.updatedAt});

  Products.fromJson(Map<String, dynamic> json) {
    itemGUID = json['itemGUID'] ?? "";
    itemCode = json['itemCode'] ?? "";
    itemName = json['itemName'] ?? "";
    barCode = json['BarCode'] ?? "";
    m1 = json['m1'] ?? "";
    m2 = json['m2'] ?? "";
    m3 = json['m3'] ?? "";
    supplier = json['supplier'] ?? "";
    local = json['local'] ?? "";
    imagePath = json['imagePath'] ?? "";
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemGUID'] = this.itemGUID;
    data['itemCode'] = this.itemCode;
    data['itemName'] = this.itemName;
    data['BarCode'] = this.barCode;
    data['m1'] = this.m1;
    data['m2'] = this.m2;
    data['m3'] = this.m3;
    data['supplier'] = this.supplier;
    data['local'] = this.local;
    data['imagePath'] = this.imagePath;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
