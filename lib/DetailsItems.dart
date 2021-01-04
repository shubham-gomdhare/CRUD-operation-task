class DetailsItem {
  final String img;
  final String name;
  final String phone;
  final String mail;
  final DateTime dateTime;
  DetailsItem({
    this.img,
    this.name,
    this.phone,
    this.mail,
    this.dateTime,
  });
  static DetailsItem fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return DetailsItem(
      img: map['img'],
      name: map['name'],
      phone: map['phone'],
      mail: map['mail'],
      dateTime: map['dateTime']
    );
  }
}