USE library;

SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM members;
SELECT * FROM return_status;

# CRUD Operations - Create Read Update and Delete 
-- Create a New Book Record
INSERT INTO books ()
VALUES
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

-- Update an Existing Member's Address
UPDATE members
SET
   member_address = '789 Main St'
WHERE member_id = 'C101'; 
# NOTE:- safety update protocol is overwritten when you use primary key for updating 

-- Delete a Record from the Issued Status Table
DELETE FROM issued_status WHERE issued_id = 'IS104';

-- Retrieve All Books Issued by a Specific Employee
SELECT 
issued_member_id,
issued_book_isbn
FROM issued_status 
WHERE issued_emp_id = 'E105'; 

-- Task 01: List Members Who Have Issued More Than One Book
SELECT
issued_member_id, 
COUNT(*) AS "Books_Issued"
FROM issued_status
GROUP BY issued_member_id
HAVING COUNT(issued_member_id) > 1;
# COUNT(*) also count non-null rows, so any entry with some missing data should not get missed.
# Only to use when null carry meanings 


# Use CTAS to generate new tables based on query results - each book and total book_issued_cnt
CREATE TABLE issued_book_cnt AS 
SELECT 
issued_book_name, 
COUNT(issued_book_name) AS 'issued_count'
FROM issued_status
GROUP BY issued_book_name;

# Category Retrival
-- Retrieve All Books in a Specific Category:
SELECT DISTINCT category FROM books;
SELECT * FROM books WHERE category = 'Children';
SELECT * FROM books WHERE category = 'Children' OR category = 'Fiction';
SELECT * FROM books WHERE category IN ('Fantasy', 'Classic', 'History') ORDER BY category;

-- Find Total Rental Income by Category:
SELECT 
Category, 
SUM(rental_price) AS rental_income
FROM books
GROUP BY category
ORDER BY SUM(rental_price) DESC;

-- Task 02. **List Members Who Registered in the Last 180 Days**:
SELECT * FROM members;

# Current Date = 2026-01-24
/*SELECT 
*,
DATEDIFF(current_date, reg_date) AS registered_days
FROM members
WHERE DATEDIFF(current_date, reg_date) > 180;*/

SELECT 
*,
DATEDIFF('2024-06-01', reg_date) AS registered_days
FROM members
WHERE reg_date <= DATE_SUB('2024-06-01', INTERVAL 180 DAY);

-- Task 03: List Employees with Their Branch Manager's Name and their branch details**:

SELECT 
    e.emp_id,
    e.emp_name,
    m.emp_name AS manager_name,
    b.branch_id,
    b.branch_address,
    b.contact_no
FROM employees e
LEFT JOIN branch b
    ON b.branch_id = e.branch_id
LEFT JOIN employees m
    ON m.emp_id = b.manager_id
WHERE e.position <> 'Manager';

-- Task 04. Create a Table of Books with Rental Price Above a Certain Threshold
CREATE TABLE expensive_books AS
SELECT * FROM books WHERE rental_price > 6.50;

-- Task 05: Retrieve the List of Books Not Yet Returned
SELECT
i.issued_id,
i.issued_book_name
FROM issued_status AS i
LEFT JOIN return_status AS r
  ON i.issued_id = r.issued_id
WHERE r.return_id IS NULL;