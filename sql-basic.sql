-- comment single line
/* comment multiline */

/*
Normalization
1NF - 1 value/cell
2NF - Non key ทุกๆตัวต้องขึ้นกับ PRIMARY KEY และไม่ใช่เพียงส่วนใดส่วนหนึ่งของ PK, ถ้าขึ้นกับส่วนใดส่วนหนึงของPKให้แยกตาราง
3NF - Non key ต้องไม่ขึ้นกับ NK, ให้แยกตาราง
BCNF - ไม่มี PK ขึ้นกับ NK(candidate key), ให้แยกตาราง

SQL Constraints
NOT NULL - Ensures that a column cannot have a NULL value
UNIQUE - Ensures that all values in a column are different
PRIMARY KEY - A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table
FOREIGN KEY - Uniquely identifies a row/record in another table
CHECK - Ensures that all values in a column satisfies a specific condition
DEFAULT - Sets a default value for a column when no value is specified
INDEX - Used to create and retrieve data from the database very quickly

Action Constraints (On Update/Delete)
SET NULL - ถ้าเกิดการเปลี่ยนแปลง ให้ไปเปลี่ยนกับ Row ที่มี FK อ้างถึง PK ของอีกตารางที่เกิดการเปลี่ยนแปลงเป็น NULL
CASCADE - ถ้าเกิดการเปลี่ยนแปลง ให้ไปเปลี่ยนกับ Row ที่มี FK อ้างถึง PK ของอีกตารางที่เกิดการเปลี่ยนแปลงด้วย
RESTRICT - ห้ามเปลี่ยนแปลงถ้ายังมี FK จากตารางอื่นอ้างถึงอยู่
NO ACTION
*/

--INSERT
INSERT INTO Customers (CustomerName, ContactName, Addresses, City, PostalCode, Country)
VALUES ('Cardinal', 'Tom B. Erichsen', 'Skagen 21', 'Stavanger', 4006, 'Norway');
--insert multiple colum
INSERT INTO Customers (CustomerName, ContactName, Addresses, City, PostalCode, Country)
VALUES ('Cardinal', 'Tom B. Erichsen', 'Skagen 21', 'Stavanger', 4006, 'Norway'),
('Cardinal', 'Tom B. Erichsen', 'Skagen 21', 'Stavanger', 4006, 'Norway'),
('Cardinal', 'Tom B. Erichsen', 'Skagen 21', 'Stavanger', 4006, 'Norway'),
('Cardinal', 'Tom B. Erichsen', 'Skagen 21', 'Stavanger', 4006, 'Norway');
--insert ทุกๆ field
INSERT INTO Customers VALUES ('Cardinal', 'Tom B. Erichsen', 'Skagen 21', 'Stavanger', 4006, 'Norway');

--UPDATE
UPDATE Customers
SET ContactName = 'Alfred Schmidt', City= 'Frankfurt'
WHERE CustomerID = 1;

--DELETE
DELETE FROM Customers
WHERE CustomerName='Alfreds Futterkiste';

-- SELECT
SELECT column_name(s) AS c1 -- หรือ นิพจน์ AS นามแฝง
FROM table_name AS t1 -- หรือ FROM (SELECT ...) << เรียกว่า subquery
WHERE condition
INNER JOIN table2 ON table1.column_name = table2.column_name;-- LEFT, RIGHT, FULL OUTER ในการเชื่อมตารางอจไม่ต้องJOIN แต่ใช้WHERE
GROUP BY column_name(s)
HAVING condition -- เงื่อนไขสำหรับคัดกรองหลังจาก GROUP BY เช่น HAVING COUNT(CustomerID) > 5;
ORDER BY column_name(s)
LIMIT 10; -- LIMIT 0,7 

SELECT CustomerName, City FROM Customers; --เอาแค่สองฟิลด์
SELECT * FROM Customers; -- เอาทุกฟิลด์
SELECT DISTINCT Country FROM Customers; --DISTINC ทำให้ select ค่าออกมาไม่ซ้ำกัน
SELECT COUNT(DISTINCT Country) FROM Customers;
--function MIN() MAX() AVG() COUNT() SUM() CONCAT(Address,', ',PostalCode,', ',City,', ',Country)
SELECT * FROM Customers WHERE CustomerID=1; -- WHERE ใช้คัดกรองตามเงื่อนไข เช่น CustomerID=1
-- Operator มีดังนี้ = <> > < <= >= BETWEEN LIKE IN
SELECT * FROM Customers WHERE CustomerName LIKE 'a_%_%';-- LIKE _ ตัวอักษร1ตัว %ตัวอักษร0+ตัว
SELECT * FROM Customers WHERE Country NOT IN ('Germany', 'France', 'UK');-- IN ใช้แทน = OR = OR = OR = OR =, ใช้ค่าจาก Sub query ได้
SELECT * FROM Customers WHERE Country IN (SELECT Country FROM Suppliers);
SELECT * FROM Products WHERE Price NOT BETWEEN 10 AND 20; --BETWEEN ใช้ select เป็นช่วง
SELECT * FROM Products WHERE ProductName BETWEEN 'Carnarvon Tigers' AND 'Mozzarella di Giovanni' ORDER BY ProductName;
-- ^ BETWEEN ข้อความต้องเรียงด้วย โดยจะตรวจสอบทีละหลัก
-- และ AND OR NOT
-- และ IS NULL, IS NOT NULL เช่น WHERE Customer IS NOT NULL
SELECT * FROM Customers ORDER BY Country ASC, CustomerName DESC;-- เรียง
SELECT * FROM Customers WHERE Country='Germany' LIMIT 3; --เอาแค่3แถว ถ้า LIMIT 3,5 คือเอาแถวที่3-5
SELECT AVG(Price) FROM Products; -- selectมาแล้วหาค่าเฉลี่ยน ผลลัพธ์จะได้แค่ Row เดียว

-- รวมแบบไม่เอาแถวซ้ำ
SELECT column_name(s) FROM table1
UNION
SELECT column_name(s) FROM table2;
-- รวมแบบเอาแถวซ้ำ
SELECT column_name(s) FROM table1
UNION ALL
SELECT column_name(s) FROM table2;

--Example Select
SELECT Employees.LastName, COUNT(Orders.OrderID) AS NumberOfOrders
FROM Orders
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE LastName = 'Davolio' OR LastName = 'Fuller'
GROUP BY LastName
HAVING COUNT(Orders.OrderID) > 25;

--สร้าง view
CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;