from sqlalchemy import create_engine
from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy import Date, Numeric
from sqlalchemy.orm import declarative_base, relationship

DATABASE_URL = "postgresql+psycopg2://postgres:Ashika@localhost:5432/colege_db"

engine = create_engine(DATABASE_URL, echo=True)

Base = declarative_base()


class Department(Base):
    __tablename__ = "departments"

    department_id = Column(Integer, primary_key=True)
    dept_name = Column(String(100))
    head_of_dept = Column(String(100))
    budget = Column(Numeric(12, 2))

    students = relationship("Student", back_populates="department")


class Student(Base):
    __tablename__ = "students"

    student_id = Column(Integer, primary_key=True)
    first_name = Column(String(50))
    last_name = Column(String(50))
    email = Column(String(100))
    date_of_birth = Column(Date)

    department_id = Column(
        Integer,
        ForeignKey("departments.department_id")
    )

    enrollment_year = Column(Integer)

    department = relationship(
        "Department",
        back_populates="students"
    )

    enrollments = relationship(
        "Enrollment",
        back_populates="student"
    )


class Course(Base):
    __tablename__ = "courses"

    course_id = Column(Integer, primary_key=True)
    course_name = Column(String(150))
    course_code = Column(String(20))
    credits = Column(Integer)

    department_id = Column(
        Integer,
        ForeignKey("departments.department_id")
    )

    enrollments = relationship(
        "Enrollment",
        back_populates="course"
    )


class Enrollment(Base):
    __tablename__ = "enrollments"

    enrollment_id = Column(Integer, primary_key=True)

    student_id = Column(
        Integer,
        ForeignKey("students.student_id")
    )

    course_id = Column(
        Integer,
        ForeignKey("courses.course_id")
    )

    enrollment_date = Column(Date)

    grade = Column(String(2))

    student = relationship(
        "Student",
        back_populates="enrollments"
    )

    course = relationship(
        "Course",
        back_populates="enrollments"
    )


class Professor(Base):
    __tablename__ = "professors"

    professor_id = Column(Integer, primary_key=True)
    prof_name = Column(String(100))
    email = Column(String(100))

    department_id = Column(
        Integer,
        ForeignKey("departments.department_id")
    )

    salary = Column(Numeric(10, 2))


if __name__ == "__main__":
    Base.metadata.create_all(engine)
    print("Tables created successfully!")