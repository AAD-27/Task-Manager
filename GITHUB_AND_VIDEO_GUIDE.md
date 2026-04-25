# GitHub Deployment Guide

## Step 1: Initialize Git Repository

```powershell
cd "D:\Ameya\BITS\Cross API\Cross Platform API Dev"
git init
git config user.name "Your Name"
git config user.email "your.email@example.com"
```

## Step 2: Create .gitignore

```powershell
# Add Flutter-specific files to ignore
echo "build/" | Out-File -Append .gitignore
echo ".dart_tool/" | Out-File -Append .gitignore
echo ".flutter-plugins" | Out-File -Append .gitignore
echo ".flutter-plugins-dependencies" | Out-File -Append .gitignore
echo ".packages" | Out-File -Append .gitignore
echo "pubspec.lock" | Out-File -Append .gitignore
echo "*.swp" | Out-File -Append .gitignore
echo ".DS_Store" | Out-File -Append .gitignore
echo "*.iml" | Out-File -Append .gitignore
echo ".idea/" | Out-File -Append .gitignore
```

## Step 3: Add and Commit Files

```powershell
git add .
git commit -m "Initial commit: Task Manager App with Back4App BaaS integration

- User authentication (register, login, logout)
- Task CRUD operations (create, read, update, delete)
- Real-time cloud database synchronization
- Material Design UI with responsive layout
- Back4App backend integration"
```

## Step 4: Create GitHub Repository

1. Go to https://github.com/new
2. Repository name: `flutter-task-manager-app`
3. Description: `Flutter Task Manager App with Back4App (BaaS) - CRUD Application`
4. Make it **Public** (for assignment review)
5. Click "Create repository"

## Step 5: Push to GitHub

```powershell
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/flutter-task-manager-app.git
git push -u origin main
```

## Step 6: Add Screenshots to GitHub

Create a `screenshots/` folder and add:
- `login_screen.png` - Login/Registration screen
- `task_list_screen.png` - Task list view
- `task_creation_screen.png` - Task creation form
- `task_completed_screen.png` - Completed tasks view

```powershell
mkdir screenshots
# Add screenshots to this folder
git add screenshots/
git commit -m "Add screenshots for documentation"
git push
```

## Step 7: Verify Everything on GitHub

Your repository should have:
- ✅ All source code (lib/, pubspec.yaml, etc.)
- ✅ README.md with project description
- ✅ Screenshots in screenshots/ folder
- ✅ FINAL_SETUP_INSTRUCTIONS.md
- ✅ .gitignore for Flutter

---

## YouTube Video Checklist

Before recording, ensure:
- [ ] App compiles without errors
- [ ] You have a test account created
- [ ] You have sample data to work with
- [ ] Screen recording software installed (OBS Studio recommended - free)
- [ ] Good lighting and clear audio

### Recording Settings
- Resolution: 1080p or 720p
- Duration: 2 minutes maximum
- Format: MP4
- Audio: Clear narration or silent with subtitles

### Video Content Checklist
- [ ] 0:00-0:15 - Show login screen, navigate to register
- [ ] 0:15-0:30 - Register with new email
- [ ] 0:30-0:45 - Login with credentials
- [ ] 0:45-1:15 - Create 2-3 tasks
- [ ] 1:15-1:30 - Toggle task completion (checkbox)
- [ ] 1:30-1:45 - Edit a task
- [ ] 1:45-1:55 - Delete a task
- [ ] 1:55-2:00 - Logout

### Upload to YouTube
1. Go to https://youtube.com/upload
2. Upload your video file
3. Title: `Flutter Task Manager App - Back4App CRUD Demo`
4. Description:
```
Flutter Task Manager Application with Back4App Backend-as-a-Service (BaaS)

This video demonstrates:
- User authentication (registration, login, logout)
- Task management (create, read, update, delete)
- Real-time cloud database synchronization
- Material Design UI

GitHub: [Your GitHub Repo Link]

Technology Stack:
- Frontend: Flutter (Dart)
- Backend: Back4App (Parse Server)
- Database: Back4App Cloud Database
```
5. Tags: Flutter, Back4App, CRUD, BaaS, Dart
6. Category: Science & Technology
7. Set to "Unlisted" or "Public"
8. Copy the video URL

---

## Final Submission Checklist

- [ ] Flutter app runs without errors
- [ ] All CRUD operations work correctly
- [ ] GitHub repository is public and complete
- [ ] README.md is comprehensive
- [ ] Screenshots are in repository
- [ ] YouTube video is uploaded and linked
- [ ] Video shows all 4 CRUD operations + login/logout
- [ ] Code has no compilation errors (`flutter analyze` passes)
- [ ] Dependencies are properly installed (`flutter pub get`)

---

## Quick Commands Reference

```powershell
# Check app for errors
flutter analyze

# Get dependencies
flutter pub get

# Run app on default device
flutter run

# Run app on specific device
flutter run -d <device-id>

# List available devices
flutter devices

# Build release APK
flutter build apk --release

# Build for web
flutter build web

# Clean build
flutter clean

# Update dependencies
flutter pub upgrade
```

---

## Troubleshooting Git Issues

### Push fails with "rejected"
```powershell
git pull origin main
git push origin main
```

### Want to change commit message
```powershell
git commit --amend -m "New message"
git push --force origin main
```

### Reset to last commit (if messed up)
```powershell
git reset --hard HEAD
```

---

**You're all set! Your app is production-ready.**

