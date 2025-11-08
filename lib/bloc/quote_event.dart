import 'package:equatable/equatable.dart';
import '../models/client_info.dart';
import '../models/line_item.dart';
import '../models/quote.dart';

abstract class QuoteEvent extends Equatable {
  const QuoteEvent();

  @override
  List<Object?> get props => [];
}

class UpdateClientInfo extends QuoteEvent {
  final ClientInfo clientInfo;

  const UpdateClientInfo(this.clientInfo);

  @override
  List<Object?> get props => [clientInfo];
}

class AddLineItem extends QuoteEvent {
  const AddLineItem();
}

class RemoveLineItem extends QuoteEvent {
  final String itemId;

  const RemoveLineItem(this.itemId);

  @override
  List<Object?> get props => [itemId];
}

class UpdateLineItem extends QuoteEvent {
  final LineItem lineItem;

  const UpdateLineItem(this.lineItem);

  @override
  List<Object?> get props => [lineItem];
}

class ToggleTaxMode extends QuoteEvent {
  const ToggleTaxMode();
}

class UpdateQuoteStatus extends QuoteEvent {
  final QuoteStatus status;

  const UpdateQuoteStatus(this.status);

  @override
  List<Object?> get props => [status];
}

class ResetQuote extends QuoteEvent {
  const ResetQuote();
}