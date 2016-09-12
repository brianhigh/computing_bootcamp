# Databases
John Yocum  
![CC BY-SA 4.0](../images/cc_by-sa_4.png)  



# Flat File

## Pros and Cons

**Pros**

- Lightweight when small
    - For read/write work loads
- Portable
    - Moving between systems and software

**Cons**

- No builtin data validation
    - Internally the database is unable to make sure column type is correct
- Performance goes down as it grows
    - Write performance suffers first, followed by read performance

## Software

- Any text editor
- Anything that can parse a CSV
- Any scripting or programming language

# Relational

## Pros and Cons

**Pros**

- Interfaces with a number of tools
    - Native drivers
    - ODBC
    - JDBC
- Data validation
    - Verify column data type
    - Prevent orphaned rows/records
- Can scale to significant size if planned for
    - Some engines can handle far more than others

**Cons**

- Limited portability, each database engine has it's own quirks
- Proper setup requires some planning

## Software

- MySQL (Free, open source, cross platform)
- PostgreSQL (Free, open source, cross platform)
- Microsoft Access (Proprietary, Windows only)
- SQLite (Free, open source, cross platform)
- FileMaker (Proprietary, Windows and Mac)

# NoSQL

## Pros and Cons

**Pros**

- Lots of choices
- Extremely high scalability

**Cons**

- Lots of choices
- Portability, each NoSQL database engine stores data differently
- Database specific query language

## Software

- Apache Cassandra (Free, open source, cross platform)
- MongoDB (Free, open source, cross platform)

# Questions?
