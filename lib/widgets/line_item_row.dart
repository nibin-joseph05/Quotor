import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/quote_bloc.dart';
import '../bloc/quote_event.dart';
import '../models/line_item.dart';
import '../utils/currency_formatter.dart';

class LineItemRow extends StatelessWidget {
  final LineItem lineItem;
  final bool canRemove;

  const LineItemRow({
    Key? key,
    required this.lineItem,
    required this.canRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    if (isSmallScreen) {
      return _buildMobileLayout(context);
    } else {
      return _buildDesktopLayout(context);
    }
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Product/Service',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                if (canRemove)
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 20),
                    color: Colors.red,
                    onPressed: () {
                      context.read<QuoteBloc>().add(RemoveLineItem(lineItem.id));
                    },
                  ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: lineItem.productName,
              decoration: const InputDecoration(
                hintText: 'Enter product/service name',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: (value) {
                context.read<QuoteBloc>().add(
                  UpdateLineItem(lineItem.copyWith(productName: value)),
                );
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildNumberField(
                    context,
                    'Quantity',
                    lineItem.quantity,
                        (value) => lineItem.copyWith(quantity: value),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildNumberField(
                    context,
                    'Rate',
                    lineItem.rate,
                        (value) => lineItem.copyWith(rate: value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildNumberField(
                    context,
                    'Discount',
                    lineItem.discount,
                        (value) => lineItem.copyWith(discount: value),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildNumberField(
                    context,
                    'Tax %',
                    lineItem.taxPercent,
                        (value) => lineItem.copyWith(taxPercent: value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    CurrencyFormatter.format(lineItem.total),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                initialValue: lineItem.productName,
                decoration: const InputDecoration(
                  labelText: 'Product/Service',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                onChanged: (value) {
                  context.read<QuoteBloc>().add(
                    UpdateLineItem(lineItem.copyWith(productName: value)),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: _buildNumberField(
                context,
                'Qty',
                lineItem.quantity,
                    (value) => lineItem.copyWith(quantity: value),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: _buildNumberField(
                context,
                'Rate',
                lineItem.rate,
                    (value) => lineItem.copyWith(rate: value),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: _buildNumberField(
                context,
                'Discount',
                lineItem.discount,
                    (value) => lineItem.copyWith(discount: value),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: _buildNumberField(
                context,
                'Tax %',
                lineItem.taxPercent,
                    (value) => lineItem.copyWith(taxPercent: value),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 100,
              child: Text(
                CurrencyFormatter.format(lineItem.total),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(width: 12),
            if (canRemove)
              IconButton(
                icon: const Icon(Icons.delete_outline),
                color: Colors.red,
                onPressed: () {
                  context.read<QuoteBloc>().add(RemoveLineItem(lineItem.id));
                },
              )
            else
              const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberField(
      BuildContext context,
      String label,
      double value,
      LineItem Function(double) onUpdate,
      ) {
    return TextFormField(
      initialValue: value == 0 ? '' : value.toString(),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      ],
      onChanged: (text) {
        final newValue = double.tryParse(text) ?? 0.0;
        context.read<QuoteBloc>().add(UpdateLineItem(onUpdate(newValue)));
      },
    );
  }
}