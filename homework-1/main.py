import psycopg2
from csv import DictReader
import sys
sys.path.append(r'../homework-1')
"""Скрипт для заполнения данными таблиц в БД Postgres."""

# Connect to db
conn = psycopg2.connect(
    host='localhost',
    database='north',
    user='postgres',
    password='hghghg777'
)

# Create cursor
cur = conn.cursor()

# Execute query
with open(r'../homework-1/north_data/customers_data.csv') as file:
    customers = DictReader(file)
    for row in customers:
        cur.execute('INSERT INTO customers VALUES (%s, %s, %s)', (row['customer_id'],
                                                                  row['company_name'],
                                                                  row['contact_name']))

with open(r'../homework-1/north_data/employees_data.csv') as file:
    employees = DictReader(file)
    for row in employees:
        cur.execute('INSERT INTO employees VALUES (%s, %s, %s, %s, %s, %s)', (row['employee_id'],
                                                                              row['first_name'],
                                                                              row['last_name'],
                                                                              row['title'],
                                                                              row['birth_date'],
                                                                              row['notes']))

with open(r'../homework-1/north_data/orders_data.csv') as file:
    orders = DictReader(file)
    for row in orders:
        cur.execute('INSERT INTO orders VALUES (%s, %s, %s, %s, %s)', (row['order_id'],
                                                                       row['customer_id'],
                                                                       row['employee_id'],
                                                                       row['order_date'],
                                                                       row['ship_city']))

    conn.commit()

# Close cursor and connection
cur.close()
conn.close()
