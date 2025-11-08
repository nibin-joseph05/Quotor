import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/quote_bloc.dart';
import '../bloc/quote_event.dart';
import '../models/client_info.dart';

class ClientInfoSection extends StatelessWidget {
  final ClientInfo clientInfo;

  const ClientInfoSection({
    Key? key,
    required this.clientInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                Icon(Icons.person_outline, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                const Text(
                  'Client Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: clientInfo.name,
              decoration: const InputDecoration(
                labelText: 'Client Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              onChanged: (value) {
                context.read<QuoteBloc>().add(
                  UpdateClientInfo(clientInfo.copyWith(name: value)),
                );
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: clientInfo.address,
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
              maxLines: 2,
              onChanged: (value) {
                context.read<QuoteBloc>().add(
                  UpdateClientInfo(clientInfo.copyWith(address: value)),
                );
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: clientInfo.reference,
              decoration: const InputDecoration(
                labelText: 'Reference/Project',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
              ),
              onChanged: (value) {
                context.read<QuoteBloc>().add(
                  UpdateClientInfo(clientInfo.copyWith(reference: value)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}