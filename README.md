# 🚗 Mechanic Service & Request Management System

## 📱 Project Overview
A full-stack mobile application that connects drivers with mechanics. Drivers can submit service requests, while mechanics receive and manage them through a dedicated interface.

The system handles request distribution, scheduling, and lifecycle management using Firebase Cloud Functions, while the mobile app provides both driver and mechanic frontends with real-time synchronization.

---

## ✨ Key Features

### 👨‍✈️ Driver Side
- 📥 Submit mechanical service requests
- 📍 Share location using Google Maps
- 📊 Track request status in real-time

### 🔧 Mechanic Side
- 📋 View incoming assigned requests
- ✅ Accept / reject / update request status
- 🧭 Navigate to customer location via Google Maps
- 📱 Dedicated UI dashboard for mechanics

### ⚙️ System Features
- ⚙️ Automatic request distribution using Firebase Cloud Functions
- 📅 Scheduled jobs to clean or update pending requests
- 🔄 Real-time sync using Firestore
- 🔔 Live notifications and status updates

---

## 🛠️ Tech Stack
- Flutter (Driver + Mechanic Apps UI)
- Dart
- Firebase Firestore
- Firebase Authentication
- Firebase Cloud Functions (TypeScript)
- Firebase Cloud Scheduler
- Google Maps API

---

## 🧠 What I Learned
- Designing full-stack mobile architecture (client + backend)
- Building role-based applications (Driver / Mechanic)
- Using Firebase Cloud Functions for backend automation
- Managing real-time synchronization with Firestore
- Integrating Maps and location-based services
- Structuring scalable Flutter applications

---

## ⚙️ System Workflow
1. Driver submits a request  
2. Cloud Function processes and assigns mechanic  
3. Mechanic receives request in real-time  
4. Mechanic updates request status (accept / complete)  
5. Scheduler handles cleanup of pending or expired requests  
6. All updates sync instantly across both apps  

---

## 🎯 Project Type
Full-Stack Mobile Application (Flutter + Firebase Backend)

---

## 🚀 Future Improvements
- Chat system between driver and mechanic  
- Payment integration  
- Rating & review system  
- Smart mechanic assignment algorithm  

---

## 📌 Author
**Owis Ahmad Samih Abu Zaidan**  
CIS Student | Full-Stack Flutter Developer | Firebase Specialist  

- 📧 Email: your-email@example.com  
- 💼 LinkedIn: https://www.linkedin.com/in/owis-zaidan-b6aa4b370
