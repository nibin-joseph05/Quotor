import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/quote_bloc.dart';
import '../bloc/quote_event.dart';
import '../bloc/quote_state.dart';
import '../models/quote.dart';
import '../widgets/client_info_section.dart';
import '../widgets/line_item_row.dart';
import '../widgets/quote_summary.dart';
import 'quote_preview_screen.dart';

class QuoteFormScreen extends StatelessWidget {
  const QuoteFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Product Quote Builder'),
        elevation: 0,
        actions: [
          BlocBuilder<QuoteBloc, QuoteState>(
            builder: (context, state) {
              return PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) {
                  if (value == 'toggle_tax') {
                    context.read<QuoteBloc>().add(const ToggleTaxMode());
                  } else if (value == 'reset') {
                    _showResetDialog(context);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'toggle_tax',
                    child: Row(
                      children: [
                        Icon(
                          state.quote.taxMode == TaxMode.exclusive
                              ? Icons.toggle_off
                              : Icons.toggle_on,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          state.quote.taxMode == TaxMode.exclusive
                              ? 'Switch to Tax Inclusive'
                              : 'Switch to Tax Exclusive',
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'reset',
                    child: Row(
                      children: [
                        Icon(Icons.refresh, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Reset Quote'),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<QuoteBloc, QuoteState>(
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final isWideScreen = constraints.maxWidth > 900;

              if (isWideScreen) {
                return _buildWideLayout(context, state);
              } else {
                return _buildNarrowLayout(context, state);
              }
            },
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: 'preview',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: context.read<QuoteBloc>(),
                    child: const QuotePreviewScreen(),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.preview),
            label: const Text('Preview'),
            backgroundColor: Colors.green,
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'add',
            onPressed: () {
              context.read<QuoteBloc>().add(const AddLineItem());
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget _buildWideLayout(BuildContext context, QuoteState state) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClientInfoSection(clientInfo: state.quote.clientInfo),
                const SizedBox(height: 24),
                _buildLineItemsSection(context, state),
              ],
            ),
          ),
        ),
        Container(
          width: 350,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(-2, 0),
              ),
            ],
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: QuoteSummary(quote: state.quote),
          ),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout(BuildContext context, QuoteState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClientInfoSection(clientInfo: state.quote.clientInfo),
          const SizedBox(height: 20),
          _buildLineItemsSection(context, state),
          const SizedBox(height: 20),
          QuoteSummary(quote: state.quote),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildLineItemsSection(BuildContext context, QuoteState state) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.shopping_cart, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                const Text(
                  'Line Items',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    context.read<QuoteBloc>().add(const AddLineItem());
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Item'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...state.quote.lineItems.map((item) {
              return LineItemRow(
                key: ValueKey(item.id),
                lineItem: item,
                canRemove: state.quote.lineItems.length > 1,
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Reset Quote'),
        content: const Text(
          'Are you sure you want to reset the quote? All data will be lost.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<QuoteBloc>().add(const ResetQuote());
              Navigator.pop(dialogContext);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}