class AppConstants {
  static const String appName = 'Tripmates';
  static const String appVersion = '1.0.0';

  // Firestore collections
  static const String usersCollection = 'users';
  static const String tripsCollection = 'trips';
  static const String membersCollection = 'members';
  static const String itineraryCollection = 'itinerary';
  static const String expensesCollection = 'expenses';
  static const String settlementsCollection = 'settlements';
  static const String messagesCollection = 'messages';
  static const String locationsCollection = 'locations';
  static const String documentsCollection = 'documents';

  // Storage paths
  static const String profilePhotosPath = 'profile_photos';
  static const String tripCoversPath = 'trip_covers';
  static const String chatPhotosPath = 'chat_photos';
  static const String documentsPath = 'documents';

  // Location update interval in seconds
  static const int locationUpdateInterval = 30;

  // Max file sizes
  static const int maxPhotoSizeMB = 10;
  static const int maxDocumentSizeMB = 20;
}
