import 'package:equatable/equatable.dart';
import '../models/quote.dart';

class QuoteState extends Equatable {
  final Quote quote;

  const QuoteState({required this.quote});

  QuoteState copyWith({Quote? quote}) {
    return QuoteState(quote: quote ?? this.quote);
  }

  @override
  List<Object?> get props => [quote];
}