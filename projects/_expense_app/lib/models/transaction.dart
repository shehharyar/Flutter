// ignore: empty_constructor_bodies
class Transaction {
  final String id;
  final String title;
  final double amount;
  DateTime date;

  Transaction(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date});
}
