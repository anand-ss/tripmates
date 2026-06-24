import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/trip_model.dart';
import '../../../core/constants/app_constants.dart';

class TripService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _uuid = const Uuid();

  Future<TripModel> createTrip({
    required String name,
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required String organizerId,
    String? coverPhotoUrl,
  }) async {
    final docRef = _firestore.collection(AppConstants.tripsCollection).doc();
    final trip = TripModel(
      id: docRef.id,
      name: name,
      destination: destination,
      startDate: startDate,
      endDate: endDate,
      coverPhotoUrl: coverPhotoUrl,
      status: TripStatus.planning,
      organizerId: organizerId,
      inviteCode: _uuid.v4().substring(0, 8).toUpperCase(),
      inviteLinkActive: true,
      createdAt: DateTime.now(),
    );
    await docRef.set(trip.toMap());
    // Add organizer as member
    await docRef
        .collection(AppConstants.membersCollection)
        .doc(organizerId)
        .set({
      'role': 'organizer',
      'joinedAt': DateTime.now(),
      'locationSharing': false,
    });
    return trip;
  }

  Stream<List<TripModel>> getUserTrips(String userId) {
    return _firestore
        .collection(AppConstants.tripsCollection)
        .where('organizerId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TripModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  Stream<List<TripModel>> getMemberTrips(String userId) {
    return _firestore
        .collectionGroup(AppConstants.membersCollection)
        .where(FieldPath.documentId, isEqualTo: userId)
        .snapshots()
        .asyncMap((snapshot) async {
      final trips = <TripModel>[];
      for (final doc in snapshot.docs) {
        final tripDoc =
            await doc.reference.parent.parent!.get();
        if (tripDoc.exists) {
          trips.add(TripModel.fromMap(
              tripDoc.data() as Map<String, dynamic>, tripDoc.id));
        }
      }
      return trips;
    });
  }

  Future<TripModel?> getTripByInviteCode(String code) async {
    final snapshot = await _firestore
        .collection(AppConstants.tripsCollection)
        .where('inviteCode', isEqualTo: code)
        .where('inviteLinkActive', isEqualTo: true)
        .limit(1)
        .get();
    if (snapshot.docs.isEmpty) return null;
    return TripModel.fromMap(snapshot.docs.first.data(), snapshot.docs.first.id);
  }

  Future<void> joinTrip(String tripId, String userId) async {
    await _firestore
        .collection(AppConstants.tripsCollection)
        .doc(tripId)
        .collection(AppConstants.membersCollection)
        .doc(userId)
        .set({
      'role': 'member',
      'joinedAt': DateTime.now(),
      'locationSharing': false,
    });
  }

  Future<void> leaveTrip(String tripId, String userId) async {
    await _firestore
        .collection(AppConstants.tripsCollection)
        .doc(tripId)
        .collection(AppConstants.membersCollection)
        .doc(userId)
        .delete();
  }

  Future<void> updateTrip(String tripId, Map<String, dynamic> data) async {
    await _firestore
        .collection(AppConstants.tripsCollection)
        .doc(tripId)
        .update(data);
  }

  Future<void> deleteTrip(String tripId) async {
    await _firestore
        .collection(AppConstants.tripsCollection)
        .doc(tripId)
        .delete();
  }
}
