import 'package:equatable/equatable.dart';
import 'client_info.dart';
import 'line_item.dart';

enum QuoteStatus { draft, sent, accepted }

enum TaxMode { inclusive, exclusive }

class Quote extends Equatable {
  final ClientInfo clientInfo;
  final List<LineItem> lineItems;
  final QuoteStatus status;
  final TaxMode taxMode;
  final DateTime createdAt;

  const Quote({
    required this.clientInfo,
    required this.lineItems,
    this.status = QuoteStatus.draft,
    this.taxMode = TaxMode.exclusive,
    required this.createdAt,
  });

  double get subtotal {
    return lineItems.fold(0.0, (sum, item) => sum + item.subtotal);
  }

  double get totalTax {
    return lineItems.fold(0.0, (sum, item) => sum + item.taxAmount);
  }

  double get grandTotal {
    if (taxMode == TaxMode.inclusive) {
      return subtotal;
    }
    return subtotal + totalTax;
  }

  Quote copyWith({
    ClientInfo? clientInfo,
    List<LineItem>? lineItems,
    QuoteStatus? status,
    TaxMode? taxMode,
    DateTime? createdAt,
  }) {
    return Quote(
      clientInfo: clientInfo ?? this.clientInfo,
      lineItems: lineItems ?? this.lineItems,
      status: status ?? this.status,
      taxMode: taxMode ?? this.taxMode,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [clientInfo, lineItems, status, taxMode, createdAt];
}