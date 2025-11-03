---
title: brainstorming

---

# Step 1

## Weather
The weather app is a classic example of a first app to build. This will pull from a public API such as AccuWeather and will display the current weather, 7 day forecast, and radar for a specifed location. The default location will be the users current location, and they have the option to view the weather forecast for other locations as well. 

## Task Manager
The Task Manager will keep track of a users tasks, the app will be built in a way that allows for customization. The user will be able to create custom seperate categories, such as Assignments, Exams, Personal, etc. This will use a custom API that I have already developed and is already being hosted. Integrating this API will also allow for data persistance across devices, as the API is connected to a Postgres database. 

## Blog
The Blog app will allow for authors who are authenticated to post a blog, and all users will be able to view these blogs. This will use a custom API already developed by me and is actively being hosted. 

## 704 Weekender
The 704 Weekender will show upcoming events in the Charlotte area, this will pull from public APIs to find events such as Eventbrite, TicketMaster, and allow users to filter by category. 

## Campus Parking
Campus Parking will allow users to view the current availability in parking decks on campus, and provide all information about PaTS (Parking and Transportation Services); including delays and disruptions to campus. Parking availability will pull from an university API, other information may have to be static unless another endpoint is found. 

## Roommate Matcher
Roommate Matcher will allow users to find other students at their university to live with. When creating their account, users will answer a questionaire, and an algorithm will pair roommates based on responses. This will use a custom API developed by me. 



# Step 2


## The Top Two

### Task Manager
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

### Campus Parking
- Mobile: 
-- This is not uniquely a mobile experience, but allowing for an app vs a website allows ease of access to check parking availability with a click of a button
- Story: 
-- This adds a clear value, students complain about having to search to find availability, or not even knowing that you can check the availability online
- Market: 
-- The market includes all UNC Charlotte students who drive to campus
-- This does provide a huge value by making it easier to check, thus finding parking quicker
- Habit: 
-- This has the potential to be used everytime a student is commuting to campus
- Scope:
-- The scope is well formed, the only potential issue is whether all of the existing APIs are public

## Final Decision
### Task Manager
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