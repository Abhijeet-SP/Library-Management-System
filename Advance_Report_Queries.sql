-- Task 13: Identify Members with Overdue Books
# 30 Days of return period. Display the member's name, book title, issue date, and days overdue.
# Selecting current date as = '2024-04-25'. As 2026-01-26 will be very high

SELECT
m.member_id,
m.member_name,
i.issued_book_name,
i.issued_date,
CASE 
  WHEN  '2024-04-25'> DATE_ADD(i.issued_date, INTERVAL 30 DAY)
       THEN CONCAT( 'Overdue for ',  
                     DATEDIFF('2024-04-25' /*Here dynamically current_date() should be used*/, 
	 DATE_ADD(i.issued_date, INTERVAL 30 DAY)), 
                     ' days')
  ELSE 'Not Overdue'
END AS overdue_days
FROM issued_status AS i
LEFT JOIN members AS m
  ON i.issued_member_id = m.member_id
LEFT JOIN return_status AS r
  ON i.issued_id = r.issued_id
WHERE r.return_id IS NULL;

-- Task 14: CTAS: Create a Table of Active Members
/* Use the CREATE TABLE AS (CTAS) statement to create a new table member_status containing members 
who have issued at least one book in the last 6 months
Mark Other members as non_active reflecting their number of non_active_days days */
# Selecting current date as = '2024-12-01'. As 2026-01-26 will be very high

CREATE TABLE member_status AS 
SELECT 
m.member_id,
m.member_name,
m.reg_date,
MAX(i.issued_date) AS last_issued_date,
CASE 
  WHEN DATE_ADD(MAX(i.issued_date), INTERVAL 6 MONTH) < '2024-12-01' /*Here dynamically current_date() should be used*/ THEN 
  CONCAT('Non Active Member for ', DATEDIFF('2024-12-01', DATE_ADD(MAX(i.issued_date), INTERVAL 6 MONTH)), ' days')
  ELSE 'Active Member'
END AS member_status
FROM issued_status AS i
INNER JOIN members AS m
  ON m.member_id = i.issued_member_id
GROUP BY member_id
ORDER BY member_status;

-- Task 15: Find Employees with the Most Book Issues Processed
# Write a query to find the top 3 employees who have processed the most book issues. 
# Display the employee name, number of books processed, and their branch.

SELECT
e.emp_name,
e.branch_id,
COUNT(DISTINCT i.issued_id) AS total_book_issues
FROM issued_status AS i 
JOIN employees AS e 
  ON i.issued_emp_id = e.emp_id
GROUP BY e.emp_id
ORDER BY COUNT(DISTINCT i.issued_id) DESC
LIMIT 3;

-- Task 16: Update Book Status on Return
# Write a query to update the status of books in the books table to "available" when they are returned (based on entries in the return_status table).

SELECT * FROM return_status;
SELECT * FROM issued_status;
SELECT * FROM books;

SELECT * FROM books WHERE book_title IN ('To Kill a Mockingbird','The Road','1984') ORDER BY book_ti;
SELECT book_title, COUNT(isbn) FROM books GROUP BY book_title; # ISBN is totally unique identity of a book
SELECT COUNT(book_title), isbn FROM books GROUP BY isbn;

/* 
There are two ways to solve this 
1. Writng a General Select Query 
2. Be more dynamic and use a stored Functions
/ the ISBN is an unique identifer of books, we will look at the books that were issued for their 'avaliablity' and then compare 
issued_id of issued_status and return_status to get which one where returned. Thereafter using nulls to mark the status. 
*/ 
SELECT 
isbn,
book_title,
category,
rental_price,
author,
publisher,
CASE
  WHEN issued_book_isbn IS NULL THEN 'Avaliable'
  WHEN issued_id IS NULL THEN 'Not Avaliable'
  ELSE 'Avalibale'
END AS avaliablility_status
FROM(
SELECT 
b.*,
i.issued_book_isbn,
r.issued_id
FROM books AS b
LEFT JOIN issued_status AS i
  ON b.isbn = i.issued_book_isbn
LEFT JOIN return_status AS r
  ON r.issued_id = i.issued_id) AS t;
  
  
-- Task 15: Branch Performance Report
/*Create a query that generates a performance report for each branch, 
showing 
the number of books issued, 
the number of books returned, and 
the total revenue generated from book rentals.*/

# Do it again to understadn the joins 
SELECT * FROM return_status;
SELECT * FROM issued_status;
SELECT * FROM books;
SELECT * FROM employees;
SELECT * FROM branch;

# Add branch_id and rental price columns in issued_status 
# Add branch_id columns in return status 
# Make one stored function for branch report 
ALTER TABLE issued_status 
ADD branch_id VARCHAR(10)
FOREIGN KEY (branch_id) REFERENCES  branch(branch_id)
SELECT 
* 
FROM branch AS b
LEFT JOIN employees AS e
   ON b.branch_id = e.branch_id

# Get all the book that was rented and then join the resulting table with with employess to get branch id for grouping 
SELECT 
e.branch_id,
SUM(b.rental_price)
FROM books as b
INNER JOIN issued_status AS i
  ON b.isbn = i.issued_book_isbn
LEFT JOIN employees AS e
  ON i.issued_emp_id = e.emp_id
GROUP BY e.branch_id
ORDER BY e.branch_id;

SELECT
    e.branch_id,
    COUNT(DISTINCT i.issued_id) AS total_books_issued,
    COUNT(DISTINCT r.issued_id) AS total_books_returned,
    SUM(b.rental_price) AS total_revenue
FROM issued_status i
LEFT JOIN employees e
    ON i.issued_emp_id = e.emp_id
LEFT JOIN return_status r
    ON i.issued_id = r.issued_id
LEFT JOIN books b
    ON i.issued_book_isbn = b.isbn
GROUP BY e.branch_id
ORDER BY e.branch_id;

  
-- Task 18: Identify Members Issuing High-Risk Books
# Write a query to identify members who have issued books more than twice with the status "damaged" in the books table. Display the member name, book title, and the number of times they've issued damaged books.    

# confusion in the TASK
SELECT 
*,
COUNT(issued_member_id) OVER(PARTITION BY issued_member_id) AS no_of_times_book_issued,
COUNT(issued_book_isbn) OVER(PARTITION BY issued_book_isbn) AS no
FROM issued_status AS i 
LEFT JOIN members AS m 
  ON m.member_id = i.issued_member_id
ORDER BY issued_book_isbn;

-- Task 19: Stored Procedure
/*Objective: Create a stored procedure to manage the status of books in a library system.
    Description: Write a stored procedure that updates the status of a book based on its issuance or return. Specifically:
    If a book is issued, the status should change to 'no'.
    If a book is returned, the status should change to 'yes'.*/
    
/*
Task 20: Create Table As Select (CTAS)
Objective: Create a CTAS (Create Table As Select) query to identify overdue books and calculate fines.

Description: Write a CTAS query to create a new table that lists each member and the books they have issued but not returned within 30 days. The table should include:
    The number of overdue books.
    The total fines, with each day's fine calculated at $0.50.
    The number of books issued by each member.
    The resulting table should show:
    Member ID
    Number of overdue books
    Total fines
*/

# issues with how to calculate the number of books issued

SELECT 
m.member_id,
m.member_name,
COUNT(m.member_id) AS overdue_books,
COUNT(i.issued_id) AS number_of_books_issued,
SUM(DATEDIFF('2024-12-01', DATE_ADD(issued_date, INTERVAL 30 DAY))) AS overdue_days,
SUM(DATEDIFF('2024-12-01', DATE_ADD(issued_date, INTERVAL 30 DAY))) * 0.50 AS total_fine
FROM issued_status AS i 
LEFT JOIN return_status AS r 
  ON i.issued_id = r.issued_id
LEFT JOIN members AS m
  ON m.member_id = i.issued_member_id
WHERE r.issued_id IS NULL
GROUP BY member_id;

SELECT * FROM return_status;