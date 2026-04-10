import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../theme.dart';
import '../data/user_progress.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
  final TextEditingController _searchController = TextEditingController();

  static const LatLng _initialPosition = LatLng(10.762622, 106.660172);

  final List<_PlaceData> _places = const [
    _PlaceData(
      id: 'coffee_house',
      name: 'The Coffee House',
      subtitle: '120m • Khu trung tâm',
      rating: 4.6,
      latLng: LatLng(10.7636, 106.6598),
      icon: BitmapDescriptor.hueAzure,
      promo: 'Giảm 5% khi thanh toán qua FinGo',
      imageUrl:
          'https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=600&auto=format&fit=crop',
    ),
    _PlaceData(
      id: 'canteen_a1',
      name: 'Canteen A1',
      subtitle: '150m • Khu trung tâm',
      rating: 4.8,
      latLng: LatLng(10.7615, 106.6613),
      icon: BitmapDescriptor.hueOrange,
      promo: 'Giảm 10% khi thanh toán qua FinGo',
      imageUrl:
          'https://images.unsplash.com/photo-1552566626-52f8b828add9?q=80&w=600&auto=format&fit=crop',
    ),
    _PlaceData(
      id: 'fahasa',
      name: 'Fahasa Library',
      subtitle: '300m • Đường Nguyễn Trãi',
      rating: 4.7,
      latLng: LatLng(10.7646, 106.6627),
      icon: BitmapDescriptor.hueYellow,
      promo: 'Nhân đôi XP khi check-in tại đây',
      imageUrl:
          'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?q=80&w=600&auto=format&fit=crop',
    ),
  ];

  late _PlaceData _selectedPlace;

  @override
  void initState() {
    super.initState();
    _selectedPlace = _places[1];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: Stack(
        children: [
          Positioned.fill(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(target: _initialPosition, zoom: 15.2),
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              markers: _buildMarkers(),
              onMapCreated: (controller) {
                if (!_mapController.isCompleted) {
                  _mapController.complete(controller);
                }
              },
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Container(color: Colors.black.withValues(alpha: 0.1)),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    children: [
                      _avatar(),
                      const Spacer(),
                      Text(
                        'FinGo',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              fontSize: 25,
                              color: AppTheme.primary,
                              fontStyle: FontStyle.italic,
                            ),
                      ),
                      const Spacer(),
                      const Icon(Icons.notifications, color: AppTheme.primary, size: 28),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.88),
                      borderRadius: BorderRadius.circular(999),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 14,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: AppTheme.outline, size: 28),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
                            decoration: InputDecoration(
                              hintText: 'Tìm kiếm kho báu & địa điểm...',
                              hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: const Color(0xFF687386),
                                    fontSize: 18,
                                  ),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryContainer.withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.tune, color: AppTheme.primary),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 20,
            bottom: 310,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white,
              foregroundColor: AppTheme.primary,
              onPressed: () => _focusPlace(_selectedPlace),
              child: const Icon(Icons.my_location),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 106,
            child: _buildPlaceCard(context),
          ),
        ],
      ),
    );
  }

  Set<Marker> _buildMarkers() {
    return _places
        .map(
          (place) => Marker(
            markerId: MarkerId(place.id),
            position: place.latLng,
            icon: BitmapDescriptor.defaultMarkerWithHue(place.icon),
            infoWindow: InfoWindow(title: place.name),
            onTap: () {
              setState(() {
                _selectedPlace = place;
              });
              _focusPlace(place);
            },
          ),
        )
        .toSet();
  }

  Future<void> _focusPlace(_PlaceData place) async {
    final controller = await _mapController.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: place.latLng, zoom: 16.2),
      ),
    );
  }

  Widget _buildPlaceCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 14, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Image.network(
              _selectedPlace.imageUrl,
              width: 95,
              height: 95,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedPlace.name,
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20, color: AppTheme.onSurface),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.star, color: AppTheme.tertiary, size: 16),
                    Text(
                      ' ${_selectedPlace.rating.toStringAsFixed(1)}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.tertiary),
                    ),
                  ],
                ),
                Text(
                  _selectedPlace.subtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13, color: AppTheme.onSurfaceVariant),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDEEF2),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: const Color(0xFFF6B7C8)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.local_offer, color: AppTheme.error, size: 16),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          _selectedPlace.promo,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: const Color(0xFF7A1B36),
                                fontStyle: FontStyle.italic,
                                fontSize: 13,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: const BoxDecoration(color: AppTheme.primary, shape: BoxShape.circle),
                child: IconButton(
                  onPressed: () => _focusPlace(_selectedPlace),
                  icon: const Icon(Icons.near_me, color: Colors.white),
                ),
              ),
              const SizedBox(height: 14),
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(color: AppTheme.surfaceVariant, shape: BoxShape.circle),
                child: const Icon(Icons.share, color: AppTheme.onSurfaceVariant),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _avatar() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppTheme.primaryContainer, width: 2),
            color: Colors.white,
          ),
          child: const Icon(Icons.person_outline, color: AppTheme.outline),
        ),
        Positioned(
          top: -6,
          right: -10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppTheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(999),
            ),
            child: ListenableBuilder(listenable: UserProgress(), builder: (context, _) => Text('LV.${UserProgress().currentLevel}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11))),
          ),
        ),
      ],
    );
  }
}

class _PlaceData {
  final String id;
  final String name;
  final String subtitle;
  final double rating;
  final LatLng latLng;
  final double icon;
  final String promo;
  final String imageUrl;

  const _PlaceData({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.rating,
    required this.latLng,
    required this.icon,
    required this.promo,
    required this.imageUrl,
  });
}


