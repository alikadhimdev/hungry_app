class ItemCard {
  String img, title, des;
  int id, count;

  ItemCard({
    required this.img,
    required this.title,
    required this.des,
    required this.id,
    required this.count,
  });

  factory ItemCard.fromMap(Map<String, dynamic> map) {
    return ItemCard(
      img: map["img"],
      title: map["title"],
      des: map["des"],
      id: map["id"],
      count: map["count"],
    );
  }
}

List<ItemCard> items = [
  ItemCard(
    img: "assets/test/test.png",
    title: "Hamburger",
    des: "Veggle Burger",
    id: 1,
    count: 1,
  ),
  ItemCard(
    img: "assets/test/test.png",
    title: "Hamburger",
    des: "Veggle Burger",
    id: 1,
    count: 1,
  ),
  ItemCard(
    img: "assets/test/test.png",
    title: "Hamburger",
    des: "Veggle Burger",
    id: 1,
    count: 1,
  ),
  ItemCard(
    img: "assets/test/test.png",
    title: "Hamburger",
    des: "Veggle Burger",
    id: 1,
    count: 1,
  ),
  ItemCard(
    img: "assets/test/test.png",
    title: "Hamburger",
    des: "Veggle Burger",
    id: 1,
    count: 1,
  ),
  ItemCard(
    img: "assets/test/test.png",
    title: "Hamburger",
    des: "Veggle Burger",
    id: 1,
    count: 1,
  ),
];
