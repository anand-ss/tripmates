# Tripmates — Requirements

> Status: Draft v1.0 — Pending review  
> Last updated: 2026-06-24

---

## User Roles

| Role | Description |
|---|---|
| **Organizer** | Creates and manages the trip. Has full control over settings, members, and itinerary. |
| **Member** | Invited to join a trip. Can add expenses, chat, share location, and view itinerary. |

---

## Epic 1 — Authentication & User Profile

### Features
- Sign up with email & password
- Sign in with Google
- User profile (name, photo, bio)
- Password reset via email
- Logout

### User Stories

**US-101** — Sign Up  
_As a new user, I want to create an account with my email and password so that I can start using Tripmates._  
Acceptance Criteria:
- Email must be valid format
- Password minimum 8 characters
- On success, user is redirected to the home screen
- Duplicate email shows a clear error message

**US-102** — Google Sign In  
_As a user, I want to sign in with my Google account so that I don't have to remember a separate password._  
Acceptance Criteria:
- One-tap Google sign-in on login screen
- If first time, a new profile is auto-created using Google name and photo
- On success, user is redirected to home screen

**US-103** — User Profile  
_As a user, I want to set up my profile with a name and photo so that my travel group can identify me._  
Acceptance Criteria:
- User can upload a profile photo
- User can edit display name
- Changes are reflected across all trips and chats in real time

**US-104** — Password Reset  
_As a user, I want to reset my password via email so that I can recover access if I forget it._  
Acceptance Criteria:
- Reset link sent within 60 seconds
- Link expires after 24 hours

---

## Epic 2 — Trip Management

### Features
- Create a trip (name, destination, dates, cover photo)
- Edit trip details
- Delete a trip (organizer only)
- View all my trips (upcoming & past)
- Trip status (Planning / Active / Completed)
- Invite members via shareable link or email
- Remove a member (organizer only)
- Leave a trip (member)

### User Stories

**US-201** — Create Trip  
_As an organizer, I want to create a trip with a name, destination, and travel dates so that I can start planning with my group._  
Acceptance Criteria:
- Required fields: trip name, destination, start date, end date
- Optional: cover photo
- Trip appears on home screen immediately after creation
- Creator is automatically assigned the Organizer role

**US-202** — Invite Members  
_As an organizer, I want to invite friends to my trip via a shareable link so that they can join easily without needing my help._  
Acceptance Criteria:
- Generate a unique invite link per trip
- Link can be shared via WhatsApp, email, or copied to clipboard
- Invited user sees trip details before accepting
- Organizer can disable the invite link at any time

**US-203** — View My Trips  
_As a user, I want to see all my trips on the home screen so that I can quickly navigate to any trip._  
Acceptance Criteria:
- Trips grouped into Upcoming, Active, and Past
- Each trip card shows name, destination, dates, and member count
- Tapping a trip opens the trip detail screen

**US-204** — Leave / Remove from Trip  
_As a member, I want to leave a trip I no longer want to be part of._  
_As an organizer, I want to remove a member from a trip if needed._  
Acceptance Criteria:
- Member can leave from trip settings
- Organizer can remove any member except themselves
- Removed member loses access to trip data immediately
- Unsettled expenses involving the removed member are flagged

---

## Epic 3 — Itinerary Planning

### Features
- Add itinerary days automatically based on trip dates
- Add activities/events per day (title, time, location, notes)
- Edit and delete activities
- Reorder activities within a day
- Mark activity as done
- All members can view; organizer controls who can edit

### User Stories

**US-301** — Add Activity  
_As an organizer, I want to add activities to each day of the trip so that everyone knows the plan._  
Acceptance Criteria:
- Required: activity title, day
- Optional: time, location (with map pin), notes
- Activity appears in chronological order within the day

**US-302** — View Itinerary  
_As a member, I want to view the full trip itinerary so that I know what's planned each day._  
Acceptance Criteria:
- Day-by-day view with all activities listed
- Activities show time, title, and location
- Members can see but not edit (unless organizer grants permission)

**US-303** — Mark Activity Done  
_As a member, I want to mark an activity as completed so that the group knows we've done it._  
Acceptance Criteria:
- Any member can mark an activity as done
- Done activities show a visual indicator (strikethrough or checkmark)
- Action is visible to all members in real time

---

## Epic 4 — Expense Splitting & Tracking

### Features
- Add an expense (title, amount, currency, paid by, split among)
- Split equally or by custom amounts
- View all trip expenses
- Expense summary — who owes whom
- Mark debt as settled
- Export expense report (PDF/CSV)
- Multi-currency support with conversion

### User Stories

**US-401** — Add Expense  
_As a member, I want to add an expense I paid for so that the group knows I covered it and can reimburse me._  
Acceptance Criteria:
- Required: title, amount, currency, who paid
- Split options: equally among all, equally among selected members, custom amounts
- Expense is added to the trip ledger immediately

**US-402** — View Expense Summary  
_As a member, I want to see a summary of who owes whom so that we can settle up easily._  
Acceptance Criteria:
- Shows net balance per person (positive = owed money, negative = owes money)
- Simplified debt view (minimizes number of transactions needed to settle)
- Updates in real time as expenses are added or settled

**US-403** — Settle Expense  
_As a member, I want to mark a payment as settled so that the balances are updated._  
Acceptance Criteria:
- Member can record a payment made outside the app
- Both payer and receiver must confirm (or organizer can confirm)
- Settled amount is deducted from the balance

**US-404** — Export Expense Report  
_As an organizer, I want to export a full expense report so that I have a record after the trip._  
Acceptance Criteria:
- Export as PDF or CSV
- Report includes all expenses, who paid, splits, and final balances

---

## Epic 5 — Real-Time Location Sharing

### Features
- Share live location with trip group
- View all members on a map
- Stop sharing location
- Last seen location when member is offline
- Location history for the trip duration (optional, opt-in)

### User Stories

**US-501** — Share Location  
_As a member, I want to share my live location with the group so that everyone knows where I am during the trip._  
Acceptance Criteria:
- User explicitly opts in to location sharing per trip
- Location updates every 30 seconds while app is active
- User can stop sharing at any time
- Battery saver mode reduces update frequency when screen is off

**US-502** — View Group on Map  
_As a member, I want to see where all group members are on a map so that we can coordinate meetups._  
Acceptance Criteria:
- Map shows all members currently sharing location
- Each member shown as a pin with their profile photo
- Tapping a pin shows member name and last updated time
- Members not sharing location are shown as offline

**US-503** — Last Seen Location  
_As a member, I want to see the last known location of a member who has stopped sharing so that I have some reference._  
Acceptance Criteria:
- Last location stored when member stops sharing
- Shown on map with a timestamp ("Last seen 2h ago")
- Member can opt out of storing last location

---

## Epic 6 — Group Chat

### Features
- Group chat per trip
- Send text messages
- Send photos and files
- Reply to a specific message
- Message read receipts
- Push notifications for new messages

### User Stories

**US-601** — Send Message  
_As a member, I want to send messages in the trip chat so that I can communicate with the group._  
Acceptance Criteria:
- Text messages delivered in real time
- Messages show sender name, photo, and timestamp
- New messages appear at the bottom

**US-602** — Send Photos  
_As a member, I want to share photos in the chat so that the group can see trip memories._  
Acceptance Criteria:
- Select from gallery or take a new photo
- Photos displayed inline in the chat
- Max file size: 10MB per photo

**US-603** — Push Notifications  
_As a member, I want to receive push notifications for new chat messages so that I don't miss important updates._  
Acceptance Criteria:
- Notification shows sender name and message preview
- Tapping notification opens the trip chat
- User can mute notifications per trip

---

## Epic 7 — Document & Media Sharing

### Features
- Upload documents (PDF, images) to a trip
- View shared documents
- Delete own documents
- Organizer can delete any document
- Storage limit per trip

### User Stories

**US-701** — Upload Document  
_As a member, I want to upload travel documents (tickets, hotel confirmations) to the trip so that everyone has access._  
Acceptance Criteria:
- Supported formats: PDF, JPG, PNG
- Max file size: 20MB
- Document listed with uploader name and upload date

**US-702** — View Documents  
_As a member, I want to view shared documents so that I can access bookings and tickets without asking others._  
Acceptance Criteria:
- Documents listed in a shared folder per trip
- PDF opens in an in-app viewer
- Images open in a full-screen viewer

---

## Epic 8 — Notifications & Activity Feed

### Features
- Push notifications for key events
- In-app activity feed per trip
- Notification preferences per trip

### User Stories

**US-801** — Activity Feed  
_As a member, I want to see a feed of recent activity in my trip so that I know what has changed._  
Acceptance Criteria:
- Feed shows events: new expense added, itinerary updated, member joined/left, document uploaded
- Events listed in reverse chronological order
- Each event shows who did it and when

**US-802** — Notification Preferences  
_As a member, I want to control which notifications I receive per trip so that I'm not overwhelmed._  
Acceptance Criteria:
- Toggle notifications for: new messages, new expenses, itinerary changes, location updates
- Settings saved per trip, not globally

---

## Out of Scope for v1

- In-app payments or money transfers
- Flight/hotel booking integration
- Offline mode
- Multiple languages (English only for v1)
- iOS app (Android + Web first)
- AI trip suggestions
