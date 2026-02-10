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
Module 1: Core SQL & Data Modeling
Focus: DDL, Database Initialization, Schema Design, Constraints

Task 0 – Database Initialization: Create and initialize the library database and switch the active context.
Task 1 – Branch Table Design: Create table for branch details (ID, manager ref, address, contact).
Task 2 – Employee Table Design: Create employees table with Foreign Key links to the Branch table.
Task 3 – Member Table Design: Create members table to track registered users and registration dates.
Task 4 – Audit-Safe IDs: Implement logic to maintain gaps in member IDs (simulating churn) for audit trails.
Task 5 – Book Inventory Design: Create books table using ISBN as a global unique identifier (PK).
Task 6 – Column Standardization: Rename status columns (e.g., inventory_status) to resolve ambiguity.
Task 7 – Issue Transaction Table: Create issued_status table linking Members, Employees, and Boos via Foreign Keys.
Task 8 – Return Transaction Table: Create return_status table to capture return events linked to specific issue records.
Task 9 – Seed Data Insertion: Insert realistic mock data into all tables to simulate operations.
Task 10 – Schema Validation: Validate table structures and relationships using standard SELECT queries.

Module 2: CRUD Operations & Business Analytics
Focus: DML, Joins, Aggregations, Subqueries, CTAS

Data Management
Task 11 – CRUD Operations: Implement Create, Read, Update, and Delete operations across core entities.
Task 12 – Safety Checks: Perform controlled updates by disabling safe-update mode only when necessary.
Task 13 – Data Correction: Use JOIN-based UPDATE statements to fix missing return data (Book names/ISBNs).

Analysis & Reporting
Task 14 – High-Activity Members: Identify members with multiple issued books using GROUP BY and HAVING.
Task 15 – Inventory Analytics (CTAS): Create a derived table tracking issue counts per book.
Task 16 – Advanced Filters: Retrieve books using single-category, multi-category, and IN operators.
Task 17 – Revenue Analysis: Calculate total rental revenue segmented by book category.
Task 18 – Registration Trends: Identify members registered within specific time windows using date arithmetic.
Task 19 – Staff Reporting: List employees with their branch managers using self-joins.
Task 20 – High-Value Inventory: Generate a table of "Premium" books based on price thesholds.
Task 21 – Circulation Check: Identify unreturned books using LEFT JOIN and NULL checks.

Module 3: Production Analytics & Advanced Reporting
Focus: Complex Logic, Window Functions, Stored Procedures, Optimization

Operational Reporting
Task 22 – Overdue Detection: Calculate overdue books based on dynamic return periods.
Task 23 – Fine Calculation Base: Compute the specific number of overdue days for unreturned items.
Task 24 – Member Segmentation (CTAS): Classify members (Active/Inactive) based on recent activity.
Task 25 – Staff Productivity: Rank employees based on successful book issuances.
Task 26 – Real-Time Availability: Determine book status using logic involving both Issue and Return tables.

Financial & Performance Analytics
Task 27 – Branch Revenue: Attribute rental revenue to specific branches via employee handling.
Task 28 – Performance Report: Generate a consolidated summary of Issues, Returns, and Revenue per branch.
Task 29 – Retention Analysis: Use Window Functions to analyze repeat borrowing behavior.
Task 30 – Automation (Procedures): [Planned] Design Stored Procedures to auto-update inventory status.
Task 31 – Penalty Systems: Create a table for overdue fines using per-day penalty logic.

System Maintenance
Task 32 – Data Quality: Handle edge cases (missing IDs, mismatched records) without data corruption.
Task 33 – System Reset: Script to drop and recreate the database to ensure repeatability.
