import sqlite3
import pymysql

# Connect to the SQLite database file
sqlite_con = sqlite3.connect("Database Creation/Covid19.db")
sqlite_cur = sqlite_con.cursor()

# Create a SQL dump file
sql_dump = open("Database Creation/Covid19.sql", "w")

# Write the SQL statements to create the tables and insert the data
for line in sqlite_con.iterdump():
    sql_dump.write(f"{line}\n")

# Close the SQL dump file
sql_dump.close()

# Close the SQLite connection
sqlite_cur.close()
sqlite_con.close()
