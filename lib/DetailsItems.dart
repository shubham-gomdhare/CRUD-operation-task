class DetailsItem {
  final String img;
  final String name;
  final String phone;
  final String address;
  DetailsItem({
    this.img,
    this.name,
    this.phone,
    this.address,
  });
  // Add the document ID to the post model when serialising.
  static DetailsItem fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return DetailsItem(
      img: map['img'],
      name: map['name'],
      phone: map['phone'],
      address: map['address'],
    );
  }
}