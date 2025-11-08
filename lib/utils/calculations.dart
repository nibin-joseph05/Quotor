class Calculations {
  static double calculateItemTotal({
    required double rate,
    required double quantity,
    required double discount,
    required double taxPercent,
  }) {
    final subtotal = (rate - discount) * quantity;
    final taxAmount = subtotal * (taxPercent / 100);
    return subtotal + taxAmount;
  }

  static double calculateSubtotal({
    required double rate,
    required double quantity,
    required double discount,
  }) {
    return (rate - discount) * quantity;
  }

  static double calculateTax({
    required double subtotal,
    required double taxPercent,
  }) {
    return subtotal * (taxPercent / 100);
  }
}