import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/client_info.dart';
import '../models/line_item.dart';
import '../models/quote.dart';
import 'quote_event.dart';
import 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  QuoteBloc()
      : super(QuoteState(
    quote: Quote(
      clientInfo: const ClientInfo(),
      lineItems: [LineItem(id: DateTime.now().millisecondsSinceEpoch.toString())],
      createdAt: DateTime.now(),
    ),
  )) {
    on<UpdateClientInfo>(_onUpdateClientInfo);
    on<AddLineItem>(_onAddLineItem);
    on<RemoveLineItem>(_onRemoveLineItem);
    on<UpdateLineItem>(_onUpdateLineItem);
    on<ToggleTaxMode>(_onToggleTaxMode);
    on<UpdateQuoteStatus>(_onUpdateQuoteStatus);
    on<ResetQuote>(_onResetQuote);
  }

  void _onUpdateClientInfo(UpdateClientInfo event, Emitter<QuoteState> emit) {
    emit(state.copyWith(
      quote: state.quote.copyWith(clientInfo: event.clientInfo),
    ));
  }

  void _onAddLineItem(AddLineItem event, Emitter<QuoteState> emit) {
    final newItem = LineItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    final updatedItems = List<LineItem>.from(state.quote.lineItems)..add(newItem);
    emit(state.copyWith(
      quote: state.quote.copyWith(lineItems: updatedItems),
    ));
  }

  void _onRemoveLineItem(RemoveLineItem event, Emitter<QuoteState> emit) {
    final updatedItems = state.quote.lineItems
        .where((item) => item.id != event.itemId)
        .toList();
    if (updatedItems.isEmpty) {
      return;
    }
    emit(state.copyWith(
      quote: state.quote.copyWith(lineItems: updatedItems),
    ));
  }

  void _onUpdateLineItem(UpdateLineItem event, Emitter<QuoteState> emit) {
    final updatedItems = state.quote.lineItems.map((item) {
      return item.id == event.lineItem.id ? event.lineItem : item;
    }).toList();
    emit(state.copyWith(
      quote: state.quote.copyWith(lineItems: updatedItems),
    ));
  }

  void _onToggleTaxMode(ToggleTaxMode event, Emitter<QuoteState> emit) {
    final newMode = state.quote.taxMode == TaxMode.exclusive
        ? TaxMode.inclusive
        : TaxMode.exclusive;
    emit(state.copyWith(
      quote: state.quote.copyWith(taxMode: newMode),
    ));
  }

  void _onUpdateQuoteStatus(UpdateQuoteStatus event, Emitter<QuoteState> emit) {
    emit(state.copyWith(
      quote: state.quote.copyWith(status: event.status),
    ));
  }

  void _onResetQuote(ResetQuote event, Emitter<QuoteState> emit) {
    emit(QuoteState(
      quote: Quote(
        clientInfo: const ClientInfo(),
        lineItems: [LineItem(id: DateTime.now().millisecondsSinceEpoch.toString())],
        createdAt: DateTime.now(),
      ),
    ));
  }
}