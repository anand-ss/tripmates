import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/trip_model.dart';
import '../services/trip_service.dart';
import '../../auth/providers/auth_provider.dart';
import 'package:intl/intl.dart';

final tripServiceProvider = Provider<TripService>((ref) => TripService());

final userTripsProvider = StreamProvider.family<List<TripModel>, String>(
  (ref, userId) => ref.watch(tripServiceProvider).getUserTrips(userId),
);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user == null) {
          WidgetsBinding.instance
              .addPostFrameCallback((_) => context.go('/login'));
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final tripsAsync = ref.watch(userTripsProvider(user.uid));
        return Scaffold(
          appBar: AppBar(
            title: const Text('Tripmates'),
            actions: [
              IconButton(
                icon: const Icon(Icons.person_outlined),
                onPressed: () => context.push('/profile'),
              ),
            ],
          ),
          body: tripsAsync.when(
            data: (trips) => _buildTripsList(context, trips),
            loading: () =>
                const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => context.push('/trips/create'),
            icon: const Icon(Icons.add),
            label: const Text('New Trip'),
          ),
        );
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }

  Widget _buildTripsList(BuildContext context, List<TripModel> trips) {
    if (trips.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.travel_explore, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            Text('No trips yet',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.grey)),
            const SizedBox(height: 8),
            const Text('Tap the button below to plan your first trip!',
                style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    final upcoming = trips
        .where((t) => t.status == TripStatus.planning)
        .toList();
    final active = trips
        .where((t) => t.status == TripStatus.active)
        .toList();
    final past = trips
        .where((t) => t.status == TripStatus.completed)
        .toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (active.isNotEmpty) ...[
          _sectionHeader(context, 'Active Trips'),
          ...active.map((t) => _TripCard(trip: t)),
        ],
        if (upcoming.isNotEmpty) ...[
          _sectionHeader(context, 'Upcoming Trips'),
          ...upcoming.map((t) => _TripCard(trip: t)),
        ],
        if (past.isNotEmpty) ...[
          _sectionHeader(context, 'Past Trips'),
          ...past.map((t) => _TripCard(trip: t)),
        ],
      ],
    );
  }

  Widget _sectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey[700])),
    );
  }
}

class _TripCard extends StatelessWidget {
  final TripModel trip;
  const _TripCard({required this.trip});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d, yyyy');
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => context.push('/trips/${trip.id}'),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (trip.coverPhotoUrl != null)
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  trip.coverPhotoUrl!,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                height: 140,
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3).withOpacity(0.15),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: const Center(
                  child: Icon(Icons.travel_explore,
                      size: 60, color: Color(0xFF2196F3)),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(trip.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold)),
                      ),
                      _StatusChip(status: trip.status),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(children: [
                    const Icon(Icons.location_on_outlined,
                        size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(trip.destination,
                        style: const TextStyle(color: Colors.grey)),
                  ]),
                  const SizedBox(height: 4),
                  Row(children: [
                    const Icon(Icons.calendar_today_outlined,
                        size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      '${dateFormat.format(trip.startDate)} – ${dateFormat.format(trip.endDate)}',
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final TripStatus status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final colors = {
      TripStatus.planning: Colors.orange,
      TripStatus.active: Colors.green,
      TripStatus.completed: Colors.grey,
    };
    final labels = {
      TripStatus.planning: 'Planning',
      TripStatus.active: 'Active',
      TripStatus.completed: 'Completed',
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colors[status]!.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        labels[status]!,
        style: TextStyle(
            color: colors[status], fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
