# sqlite3 Cheatsheet

## Data types

### Storage Classes

|Class|Description|
|:----|----------:|
|NULL|The value is a NULL value|
|INTEGER|The value is a signed integer, stored in 1, 2, 3, 4, 6, or 8 bytes depending on the magnitude of the value.|
|REAL|The value is a floating point value, stored as an 8-byte IEEE floating point number.|
|TEXT|The value is a text string, stored using the database encoding (UTF-8, UTF-16BE or UTF-16LE)|
|BLOB|The value is a blob of data, stored exactly as it was input.|


### Affinity Types

|Affinity|Descripion|
|:-------|---------:|
|TEXT|This column stores all data using storage classes NULL, TEXT or BLOB.|
|NUMERIC|This column may contain values using all five storage classes.|
|INTEGER|Behaves the same as a column with NUMERIC affinity, with an exception in a CAST expression.|
|REAL|Behaves like a column with NUMERIC affinity except that it forces integer values into floating point representation.|
|NONE|A column with affinity NONE does not prefer one storage class over another and no attempt is made to coerce data from one storage class into another.|

### Data type affinities

|Data type|Affinity|
|:--------|-------:|
|INT, INTEGER, TINYINT, SMALLINT, MEDIUMINT, BIGINT, UNSIGNED BIG INT, INT2, INT8| INTEGER |
|CHARACTER(20), VARCHAR(255), VARYING CHARACTER(255), NCHAR(55), NATIVE CHARACTER(70), NVARCHAR(100), TEXT, CLOB|TEXT|
|BLOB, no datatype specified| NONE |
|REAL, DOUBLE, DOUBLE PRECISION, FLOAT|REAL|
|NUMERIC, DECIMAL(10,5), BOOLEAN, DATE, DATETIME|NUMERIC|

## Dot commands

### .dump

You can use .dump dot command to export complete database in a text file using the following SQLite command at the command prompt.

`sqlite3 testDB.db .dump > testDB.sql`

Restoring from a "dump" file is done via

`sqlite3 testDB.db < testDB.sql`

### .header

**Values**: \[ on | off \]

Switches the impression of table headers in output on or off.

### .mode

**Values**: \[ csv | column | html | insert | line | list | tabs | tcl \]

Set output mode for command line interface.

### .width

**Values**: Comma separated values for each column width, being the firs number the width of the first column, the second number the width of the second column...etc.

### .tables

Is used to list down all the tables in an attached database.

### .quit

Exits from the sqlite3 prompt.

## Using sqlite3

SQL comments begin with two consecutive "-" characters (ASCII 0x2d) and extend up to and including the next newline character (ASCII 0x0a) or until the end of input, whichever comes first.

You can also use C-style comments, which begin with "/*" and extend up to and including the next "*/" character pair or until the end of input, whichever comes first. C-style comments can span multiple lines.

### Creating tables

```SQL
CREATE TABLE [database_name.]table_name(
   column1 datatype [PRIMARY KEY] [NOT NULL],
   column2 datatype,
   column3 datatype,
   ...
   columnN datatype
);
```

### Deleting tables

```SQL
DROP TABLE [database_name.]table_name;
```

### Inserting data

```SQL
INSERT INTO table_name [(column1, column2, column3,...columnN)]  
VALUES (value1, value2, value3,...valueN);
```

### Deleting data

```SQL
DELETE FROM table_name
WHERE [condition];
```

_Special case_

```SQL
DELETE FROM table_name;
```

### Altering data

```SQL
UPDATE table_name
SET column1 = value1, column2 = value2...., columnN = valueN
WHERE [condition];
```

### Reading data

_Read a complete dataset_

```SQL
SELECT * FROM table_name;
```

_Read only certain columns_

```SQL
SELECT column1, column2, columnN FROM table_name;
```

_Amplified statement_

```SQL
SELECT column1, column2, columnN 
FROM table_name 
WHERE [CONDITION | EXPRESSION];
```

### Wildcards

#### LIKE

```SQL
SELECT * FROM table_name 
WHERE field LIKE '%2';
```

The `LIKE` operator is used to match text values against a pattern using wildcards. If the search expression can be matched to the pattern expression, the LIKE operator will return true, which is 1. There are two wildcards used in conjunction with the LIKE operator.

* The percent sign **%**
* The underscore **_**

The percent sign represents zero, one, or multiple numbers or characters. 

The underscore represents a single number or character. These symbols can be used in combinations.

#### GLOB

```SQL
SELECT FROM table_name
WHERE column GLOB '?XXXX*'
```

The `GLOB` operator is used to match only text values against a pattern using wildcards. If the search expression can be matched to the pattern expression, the GLOB operator will return true, which is 1. Unlike LIKE operator, GLOB is case sensitive and it follows syntax of UNIX for specifying THE following wildcards.

* The asterisk sign **\***
* The question mark **?**

The asterisk sign (*) represents zero or multiple numbers or characters. The question mark (?) represents a single number or character.

#### Subsets

```SQL
SELECT * FROM table_name 
LIMIT X OFFSET Y;
```

The `LIMIT` clause is used to limit the data amount returned by the SELECT statement.

The DB engine will return rows starting from the next row to the given `OFFSET`.

### Ordering data

#### ORDER BY

```SQL
SELECT column_list 
FROM table_name 
[WHERE CONDITION] 
[ORDER BY column1, column2, .. columnN] [ASC | DESC];
```

The `ORDER BY` clause is used to sort the data in an ascending or descending order, based on one or more columns.

#### GROUP BY

```SQL
SELECT column_list
FROM table_name
WHERE [ CONDITIONS ]
GROUP BY column1, column2....columnN
ORDER BY column1, column2....columnN
```

The `GROUP BY` clause is used in collaboration with the `SELECT` statement to arrange identical data into groups.

`GROUP BY` clause follows the `WHERE` clause in a `SELECT` statement and precedes the `ORDER BY` clause.

#### HAVING

```SQL
SELECT column1, column2
FROM table_name1, table_name	2
WHERE [ CONDITIONS ]
GROUP BY column1, column2
HAVING [ CONDITIONS ]
ORDER BY column1, column2
```

The `HAVING` clause enables you to specify conditions that filter which group results appear in the final results.

The `WHERE` clause places conditions on the selected columns, whereas the `HAVING` clause places conditions on groups created by `GROUP BY` clause.

The `HAVING` clause must follow `GROUP BY` clause in a query and must also precede `ORDER BY` clause if used. Following is the syntax of the `SELECT` statement, including `HAVING` clause.

```SQL
SELECT * FROM table_name 
GROUP BY name HAVING count(name) < X;
```

This would return all records where the name field has *less* than X ocurrences.

#### DISTINCT

```SQL
SELECT DISTINCT column1, column2,.....columnN 
FROM table_name
WHERE [CONDITION]
```

`DISTINCT` keyword is used in conjunction with `SELECT` statement to eliminate all the duplicate records and fetching only the unique records.

There may be a situation when you have multiple duplicate records in a table. While fetching such records, it makes more sense to fetch only unique records instead of fetching duplicate records.

