-- Create the library database
CREATE DATABASE library;

-- Use the library database
USE library;

-- Create the Branch table
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);

-- Create the Employee table
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(255),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

-- Create the Customer table
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(255),
    Customer_address VARCHAR(255),
    Reg_date DATE
);

-- Create the IssueStatus table

    CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book INT,
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

-- Create the ReturnStatus table
CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 INT,
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

-- Create the Books table
CREATE TABLE Books (
    ISBN INT PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(50),
    Rental_Price DECIMAL(10, 2),
    Status VARCHAR(3),
    Author VARCHAR(255),
    Publisher VARCHAR(255)
    );
-- Insert values into the Branch table
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES
    (1, 101, '123 Main St', '555-1234'),
    (2, 102, '456 Oak St', '555-5678'),
    (3, 103, '789 Maple St', '555-9876'),
    (4, 104, '321 Birch St', '555-4321');

-- Insert values into the Employee table
INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no)
VALUES
    (201, 'John Doe', 'Manager', 50001.00, 1),
    (202, 'Jane Smith', 'Clerk', 40000.00, 2),
    (203, 'Bob Johnson', 'Assistant Manager', 45000.00, 3),
    (204, 'Alice Williams', 'Librarian', 42000.00, 4);

-- Insert values into the Customer table
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES
    (301, 'Alice Johnson', '789 Elm St', '2023-01-15'),
    (302, 'Bob Williams', '101 Pine St', '2023-02-20'),
    (303, 'Charlie Davis', '555 Cedar St', '2023-03-10'),
    (304, 'Diana Miller', '222 Oak St', '2023-04-05');

-- Insert values into the Books table
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES
    (1001, 'Introduction to SQL', 'Programming', 10.99, 'Yes', 'John Smith', 'Tech Books'),
    (1002, 'Data Structures and Algorithms', 'Computer Science', 12.99, 'Yes', 'Jane Doe', 'Science Press'),
    (1003, 'The Great Gatsby', 'Fiction', 8.99, 'Yes', 'F. Scott Fitzgerald', 'Classic Books'),
    (1004, 'Chemistry Essentials', 'Science', 15.99, 'Yes', 'Emma Johnson', 'Chemistry Publications');
    
    -- Insert values into the IssueStatus table
INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES
    (101, 301, 'Introduction to SQL', '2023-05-15', 1001),
    (102, 302, 'Data Structures and Algorithms', '2023-06-20', 1002),
    (103, 303, 'The Great Gatsby', '2023-04-10', 1003),
    (104, 304, 'Chemistry Essentials', '2023-07-05', 1004);

 -- Insert values into the ReturnStatus table
INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES
    (501, 301, 'Introduction to SQL', '2023-07-10', 1001),
    (502, 302, 'Data Structures and Algorithms', '2023-08-15', 1002),
    (503, 303, 'The Great Gatsby', '2023-06-20', 1003),
    (504, 304, 'Chemistry Essentials', '2023-09-05', 1004);
    
    -- 1. Retrieve the book title, category, and rental price of all available books.
SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

-- 2. List the employee names and their respective salaries in descending order of salary.
SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

-- 3. Retrieve the book titles and the corresponding customers who have issued those books.
SELECT b.Book_title, i.Issued_cust AS Customer_Id, c.Customer_name
FROM IssueStatus i
JOIN Books b ON i.Isbn_book = b.ISBN
JOIN Customer c ON i.Issued_cust = c.Customer_Id;


-- 4. Display the total count of books in each category.
SELECT Category, COUNT(*) AS Total_Count
FROM Books
GROUP BY Category;

-- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

-- 6. List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-01-01' AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

-- 7. Display the branch numbers and the total count of employees in each branch.
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no;

-- 8. Display the names of customers who have issued books in the month of June 2023.
SELECT DISTINCT c.Customer_name
FROM Customer c
JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust
WHERE MONTH(i.Issue_date) = 6 AND YEAR(i.Issue_date) = 2023;

-- 9. Retrieve book_title from book table containing history.
SELECT Book_title
FROM Books
WHERE Category = 'History';
