import sqlite3 as sql
import pandas as pd



# Load Data 
covid_death = pd.read_csv("Database Creation/CovidDeaths.csv")
covid_vaccination = pd.read_csv("Database Creation/CovidVaccinations.csv")

# create a database
connection = sql.connect("Database Creation/Covid19.db")

# Load database to sqlite
# fail, replace, append
covid_death.to_sql("Deaths", connection, if_exists="replace")
covid_vaccination.to_sql("Vaccinations", connection, if_exists="replace")

# close connection
connection.close()
