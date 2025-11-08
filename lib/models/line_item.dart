import 'package:equatable/equatable.dart';

class LineItem extends Equatable {
  final String id;
  final String productName;
  final double quantity;
  final double rate;
  final double discount;
  final double taxPercent;

  const LineItem({
    required this.id,
    this.productName = '',
    this.quantity = 1.0,
    this.rate = 0.0,
    this.discount = 0.0,
    this.taxPercent = 0.0,
  });

  double get subtotal => (rate - discount) * quantity;

  double get taxAmount => subtotal * (taxPercent / 100);

  double get total => subtotal + taxAmount;

  LineItem copyWith({
    String? id,
    String? productName,
    double? quantity,
    double? rate,
    double? discount,
    double? taxPercent,
  }) {
    return LineItem(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      rate: rate ?? this.rate,
      discount: discount ?? this.discount,
      taxPercent: taxPercent ?? this.taxPercent,
    );
  }

  @override
  List<Object?> get props => [id, productName, quantity, rate, discount, taxPercent];
}