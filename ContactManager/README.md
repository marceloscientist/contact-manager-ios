# 📱 Contact Manager - iOS + Node.js API

A professional offline-first contact management application built with Swift (iOS) and Node.js backend, designed to simulate real-world mobile architecture with synchronization, caching, and asynchronous processing.

---

# 🚀 Architecture Overview

This project follows an **offline-first architecture** with async synchronization:

```
iOS App (CoreData)
   ↓
Sync Layer
   ↓
Node.js API
   ↓
Message Queue (RabbitMQ)
   ↓
Worker Processing
   ↓
MongoDB Atlas
```

---

# 🧠 Tech Stack

## 📱 Mobile
- SwiftUI
- CoreData
- MVVM Architecture

## 🌐 Backend (planned)
- Node.js (Express)
- MongoDB Atlas

## 📬 Async Processing (planned)
- RabbitMQ (CloudAMQP)

## 🌎 External APIs
- ViaCEP

---

# 📦 Roadmap

## ✅ Phase 1 - Local App
- CRUD Contacts
- CoreData
- Validation

## ⏳ Phase 2 - Backend
- REST API
- Basic CRUD

## ⏳ Phase 3 - Integration
- MongoDB
- ViaCEP + Cache

## ⏳ Phase 4 - Sync
- Offline-first sync

## ⏳ Phase 5 - Messaging
- RabbitMQ

## ⏳ Phase 6 - Advanced
- Photos
- Device integration
- Analytics

---

# 🔁 Sync Strategy (planned)

- Local persistence
- Flag `pendingSync`
- Background sync

---

# 📂 Project Structure

## iOS
```
/App
  /Presentation
  /Domain
  /Data
```

## Backend (planned)
```
/src
  /modules
  /services
  /repositories
```

---

# 🌿 Branch Strategy

- main → stable
- develop → integration
- feature/* → incremental development

---

# 👤 Author

Marcelo de Carvalho Santana  
Solution Consultant III | Capgemini
