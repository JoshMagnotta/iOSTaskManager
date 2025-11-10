# Task Manager

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description

Task Manager is an iOS application that allows for users to create categories for different tasks, such as assignments, exams, personal, work. For each category, users can create new tasks, setting due dates and reminders. 

### App Evaluation

- Mobile: 
-- This is not uniquely a mobile experience, this is built on an existing API meaning there could be a web version of this product as well
-- Benefits to using it as a mobile app include real time notifications about upcoming due dates and convience from being able to check upcoming assignments on your phone as well
- Story: 
-- The value includes convience, being able to check status from your phone and being notified
-- Peers currently use similar versions to keep track of assignments
- Market: 
-- This is a growing market with potential users being students and corporate workers
-- Competitors could include Notion, but with Notion you have to create a page from scratch and is not user friendly. This aims to make the process easier
- Habit: 
-- If people want to stay on top of their upcoming tasks, this will be an app that is used freqently
- Scope: 
-- The scope is well defined
-- It will not be too technically challenging, slight tweaks will be made to the API, but they will not be time consuming
-- This app will be able to use built in components 

## Milestone 2 Status
Videos | Library | Loom - 10 November 2025 - Watch Video

https://www.loom.com/share/a24de1b5051a4b858a785a95aea687f0

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [x] As a user, I want to create different categories, so that I can seperate different tasks
- [ ] As a user, I want to create tasks and assign it to a category, so that I can group tasks together
- [ ] As a user, I want to set due dates for tasks, so I can keep track of when things need to be done by
- [ ] As a user, I want to be able to view all assignments in a list view, so I can look at my upcoming assignments in a list
- [ ] As a user, I want to be able to view all assignments in a calendar view, so I can look at my upcoming assignments in a calendar
- [x] As a developer, I want to enable data persistance by using user defaults so that the user can have persistant data

**Optional Nice-to-have Stories**


- [ ] As a developer, I want to enable push notifications so that users can be informed without opening the app
- [ ] As a developer, I want to enable data persistance across devices by using a database to store data
- [ ] As a developer, I want to enable account creation that can be logged into the same account from multiple devices
- [ ] As a user, I want to change settings such as how often to be notified, so that I can be in control of notifications
- [ ] As a user, I want to be able to change account details, so I can reset my password or change my email when necessary

### 2. Screen Archetypes

- [ ] Home Screen
* As a user, I want to create different categories, so that I can seperate different tasks
* As a user, I want to create tasks and assign it to a category, so that I can group tasks together
* As a user, I want to set due dates for tasks, so I can keep track of when things need to be done by
- [ ] List View
* As a user, I want to be able to view all assignments in a list view, so I can look at my upcoming assignments in a list
- [ ] Calendar View
* As a user, I want to be able to view all assignments in a calendar view, so I can look at my upcoming assignments in a calendar

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home
* List View
* Assignment View

**Flow Navigation** (Screen to Screen)

- [ ] Home
* Create Task
* Create Category
- [ ] List View
- View all tasks in chronological order
- View task grouped by category
* [ ] Calendar View
* View tasks in chronological order, on a calendar view

## Wireframes

<img src="https://i.imgur.com/sSsMKxB.jpeg" width=600>

## Schema 

[This section will be completed in Unit 9]

### Models

[Add table of models]

### Networking

- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
