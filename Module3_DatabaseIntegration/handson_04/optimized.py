import psycopg2

conn = psycopg2.connect(
    host="localhost",
    database="colege_db",
    user="postgres",
    password="Ashika",
    port="5432"
)

cursor = conn.cursor()

cursor.execute("""
SELECT
s.first_name,
s.last_name,
c.course_name
FROM enrollments e
JOIN students s
ON s.student_id = e.student_id
JOIN courses c
ON c.course_id = e.course_id;
""")

rows = cursor.fetchall()

for row in rows:
    print(row)

print("\nTotal Queries Executed: 1")

cursor.close()
conn.close()