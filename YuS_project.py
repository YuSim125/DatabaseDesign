import pymysql
from tabulate import tabulate

# Connect to the database
def connect_to_database():
    # Prompt the user for MySQL username and password
    username = input("Enter MySQL username: ")
    password = input("Enter MySQL password: ")
    connection = pymysql.connect(
        host="localhost",
        user=username,
        password=password,
        database="laundromat",
        cursorclass=pymysql.cursors.DictCursor,
        autocommit=True
    )
    return connection

# Function to create a new customer and laundry bag
def create_customer_and_laundry_bag(connection):
    try:
        with connection.cursor() as cursor:
            first_name = input("Enter customer's first name: ")
            last_name = input("Enter customer's last name: ")
            age = int(input("Enter customer's age: "))
            customer_level = input("Enter customer's level (old/new): ")
            print("They have a bag of clothes.")
            color = input("Enter laundry bag color: ")

            # Insert a new record into the customer table
            cursor.execute("INSERT INTO customer (first_name, last_name, age, customer_level) VALUES (%s, %s, %s, %s)",
                           (first_name, last_name, age, customer_level))
            # Retrieve the auto-generated customer ID
            customer_id = cursor.lastrowid
            
            # Insert a new record into the laundry_bag table
            cursor.execute("INSERT INTO laundry_bag (color_bag, customer_id) VALUES (%s, %s)", (color, customer_id))
            print("Customer and laundry bag created successfully.")
            return customer_id
    except pymysql.err.IntegrityError as e:
        print("Error creating customer and laundry bag:", e)

# Function to create a ticket
def create_ticket(connection, customer_id):
    try:
        with connection.cursor() as cursor:
            phone_num = input("Enter customer's phone number: ")
            pick_up_date = input("Enter pick-up date (YYYY-MM-DD): ")
            weight = int(input("Enter weight of laundry: "))
            washing_method = input("Enter washing method (machine/hand): ")
            drying_method = input("Enter drying method (dryer/hang_dry): ")

            # Call the stored procedure to create a ticket
            cursor.callproc('create_ticket', (phone_num, pick_up_date, weight, washing_method, drying_method))
            # Get the result
            result = cursor.fetchone()
            print("Ticket created successfully. Ticket Number:", result['new_ticket_number'], "Total Cost:", result['total_cost'])
    except pymysql.err.IntegrityError as e:
        print("Error creating ticket:", e)

# Function to read all tickets
def read_all_tickets(connection):
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT * FROM ticket")
            tickets = cursor.fetchall()
            ticket_data = []
            for ticket in tickets:
                ticket_info = [
                    ticket['ticket_number'],
                    ticket['phone_number'],
                    ticket['total_cost'],
                    ticket['pick_up'],
                    ticket['weight'],
                    ticket['washing_method'],
                    ticket['drying_method']
                ]
                ticket_data.append(ticket_info)
            
            print("All Tickets:")
            print(tabulate(ticket_data, headers=["Ticket Number", "Phone Number", "Total Cost", "Pick-up Date", "Weight", "Washing Method", "Drying Method"]))
    except pymysql.err.ProgrammingError as e:
        print("Error reading tickets:", e)

# Function to update pick-up date of a ticket
def update_pick_up_date(connection):
    try:
        with connection.cursor() as cursor:
            print("Another customer has called and says they are busy and want to update their pick up date...")
            print("You ask for their ticket number and they say 2")
            ticket_number = int(input("Enter ticket number to update pick-up date: "))
            new_pick_up_date = input("Enter new pick-up date (YYYY-MM-DD): ")
            cursor.callproc('update_pick_up_date', (ticket_number, new_pick_up_date))
            print("Pick-up date updated successfully for Ticket", ticket_number)
    except pymysql.err.IntegrityError as e:
        print("Error updating pick-up date:", e)

# Function to delete a ticket
def delete_ticket(connection):
    try:
        with connection.cursor() as cursor:
            print("Another customer comes and wants a refund because we messed up their clothes...")
            print("They give us back their ticket and it has ticket number 3.")
            ticket_number = int(input("Enter ticket number to delete: "))
            cursor.callproc('delete_ticket', (ticket_number,))
            print("Ticket", ticket_number, "deleted successfully.")
    except pymysql.err.IntegrityError as e:
        print("Error deleting ticket:", e)

# Function to calculate total earning
def calculate_total_earning(connection):
    try:
        with connection.cursor() as cursor:
            # Call the stored function to calculate total earning
            cursor.execute("SELECT calculate_total_earning() AS total_earnings")
            total_earnings = cursor.fetchone()['total_earnings']
            return total_earnings
    except pymysql.err.ProgrammingError as e:
        print("Error calculating total earning:", e)

if __name__ == '__main__':
    try:
        # Connect to the database
        connection = connect_to_database()
        print("A customer has just arrived. Get their infomation!")
        # Create a new customer and laundry bag
        customer_id = create_customer_and_laundry_bag(connection)

        if customer_id:
            # Create a ticket
            create_ticket(connection, customer_id)

            # Read all tickets
            read_all_tickets(connection)

            # Update pick-up date of a ticket
            update_pick_up_date(connection)

            # Delete a ticket
            delete_ticket(connection)

            # Calculate total earning
            total_earning = calculate_total_earning(connection)
            print("8 hours later and the laundromat has closed...")
            print("You read through all the tickets to find how much you earned today ")
            print("Total Earnings:", total_earning)

        # Close the connection to the database
        connection.close()
    except Exception as e:
        print("Error, invalid username or password.")
