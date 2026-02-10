# Library-Management-System
Library Management System built using MySQL, modeling real-world library operations with normalized tables, referential integrity, and audit-safe data design. Implements CRUD operations, CTAS, joins, window functions, and date-based analytics for overdue tracking, member activity, and branch performance reporting.
![Schema Screenshot](Library_image.png)

## Objectives

1. **Set up the Library Management System Database**: Create and populate the database with tables for branches, employees, members, books, issued status, and return status.
2. **CRUD Operations**: Perform Create, Read, Update, and Delete operations on the data.
3. **CTAS (Create Table As Select)**: Utilize CTAS to create new tables based on query results.
4. **Advanced SQL Queries**: Develop complex queries to analyze and retrieve specific data.

### 1. Database Design
![Schema Screenshot](Database_Design.jpg)

### 2. Task List 
🟢 Beginner Tasks (Core SQL & Data Modeling)

- Task 0 – Database Initialization - Create and initialize the library database and switch the active context for all operations.

- Task 1 – Branch Table Design - Create the branch table to store branch-level details including branch ID, manager reference, address, and contact information.

Task 2 – Employee Table Design
Create the employees table and link each employee to a branch using a foreign key to enforce referential integrity.

Task 3 – Member Table Design
Create the members table to track registered library members along with their registration dates.

Task 4 – Audit-Safe Member ID Handling
Maintain intentional gaps in member IDs to simulate churn and ensure non-reusable identifiers for audit safety.

Task 5 – Book Inventory Table Design
Create the books table using ISBN as a globally unique identifier and store metadata such as category, author, and rental price.

Task 6 – Resolve Column Ambiguity
Rename the status column to inventory_status to clearly represent inventory availability.

Task 7 – Issue Transaction Table
Create the issued_status table to record book issuance events, linking members, employees, and books via foreign keys.

Task 8 – Return Transaction Table
Create the return_status table to capture book return events linked to issued records.

Task 9 – Seed Data Insertion
Insert realistic seed data into all tables to simulate operational library data.

Task 10 – Schema Validation
Validate table creation and relationships using standard SELECT queries.

🟡 INTERMEDIATE TASKS (CRUD & Business Analytics)
Task 11 – CRUD Operations - Implement Create, Read, Update, and Delete operations across core entities.
Task 12 – Controlled Updates with Safety Checks - Override SQL safety updates only when using primary keys for controlled data modification.
Task 13 – Fix Partial Return Data - Use JOIN-based UPDATE statements to populate missing return book names and ISBNs.
Task 14 – Multi-Issue Member Detection - Identify members who have issued more than one book using GROUP BY and HAVING.
Task 15 – Book Issue Frequency Analysis (CTAS) - Create a derived table using CTAS to store book-wise issue counts.
Task 16 – Category-Based Retrieval - Retrieve books using single-category, multi-category, and IN-based filters.
Task 17 – Category Revenue Analysis - Calculate total rental revenue per category using aggregation.
Task 18 – Recent Member Identification - Identify members registered within a defined time window using date arithmetic.
Task 19 – Employee–Manager Mapping - List employees along with their branch managers and branch details using self-joins.
Task 20 – High-Value Inventory Identification (CTAS) - Create a table of expensive books based on rental price thresholds.
Task 21 – Unreturned Book Detection - Identify books that have been issued but not yet returned using LEFT JOIN and NULL checks.

🔴 ADVANCED TASKS (Production Analytics & Reporting)
Task 22 – Overdue Book Detection - Identify overdue books using issue dates, return periods, and dynamic date calculations.
Task 23 – Overdue Duration Calculation - Compute the number of overdue days for each unreturned book.
Task 24 – Active vs Inactive Member Classification (CTAS) - Classify members based on their most recent activity and generate a derived member status table.
Task 25 – Employee Productivity Ranking - Rank employees based on the number of books issued using aggregation and sorting.
Task 26 – Dynamic Book Availability Logic - Determine real-time book availability using issued and return records with NULL handling.
Task 27 – Branch Revenue Attribution - Map issued books to branches through employees and calculate rental revenue per branch.
Task 28 – Branch Performance Report - Generate a consolidated report showing books issued, books returned, and revenue per branch.
Task 29 – Window Function Analytics = Apply window functions to analyze repeated issuances by members and books.
Task 30 – Stored Procedure Design (Planned) - Design a stored procedure to update book availability automatically on issue and return events.
Task 31 – Overdue Fine Calculation (CTAS) -  Create a CTAS table calculating overdue fines using per-day penalty logic.
Task 32 – Data Quality & Edge Case Handling - Address incomplete data, missing IDs, and mismatched records without corrupting history.
Task 33 – System Validation & Reset - Drop and recreate the database to validate repeatability and schema consistency.

### 3. Final Outcome
This roadmap demonstrates end-to-end SQL system design, combining schema modeling, analytics, audit safety, and production-style reporting—aligned with real Data Analyst and SQL Developer workflows.
