# crm-T-sql-server

This repository provides a comprehensive tutorial on SQL for a CRM (Customer Relationship Management) system. It covers various SQL topics and provides example code and common use cases for each topic.

## Topics Covered

### 1. Intro to SQL Query, Data Definition

###Introduction to SQL
SQL stands for Structured Query Language and is used for managing relational databases.
It provides a standardized way to interact with databases, enabling users to store, retrieve, and manipulate data.

## Basic SQL Queries

- SELECT statement: Retrieves data from one or more tables.

```
SELECT column1, column2 FROM table_name;
WHERE clause: Filters data based on specified conditions.
```

```
- SELECT column1, column2 FROM table_name WHERE condition;
ORDER BY clause: Sorts query results in ascending or descending order.
```

```
- SELECT column1, column2 FROM table_name ORDER BY column1 ASC;
```

- Creating and Modifying Database Schema
  CREATE TABLE statement: Creates a new table with specified columns and data types.

sql
Copy code
CREATE TABLE table_name (
column1 datatype,
column2 datatype,
...
);
ALTER TABLE statement: Modifies an existing table by adding or altering columns.

sql
Copy code
ALTER TABLE table_name ADD column_name datatype;
DROP TABLE statement: Removes an existing table from the database.

sql
Copy code
DROP TABLE table_name;
CREATE INDEX statement: Adds an index to a table column for faster data retrieval.

sql
Copy code
CREATE INDEX index_name ON table_name (column_name);
CREATE VIEW statement: Creates a virtual table that presents data from one or more tables.

sql
Copy code
CREATE VIEW view_name AS
SELECT column1, column2 FROM table_name WHERE condition;
CREATE DATABASE statement: Creates a new database.

sql
Copy code
CREATE DATABASE database_name;
USE statement: Specifies the database to be used for subsequent queries.

sql
Copy code
USE database_name;
Remember to adapt the table names, column names, and conditions based on your specific use case.

This cheat sheet provides a brief overview of SQL basics for managing data and creating/modifying database schemas. For more advanced SQL concepts and additional use cases, refer to the relevant documentation and tutorials.

### 2. SQL Server Data Types, Constraints

- Overview of commonly used SQL Server data types and their purposes.
- Defining and enforcing constraints on table columns for data integrity.
- Example code demonstrating the usage of data types and constraints.

### 3. Querying Data, Sorting Data, Limiting Rows

- Performing complex queries to filter and retrieve specific data from tables.
- Sorting query results based on one or more columns.
- Limiting the number of rows returned by a query.

### 4. Filtering Data, Joining Tables

- Advanced techniques for filtering data based on specific conditions.
- Joining multiple tables together to retrieve data from related entities.
- Example code demonstrating various types of joins.

### 5. Grouping Data, Subquery

- Grouping data based on one or more columns to perform aggregations.
- Writing subqueries to retrieve data based on intermediate results.
- Common use cases for grouping data and using subqueries.

### 6. Set Operators, Common Table Expression (CTE)

- Performing set operations such as union, intersection, and difference between multiple queries.
- Understanding and utilizing Common Table Expressions (CTE) for complex queries.
- Example code showcasing set operators and CTE.

### 7. Pivot, Modifying Data, Views

- Transforming rows into columns using the PIVOT operation.
- Modifying existing data in tables using SQL statements (INSERT, UPDATE, DELETE).
- Creating and utilizing views for simplified data retrieval.

### 8. Indexes, Stored Procedures, Triggers

- Creating indexes to improve query performance.
- Working with stored procedures for encapsulating and reusing SQL logic.
- Utilizing triggers to execute actions based on specified database events.

### 9. User-defined Functions, Aggregate Functions

- Creating user-defined functions to encapsulate custom logic.
- Understanding and using aggregate functions for performing calculations on groups of rows.
- Example code demonstrating user-defined and aggregate functions.

## Getting Started

Follow the instructions below to get started with the CRM SQL tutorial:

1. Clone the repository to your local machine:
