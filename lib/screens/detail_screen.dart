import 'dart:async';

import 'package:flutter/material.dart';

import '../models/destination.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.destination});

  final Destination destination;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<Weather> _weather;

  Future<Weather> _fetch() => WeatherService().fetch(
    widget.destination.lat,
    widget.destination.lng,
  );

  @override
  void initState() {
    super.initState();
    _weather = _fetch();
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.destination;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(d.name)),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                d.tagline,
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(
                    Icons.place_outlined,
                    size: 16,
                    color: theme.colorScheme.outline,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${d.lat}, ${d.lng}',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.colorScheme.outline),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              FutureBuilder<Weather>(
                future: _weather,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const SizedBox(
                      height: 160,
                      child: Card(
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return _ErrorCard(
                      error: snapshot.error,
                      onRetry: () => setState(() {
                        _weather = _fetch();
                      }),
                    );
                  }

                  return _WeatherCard(weather: snapshot.data!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WeatherCard extends StatelessWidget {
  const _WeatherCard({required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [cs.primary, Color.lerp(cs.primary, Colors.black, 0.3)!],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(weather.icon, size: 64, color: Colors.white),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${weather.temperature.toStringAsFixed(1)} °C',
                      style: const TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      weather.label,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(color: Colors.white24, height: 32),
          Row(
            children: [
              const Icon(Icons.air, color: Colors.white70),
              const SizedBox(width: 8),
              Text(
                'Wind ${weather.windSpeed.toStringAsFixed(1)} km/h',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({required this.error, required this.onRetry});

  final Object? error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final message = error is TimeoutException
        ? 'Check your connection'
        : 'Could not load the weather';

    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(Icons.cloud_off, size: 48, color: theme.colorScheme.error),
              const SizedBox(height: 12),
              Text(message, style: theme.textTheme.titleMedium),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}