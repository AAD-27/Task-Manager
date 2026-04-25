# Task Manager App - Complete Setup Guide

## 📋 Table of Contents
1. [Prerequisites](#prerequisites)
2. [Back4App Configuration](#back4app-configuration)
3. [Flutter Setup](#flutter-setup)
4. [Running the App](#running-the-app)
5. [Troubleshooting](#troubleshooting)
6. [Building for Deployment](#building-for-deployment)

---

## Prerequisites

### Required Software
- **Flutter SDK** (>= 3.0.0)
- **Dart SDK** (included with Flutter)
- **Android Studio** or **Visual Studio Code**
- **Git** for version control
- **Back4App Account** (Free tier available)

### Installation Steps

#### Windows Installation

1. **Install Flutter**
   - Download from https://flutter.dev/docs/get-started/install/windows
   - Extract to a folder (e.g., `C:\flutter`)
   - Add to PATH:
     ```cmd
     setx PATH "%PATH%;C:\flutter\bin"
     ```
   - Verify installation:
     ```cmd
     flutter --version
     flutter doctor
     ```

2. **Install Android Studio**
   - Download from https://developer.android.com/studio
   - Follow installation wizard
   - Accept SDK licenses:
     ```cmd
     flutter doctor --android-licenses
     ```

3. **Verify Setup**
   ```cmd
   flutter doctor
   ```
   All items should show checkmarks (✓)

---

## Back4App Configuration

### Step 1: Create Back4App Account

1. Go to https://www.back4app.com/
2. Click **Sign Up**
3. Fill in your details (use your student email)
4. Verify email
5. Create a new app:
   - Click **Create New App**
   - Name it: `TaskManager`
   - Select region (default is fine)

### Step 2: Get API Credentials

1. Go to your **App Dashboard**
2. Click **Settings** (bottom left)
3. Click **Keys** tab
4. Copy these values:
   - **Application ID** (Save this)
   - **Client Key** (Save this)
   - **Server URL**: `https://parseapi.back4app.com`

### Step 3: Create Task Class in Database

1. In your app dashboard, click **Database**
2. Click **Core** (first tab)
3. Click **Create a new Class** button
4. Name it exactly: `Task`
5. Click **Create**
6. Add these fields:
   - Click **+Add a Column**
   
   **Field 1: title**
   - Column Name: `title`
   - Column Type: `String`
   - Click **Create Column**
   
   **Field 2: description**
   - Column Name: `description`
   - Column Type: `String`
   - Click **Create Column**
   
   **Field 3: isCompleted**
   - Column Name: `isCompleted`
   - Column Type: `Boolean`
   - Default Value: `false`
   - Click **Create Column**
   
   **Field 4: userId**
   - Column Name: `userId`
   - Column Type: `String`
   - Click **Create Column**

7. Set Permissions:
   - Click **CLPs** (Class Level Permissions)
   - Make sure appropriate permissions are set for user data

### Step 4: Update App Credentials

1. Open the project in your IDE
2. Navigate to: `lib/services/back4app_service.dart`
3. Replace these lines:
   ```dart
   static const String parseAppId = 'YOUR_APP_ID_HERE';
   static const String parseClientKey = 'YOUR_CLIENT_KEY_HERE';
   ```
   
   With your actual credentials:
   ```dart
   static const String parseAppId = 'abcdef1234567890...';
   static const String parseClientKey = 'xyz9876543210...';
   ```

⚠️ **Security Warning**: Never commit credentials to public repositories!

---

## Flutter Setup

### Step 1: Clone/Open Project

```cmd
cd "D:\Ameya\BITS\Cross API\Cross Platform API Dev"
```

### Step 2: Get Dependencies

```cmd
flutter pub get
```

This command:
- Downloads all required packages
- Updates `pubspec.lock` file
- Prepares the project for running

### Step 3: Verify Setup

```cmd
flutter doctor
```

Expected output:
```
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, x.x.x, ...)
[✓] Android toolchain - develop for Android devices
[✓] Android Studio (version x.x.x)
[✓] VS Code (version x.x.x)
[✓] Connected device (x devices connected)
```

---

## Running the App

### Option 1: On Android Emulator

1. **Start Emulator**
   ```cmd
   emulator -avd <emulator_name>
   ```

2. **List Available Devices**
   ```cmd
   flutter devices
   ```

3. **Run App**
   ```cmd
   flutter run
   ```

### Option 2: On Physical Device

1. **Enable USB Debugging** on your Android device:
   - Settings → About Phone
   - Tap "Build Number" 7 times
   - Go back, open Developer Options
   - Enable "USB Debugging"

2. **Connect Device via USB**

3. **Verify Connection**
   ```cmd
   flutter devices
   ```

4. **Run App**
   ```cmd
   flutter run
   ```

### Option 3: Release Build (Optimized)

```cmd
flutter run --release
```

---

## App Testing Workflow

### 1. Test Registration
1. Launch app
2. Click **Register here** link
3. Enter test email: `test@example.com`
4. Enter password: `password123`
5. Confirm password: `password123`
6. Click **Register**
7. See success message

### 2. Test Login
1. From login screen
2. Enter email: `test@example.com`
3. Enter password: `password123`
4. Click **Login**
5. Should see Task List Screen

### 3. Test Create Task
1. Click **+** (FAB button)
2. Enter title: "My First Task"
3. Enter description: "This is a test task"
4. Click **Create**
5. Task appears in list

### 4. Test Read Tasks
1. Return to task list
2. Pull down to refresh
3. All tasks display with status

### 5. Test Update Task
1. Click **edit** icon on task
2. Modify title or description
3. Click **Update**
4. Changes save immediately

### 6. Test Delete Task
1. Click **delete** icon on task
2. Or click delete in task edit screen
3. Confirm deletion
4. Task removed from list

### 7. Test Toggle Complete
1. Click checkbox on task
2. Task marked as complete (strikethrough)
3. Status shows "✅ Completed"

### 8. Test Logout
1. Click **logout** icon (top right)
2. Confirm logout
3. Redirected to login screen

---

## Troubleshooting

### Problem: "Flutter command not found"
**Solution:**
```cmd
# Add Flutter to PATH temporarily
set PATH=%PATH%;C:\path\to\flutter\bin
flutter --version
```

### Problem: "No devices found"
**Solution:**
1. Check emulator is running: `emulator -list-avds`
2. Or connect physical device with USB debugging
3. Try: `flutter devices`

### Problem: "Back4App Connection Failed"
**Solution:**
1. Check credentials in `back4app_service.dart`
2. Verify Back4App app is active in dashboard
3. Check internet connection
4. Test with: `flutter run -v` (verbose mode)

### Problem: "Registration/Login Fails"
**Solution:**
1. Ensure email format is valid
2. Check password is at least 6 characters
3. Verify "Task" class exists in Back4App
4. Check database permissions in Back4App

### Problem: "Tasks Not Appearing"
**Solution:**
1. Try pull-to-refresh on task list
2. Verify user is logged in correctly
3. Check Back4App database has tasks
4. Verify `userId` field is being set

### Problem: "App Crashes on Startup"
**Solution:**
```cmd
# Run in verbose mode to see errors
flutter run -v

# Check logs
flutter logs
```

### Problem: "Gradle Build Failed"
**Solution:**
```cmd
# Clean build
flutter clean
flutter pub get
flutter run
```

---

## Building for Deployment

### Android APK (Debug)

```cmd
flutter build apk --debug
```
Output: `build/app/outputs/apk/debug/app-debug.apk`

### Android APK (Release)

1. **Generate Key** (first time only):
   ```cmd
   keytool -genkey -v -keystore c:\keys\key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```

2. **Build Release APK**:
   ```cmd
   flutter build apk --release
   ```
Output: `build/app/outputs/apk/release/app-release.apk`

### Android App Bundle (for Google Play)

```cmd
flutter build appbundle --release
```
Output: `build/app/outputs/bundle/release/app-release.aab`

### iOS (macOS only)

```cmd
flutter build ios --release
```

---

## Project Structure Reference

```
lib/
├── main.dart                          # Entry point
├── models/
│   └── task.dart                      # Task data model
├── screens/
│   ├── login_screen.dart              # Login UI
│   ├── register_screen.dart           # Registration UI
│   ├── task_list_screen.dart          # Main task list
│   └── task_form_screen.dart          # Create/Edit task
├── services/
│   └── back4app_service.dart          # Back4App API wrapper
└── widgets/
    └── task_card.dart                 # Task display widget
```

---

## Important Security Notes

⚠️ **DO NOT:**
- Commit API credentials to GitHub
- Share Back4App credentials
- Use weak passwords in production
- Store sensitive data unencrypted

✅ **DO:**
- Use environment variables for credentials (in production)
- Rotate credentials regularly
- Enable two-factor authentication on Back4App
- Review database permissions

---

## Next Steps

1. ✅ Complete Back4App setup
2. ✅ Configure app credentials
3. ✅ Test all CRUD operations
4. ✅ Record video demonstration (2 minutes):
   - Show registration
   - Show login
   - Show task creation
   - Show task update
   - Show task deletion
   - Show logout
5. ✅ Push code to GitHub with README
6. ✅ Add screenshots to README

---

## Additional Resources

- **Flutter Docs**: https://flutter.dev/docs
- **Back4App Docs**: https://www.back4app.com/docs
- **Parse SDK**: https://pub.dev/packages/parse_server_sdk_flutter
- **Material Design**: https://material.io/design
- **Firebase vs Back4App**: https://www.back4app.com/docs/advanced/faq

---

## Support & Help

For issues:
1. Check Console Logs: `flutter logs`
2. Enable Verbose Mode: `flutter run -v`
3. Check Back4App Dashboard Status
4. Review error messages carefully
5. Search error online

---

**Last Updated**: April 2026
**Status**: Ready for Production ✅

