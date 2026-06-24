# Tripmates — Architecture

> Status: Draft v1.0  
> Last updated: 2026-06-24

---

## Tech Stack

| Layer | Technology | Reason |
|---|---|---|
| Frontend | Flutter 3.x | Single codebase for Android + Web |
| Language | Dart | Flutter's native language |
| Auth | Firebase Authentication | Built-in Google sign-in, email/password |
| Database | Firebase Firestore | Real-time sync, offline support |
| File Storage | Firebase Storage | Photos, documents, profile pictures |
| Push Notifications | Firebase Cloud Messaging (FCM) | Cross-platform notifications |
| Maps | Google Maps Flutter Plugin | Location sharing, activity pins |
| State Management | Riverpod | Scalable, testable state management |
| Navigation | Go Router | Declarative routing for Flutter web support |

---

## High-Level Architecture

```
┌──────────────────────────────────────┐
│           Flutter App                │
│   (Android APK + Web Browser)        │
│                                      │
│  ┌─────────┐  ┌──────────────────┐   │
│  │   UI    │  │  State (Riverpod) │  │
│  └────┬────┘  └────────┬─────────┘   │
│       └───────┬─────────┘            │
│           ┌───▼────┐                 │
│           │Services│                 │
│           └───┬────┘                 │
└───────────────┼──────────────────────┘
                │ Firebase SDK
┌───────────────▼──────────────────────┐
│            Firebase                  │
│  ┌────────┐ ┌──────────┐ ┌────────┐  │
│  │  Auth  │ │Firestore │ │Storage │  │
│  └────────┘ └──────────┘ └────────┘  │
│  ┌─────────────────────────────────┐  │
│  │     Cloud Messaging (FCM)       │  │
│  └─────────────────────────────────┘  │
└──────────────────────────────────────┘
```

---

## Firestore Data Model

```
users/{userId}
  - name: string
  - email: string
  - photoUrl: string
  - createdAt: timestamp

trips/{tripId}
  - name: string
  - destination: string
  - startDate: timestamp
  - endDate: timestamp
  - coverPhotoUrl: string
  - status: 'planning' | 'active' | 'completed'
  - organizerId: string
  - inviteCode: string
  - inviteLinkActive: boolean
  - createdAt: timestamp

trips/{tripId}/members/{userId}
  - role: 'organizer' | 'member'
  - joinedAt: timestamp
  - locationSharing: boolean

trips/{tripId}/itinerary/{activityId}
  - title: string
  - date: timestamp
  - time: string
  - location: string
  - geoPoint: geopoint
  - notes: string
  - isDone: boolean
  - createdBy: string

trips/{tripId}/expenses/{expenseId}
  - title: string
  - amount: number
  - currency: string
  - paidBy: string (userId)
  - splitAmong: map<userId, amount>
  - isSettled: boolean
  - createdAt: timestamp

trips/{tripId}/settlements/{settlementId}
  - from: string (userId)
  - to: string (userId)
  - amount: number
  - confirmedAt: timestamp

trips/{tripId}/messages/{messageId}
  - senderId: string
  - text: string
  - photoUrl: string
  - replyTo: string (messageId)
  - createdAt: timestamp

trips/{tripId}/locations/{userId}
  - geoPoint: geopoint
  - updatedAt: timestamp
  - isSharing: boolean

trips/{tripId}/documents/{documentId}
  - name: string
  - url: string
  - fileType: string
  - uploadedBy: string
  - uploadedAt: timestamp
```

---

## Folder Structure (Flutter App)

```
lib/
  main.dart
  firebase_options.dart
  
  core/
    constants/
    theme/
    utils/
    
  features/
    auth/
      screens/
      providers/
      services/
    trips/
      screens/
      providers/
      services/
      models/
    itinerary/
    expenses/
    location/
    chat/
    documents/
    notifications/
    
  shared/
    widgets/
    models/
```
