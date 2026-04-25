# Task Manager App - Flutter with Back4App

## 📱 Project Overview

A Flutter-based Task Manager application that demonstrates Backend-as-a-Service (BaaS) integration with Back4App. This project showcases user authentication and complete CRUD operations for task management using cloud database synchronization.

---

## ✨ Key Features

### 🔐 User Authentication
- User registration with email validation
- Secure login with password verification
- Session persistence across app sessions
- Automatic logout with confirmation
- Auth-based navigation (redirects to login if not authenticated)

### ✅ Task Management (CRUD)
- **Create:** Add new tasks with title and description
- **Read:** View all user tasks in real-time from cloud database
- **Update:** Edit task details and toggle completion status
- **Delete:** Remove tasks with confirmation dialog

### 📊 Task Organization
- Task completion tracking with visual progress indicators
- Percentage-based progress calculation (X/Y tasks completed)
- Visual distinction between completed and pending tasks
- Real-time synchronization with cloud backend

### 🎨 User Interface
- Clean Material Design 3 interface
- Responsive layout supporting multiple screen sizes
- User-friendly error messages and feedback
- Empty state handling with helpful prompts
- Smooth navigation between screens

---

## 🛠️ Technology Stack

### Frontend Framework
- **Flutter** - Cross-platform mobile UI framework
- **Dart** - Programming language for Flutter development

### Backend Services
- **Back4App** - Backend-as-a-Service (Parse Server)
  - Cloud database for persistent data storage
  - User authentication and session management
  - Real-time data synchronization
  - Automatic schema creation and management

### Additional Tools & Libraries
- **Parse SDK for Flutter** - Integration with Back4App backend
- **Material Design Components** - UI widgets and styling
- **Dart Standard Library** - Core functionality

---

## 📋 Functional Requirements Met

✅ **User Authentication**
- Email-based registration with validation
- Password-based login and logout
- Secure session management

✅ **Task CRUD Operations**
- Create new tasks with title and description
- Read and display all user-specific tasks
- Update task details and completion status
- Delete tasks permanently

✅ **Backend Integration**
- Back4App handles all data persistence
- No custom backend server required
- Cloud-based data storage and retrieval

✅ **Real-Time Synchronization**
- Instant task updates across sessions
- Live database synchronization
- User isolation (each user sees only their tasks)

---

## 🎯 Application Flow

### User Journey
1. **Launch** - App checks for existing session
2. **Authentication** - User registers or logs in with email
3. **Task Dashboard** - View all personal tasks with progress tracking
4. **Task Creation** - Add new tasks via floating action button
5. **Task Interaction** - Toggle completion, edit details, or delete tasks
6. **Logout** - Secure session termination

### Data Flow
1. User actions trigger local state updates
2. Operations are sent to Back4App backend
3. Cloud database processes and stores changes
4. Real-time response updates UI instantly
5. Data persists across app sessions

---

## 📱 Screens & Components

### Screens
- **Login Screen** - Email and password input with validation
- **Register Screen** - Account creation with password confirmation
- **Task List Screen** - Display all tasks with progress bar
- **Task Form Screen** - Create or edit tasks with validation

### UI Components
- **Task Card Widget** - Individual task display with action buttons
- **Progress Indicator** - Visual task completion percentage
- **Error Dialogs** - User-friendly error notifications
- **Confirmation Dialogs** - Safety prompts for destructive actions

---

## 🔄 CRUD Operations Explained

### Create (Add Task)
Users click the floating action button to open the task form, enter title and description, and save. The task is instantly created in the Back4App cloud database.

### Read (View Tasks)
Upon login, the app fetches all user-specific tasks from Back4App. Tasks are displayed in a scrollable list with real-time updates.

### Update (Edit Task)
Users can edit task details by clicking the edit icon. They can also toggle task completion status using the checkbox. All changes sync immediately to the cloud.

### Delete (Remove Task)
Clicking the delete icon shows a confirmation dialog. Upon confirmation, the task is permanently removed from the cloud database.

---

## ☁️ Backend-as-Service Benefits

### Why Back4App?
- **No Server Setup** - Back4App manages all backend infrastructure
- **Built-in Authentication** - User management handled automatically
- **Cloud Database** - Scalable data storage without configuration
- **Real-time Sync** - Automatic data synchronization
- **Zero Backend Coding** - Focus on frontend development

### How It Works
Back4App provides a Parse Server that acts as a middleware between the Flutter app and the database. All user data and tasks are stored securely in Back4App's cloud infrastructure.

---

## 🎓 Learning Outcomes

This project demonstrates:
- Cross-platform mobile app development using Flutter
- Integration with Backend-as-a-Service architecture
- Cloud database operations and synchronization
- User authentication and session management
- CRUD operations in a real-world application
- Material Design UI principles
- Clean code architecture and best practices

---

## ✅ Project Status

**Status:** Production Ready

**Code Quality:** Zero compilation errors, passes Flutter analysis
**Features:** All core features implemented and tested
**Documentation:** Complete with inline code comments
**Testing:** Ready for user acceptance testing

---

## 📝 Assignment Completion

This project fulfills all assignment requirements:

✅ User authentication with email registration and login
✅ Complete CRUD operations on tasks
✅ Backend-as-a-Service integration (Back4App)
✅ Real-time database synchronization
✅ Secure logout functionality
✅ Professional UI/UX with Material Design
✅ Production-ready code quality
✅ GitHub repository with comprehensive documentation

---

## 🚀 Getting Started

To run this application, you need:
- Flutter SDK (version 3.0 or higher)
- Chrome browser or Android/iOS emulator
- Internet connection for Back4App cloud services

The app is fully configured with Back4App credentials and ready to use immediately upon setup.

---

## 📞 Key Technologies Summary

| Component | Technology | Purpose |
|-----------|-----------|---------|
| Frontend | Flutter (Dart) | Cross-platform mobile UI |
| Backend | Back4App (Parse Server) | Cloud backend & database |
| Authentication | Back4App Auth | User registration & login |
| Database | Back4App Cloud DB | Data persistence |
| UI Framework | Material Design 3 | Responsive interface design |

---

## 🎯 Features at a Glance

- **5 Screens** - Complete user journey from login to task management
- **3 Widgets** - Reusable UI components for task display
- **Full CRUD** - Complete Create, Read, Update, Delete functionality
- **Real-time Sync** - Instant cloud database updates
- **User Isolation** - Each user sees only their tasks
- **Progress Tracking** - Visual completion percentage
- **Error Handling** - User-friendly error messages
- **Input Validation** - Email and password validation

---

## 📊 Application Architecture

The application follows a clean architecture pattern with:
- **Services Layer** - Back4App integration and API calls
- **Models Layer** - Data structures for tasks
- **Screens Layer** - UI pages and navigation
- **Widgets Layer** - Reusable UI components

This separation ensures maintainability and scalability.

---

**Built with Flutter + Back4App | A Complete CRUD Application**

