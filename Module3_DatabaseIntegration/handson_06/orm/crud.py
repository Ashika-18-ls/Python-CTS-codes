from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, joinedload
from models import Student

DATABASE_URL = "postgresql+psycopg2://postgres:Ashika@localhost:5432/colege_db"

engine = create_engine(DATABASE_URL, echo=True)
Session = sessionmaker(bind=engine)
session = Session()

students = (
    session.query(Student)
    .options(joinedload(Student.department))
    .all()
)

for student in students:
    print(student.first_name, student.department.dept_name)

session.close()