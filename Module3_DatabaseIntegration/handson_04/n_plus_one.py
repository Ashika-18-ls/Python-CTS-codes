import psycopg2

conn = psycopg2.connect(
    host="localhost",
    database="colege_db",
    user="postgres",
    password="Ashika",
    port="5432"
)

cursor = conn.cursor()

query_count = 1

cursor.execute("SELECT * FROM enrollments")
enrollments = cursor.fetchall()

for enrollment in enrollments:

    student_id = enrollment[1]

    cursor.execute(
        "SELECT first_name, last_name FROM students WHERE student_id=%s",
        (student_id,)
    )

    student = cursor.fetchone()

    print(student)

    query_count += 1

print("\nTotal Queries Executed:", query_count)

cursor.close()
conn.close()