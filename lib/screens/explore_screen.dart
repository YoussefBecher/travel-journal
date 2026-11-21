import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/destination.dart';
import '../providers/favorites_provider.dart';
import '../widgets/destination_card.dart';
import 'my_trips_screen.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final count = context.watch<FavoritesProvider>().count;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Travel Journal'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const MyTripsScreen()),
              ),
              icon: Badge.count(
                count: count,
                isLabelVisible: count > 0,
                child: const Icon(Icons.favorite),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          for (final d in destinations) DestinationCard(destination: d),
        ],
      ),
    );
  }
}