class FetchOrdersModel {
  FetchOrdersModel({
    required this.message,
    required this.status,
    required this.data,
  });

  final String? message;
  final String? status;
  final Data? data;

  factory FetchOrdersModel.fromJson(Map<String, dynamic> json) {
    return FetchOrdersModel(
      message: json["message"],
      status: json["status"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    required this.content,
    required this.pageable,
    required this.last,
    required this.totalElements,
    required this.totalPages,
    required this.size,
    required this.number,
    required this.sort,
    required this.first,
    required this.numberOfElements,
    required this.empty,
  });

  final List<Content> content;
  final Pageable? pageable;
  final bool? last;
  final int? totalElements;
  final int? totalPages;
  final int? size;
  final int? number;
  final List<Sort> sort;
  final bool? first;
  final int? numberOfElements;
  final bool? empty;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      content: json["content"] == null
          ? []
          : List<Content>.from(
              json["content"]!.map((x) => Content.fromJson(x))),
      pageable:
          json["pageable"] == null ? null : Pageable.fromJson(json["pageable"]),
      last: json["last"],
      totalElements: json["totalElements"],
      totalPages: json["totalPages"],
      size: json["size"],
      number: json["number"],
      sort: json["sort"] == null
          ? []
          : List<Sort>.from(json["sort"]!.map((x) => Sort.fromJson(x))),
      first: json["first"],
      numberOfElements: json["numberOfElements"],
      empty: json["empty"],
    );
  }

  Map<String, dynamic> toJson() => {
        "content": content.map((x) => x.toJson()).toList(),
        "pageable": pageable?.toJson(),
        "last": last,
        "totalElements": totalElements,
        "totalPages": totalPages,
        "size": size,
        "number": number,
        "sort": sort.map((x) => x.toJson()).toList(),
        "first": first,
        "numberOfElements": numberOfElements,
        "empty": empty,
      };
}

class Content {
  Content({
    required this.id,
    required this.orderNumber,
    required this.userId,
    required this.username,
    required this.mobileNumber,
    required this.userAddress,
    required this.businessId,
    required this.businessName,
    required this.shippingAddressId,
    required this.notes,
    required this.businessAddress,
    required this.totalAmount,
    required this.totalTaxAmount,
    required this.taxInclusive,
    required this.paymentStatus,
    required this.paymentTransactionId,
    required this.orderStatus,
    required this.createdDate,
    required this.updatedDate,
    required this.deliveryPartnerId,
    required this.orderItems,
  });

  final int? id;
  final String? orderNumber;
  final int? userId;
  final String? username;
  final String? mobileNumber;
  final UserAddress? userAddress;
  final int? businessId;
  final String? businessName;
  final int? shippingAddressId;
  final dynamic notes;
  final BusinessAddress? businessAddress;
  final double? totalAmount;
  final double? totalTaxAmount;
  final bool? taxInclusive;
  final String? paymentStatus;
  final String? paymentTransactionId;
  final String? orderStatus;
  final DateTime? createdDate;
  final DateTime? updatedDate;
  final String? deliveryPartnerId;
  final List<OrderItem> orderItems;

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      id: json["id"],
      orderNumber: json["orderNumber"],
      userId: json["userId"],
      username: json["username"],
      mobileNumber: json["mobileNumber"],
      userAddress: json["userAddress"] == null
          ? null
          : UserAddress.fromJson(json["userAddress"]),
      businessId: json["businessId"],
      businessName: json["businessName"],
      shippingAddressId: json["shippingAddressId"],
      notes: json["notes"],
      businessAddress: json["businessAddress"] == null
          ? null
          : BusinessAddress.fromJson(json["businessAddress"]),
      totalAmount: json["totalAmount"],
      totalTaxAmount: json["totalTaxAmount"],
      taxInclusive: json["taxInclusive"],
      paymentStatus: json["paymentStatus"],
      paymentTransactionId: json["paymentTransactionId"],
      orderStatus: json["orderStatus"],
      createdDate: DateTime.tryParse(json["createdDate"] ?? ""),
      updatedDate: DateTime.tryParse(json["updatedDate"] ?? ""),
      deliveryPartnerId: json["deliveryPartnerId"],
      orderItems: json["orderItems"] == null
          ? []
          : List<OrderItem>.from(
              json["orderItems"]!.map((x) => OrderItem.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderNumber": orderNumber,
        "userId": userId,
        "username": username,
        "mobileNumber": mobileNumber,
        "userAddress": userAddress?.toJson(),
        "businessId": businessId,
        "businessName": businessName,
        "shippingAddressId": shippingAddressId,
        "notes": notes,
        "businessAddress": businessAddress?.toJson(),
        "totalAmount": totalAmount,
        "totalTaxAmount": totalTaxAmount,
        "taxInclusive": taxInclusive,
        "paymentStatus": paymentStatus,
        "paymentTransactionId": paymentTransactionId,
        "orderStatus": orderStatus,
        "createdDate": createdDate?.toIso8601String(),
        "updatedDate": updatedDate?.toIso8601String(),
        "deliveryPartnerId": deliveryPartnerId,
        "orderItems": orderItems.map((x) => x.toJson()).toList(),
      };
}

class BusinessAddress {
  BusinessAddress({
    required this.id,
    required this.addressLine1,
    required this.city,
    required this.state,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.postalCode,
  });

  final int? id;
  final String? addressLine1;
  final String? city;
  final String? state;
  final String? country;
  final double? latitude;
  final double? longitude;
  final String? postalCode;

  factory BusinessAddress.fromJson(Map<String, dynamic> json) {
    return BusinessAddress(
      id: json["id"],
      addressLine1: json["addressLine1"],
      city: json["city"],
      state: json["state"],
      country: json["country"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      postalCode: json["postalCode"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "addressLine1": addressLine1,
        "city": city,
        "state": state,
        "country": country,
        "latitude": latitude,
        "longitude": longitude,
        "postalCode": postalCode,
      };
}

class OrderItem {
  OrderItem({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.entryNumber,
    required this.productName,
    required this.media,
    required this.taxAmount,
    required this.taxPercentage,
    required this.totalAmount,
    required this.taxIgnored,
  });

  final int? id;
  final int? productId;
  final int? quantity;
  final num? price;
  final int? entryNumber;
  final String? productName;
  final dynamic media;
  final num? taxAmount;
  final num? taxPercentage;
  final num? totalAmount;
  final bool? taxIgnored;

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json["id"],
      productId: json["productId"],
      quantity: json["quantity"],
      price: json["price"],
      entryNumber: json["entryNumber"],
      productName: json["productName"],
      media: json["media"],
      taxAmount: json["taxAmount"],
      taxPercentage: json["taxPercentage"],
      totalAmount: json["totalAmount"],
      taxIgnored: json["taxIgnored"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "quantity": quantity,
        "price": price,
        "entryNumber": entryNumber,
        "productName": productName,
        "media": media,
        "taxAmount": taxAmount,
        "taxPercentage": taxPercentage,
        "totalAmount": totalAmount,
        "taxIgnored": taxIgnored,
      };
}

class UserAddress {
  UserAddress({
    required this.id,
    required this.addressLine1,
    required this.addressLine2,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.postalCode,
    required this.userId,
    required this.isDefault,
  });

  final int? id;
  final String? addressLine1;
  final String? addressLine2;
  final String? street;
  final String? city;
  final String? state;
  final String? country;
  final double? latitude;
  final double? longitude;
  final String? postalCode;
  final int? userId;
  final bool? isDefault;

  factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(
      id: json["id"],
      addressLine1: json["addressLine1"],
      addressLine2: json["addressLine2"],
      street: json["street"],
      city: json["city"],
      state: json["state"],
      country: json["country"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      postalCode: json["postalCode"],
      userId: json["userId"],
      isDefault: json["isDefault"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "street": street,
        "city": city,
        "state": state,
        "country": country,
        "latitude": latitude,
        "longitude": longitude,
        "postalCode": postalCode,
        "userId": userId,
        "isDefault": isDefault,
      };
}

class Pageable {
  Pageable({
    required this.sort,
    required this.pageNumber,
    required this.pageSize,
    required this.offset,
    required this.paged,
    required this.unpaged,
  });

  final List<Sort> sort;
  final int? pageNumber;
  final int? pageSize;
  final int? offset;
  final bool? paged;
  final bool? unpaged;

  factory Pageable.fromJson(Map<String, dynamic> json) {
    return Pageable(
      sort: json["sort"] == null
          ? []
          : List<Sort>.from(json["sort"]!.map((x) => Sort.fromJson(x))),
      pageNumber: json["pageNumber"],
      pageSize: json["pageSize"],
      offset: json["offset"],
      paged: json["paged"],
      unpaged: json["unpaged"],
    );
  }

  Map<String, dynamic> toJson() => {
        "sort": sort.map((x) => x.toJson()).toList(),
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "offset": offset,
        "paged": paged,
        "unpaged": unpaged,
      };
}

class Sort {
  Sort({
    required this.direction,
    required this.property,
    required this.ignoreCase,
    required this.nullHandling,
    required this.ascending,
    required this.descending,
  });

  final String? direction;
  final String? property;
  final bool? ignoreCase;
  final String? nullHandling;
  final bool? ascending;
  final bool? descending;

  factory Sort.fromJson(Map<String, dynamic> json) {
    return Sort(
      direction: json["direction"],
      property: json["property"],
      ignoreCase: json["ignoreCase"],
      nullHandling: json["nullHandling"],
      ascending: json["ascending"],
      descending: json["descending"],
    );
  }

  Map<String, dynamic> toJson() => {
        "direction": direction,
        "property": property,
        "ignoreCase": ignoreCase,
        "nullHandling": nullHandling,
        "ascending": ascending,
        "descending": descending,
      };
}
