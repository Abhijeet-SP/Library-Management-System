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

#### Data Creation
- **Task01:** Create and initialize the library database and switch the active context for all operations.
- **Task02:** Create `branch`, `members`, `employees`, `books`, `issued_status`, `return_status`.
- **Task03:** Insert the data in each table.
- **Task04:** Resolve Column Ambiguity - Rename the status column to inventory_status to clearly represent inventory availability
- **Task05:** Update the remaining data in `return_status` using Update command

#### CRUD Operations
- **Create**: Inserted sample records into the `books` table.
- **Read**: Retrieved and displayed data from various tables.
- **Update**: Updated records in the `employees` table.
- **Delete**: Removed records from the `members` table as needed.

#### Data Retrival 
- **Task06:** List Members Who Have Issued More Than One Book.
- **Task07:** Use CTAS to generate new tables based on query results - each book and total `book_issued_cnt`.
- **Task08:** Retrieve All Books in a Specific Category.
- **Task09:** List Members Who Registered in the Last 180 Days.
- **Task10:** List Employees with Their Branch Manager's Name and their branch details
- **Task11:** Create a Table of Books with Rental Price Above a Certain Threshold
- **Task12:** Retrieve the List of Books Not Yet Returned
     
#### Advance Query Task
- **Task 13:** Identify Members with Overdue Books. 30 Days of return period. Display the member's name, book title, issue date, and days overdue.
- **Task 14:** CTAS: Create a Table of Active Members. Use the CREATE TABLE AS (CTAS) statement to create a new table member_status containing members  who have issued at least one book in the last 6 months. Mark Other members as non_active reflecting their number of non_active_days days.
- **Task 15:** Find Employees with the Most Book Issues Processed. Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.
- **Task 16:** Update Book Status on Return. Write a query to update the status of books in the books table to "available" when they are returned (based on entries in the return_status table).
- **Task 17:** Branch Performance Report. Create a query that generates a performance report for each branch, showing  the number of books issued, the number of books returned, and the total revenue generated from book rentals.
- **Task 18:** Identify Members Issuing High-Risk Books. Write a query to identify members who have issued books more than twice with the status "damaged" in the books table. Display the member name, book title, and the number of times they've issued damaged books.
- **Task 19:** Stored Procedure. Objective: Create a stored procedure to manage the status of books in a library system. Description: Write a stored procedure that updates the status of a book based on its issuance or return. Specifically: If a book is issued, the status should change to 'no'. If a book is returned, the status should change to 'yes'.
- Task 20: Create Table As Select (CTAS)
Objective: Create a CTAS (Create Table As Select) query to identify overdue books and calculate fines. Description: Write a CTAS query to create a new table that lists each member and the books they have issued but not returned within 30 days. The table should include: The number of overdue books. The total fines, with each day's fine calculated at $0.50. The number of books issued by each member. The resulting table should show: Member ID, Number of overdue books, Total fines.

### 3. Final Outcome
This project goes beyond basic CRUD operations to explore high-level data analytics. Through the use of Window Functions, CTAS, and dynamic filtering, the system provides granular visibility into inventory trends and member behavior. The architecture prioritizes query optimization and data quality, ensuring reliable performance for decision-support workflows
