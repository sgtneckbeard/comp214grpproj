# Group assignment for COMP 214 Advanced Database Structures
## Team members:
## Yusuf Bilgic, Nathan Heung, Hyeri Kim, Pedro Huerta

#

## To do list:
~~At least one sequence~~
### (YUSUF) Add movie-genre bridge table
### (YUSUF) Add description field to MM_MOVIES
### 1. Minimum 2 indexes:
- 1. MM_Ratings **(NATHAN)**
- 2. MM_Movies **(NATHAN)**
- 3. MM_Actors **(NATHAN)**
### 2. Minimum 2 triggers:
- Data entry, updating, Trigger to update ratings, error logging
- 1. Add log error table **(PEDRO)** 
- 2. Update average rating **(NATHAN)** **(PEDRO)**
### 3. Minimum 2 procedures
- include exceptions, cursors
- 1. Add new movie procedures **(HYERI)**
- 2. Get top rated movies procedure **(HYERI)**
- 3. Update movie description **(HYERI)**
### 4. Minimum 2 functions:
- include exceptions
- 1. Get all movies from one actor function **(YUSUF)**
- 2. Get all movies from one genre function **(YUSUF)**
### 5. Packages:
- Using at least 2x procedures, 2x functions
- 1. "MM_MANAGER_PKG" package (adding new movies) **(PEDRO)** 
### 6. Global, private variables / constructs **(PEDRO)**
