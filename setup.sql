/*
easier testing
*/
DROP TABLE IF EXISTS students

/*
create the table
*/
create table students
	(student_id		SERIAL,
	 first_name		varchar(128) NOT NULL,
	 last_name		varchar(128) NOT NULL,
	 email			varchar(255) NOT NULL UNIQUE,
	 enrollment_date		DATE,
	 primary key(student_id)
);

/*
insert data
*/
INSERT INTO students (first_name, last_name, email, enrollment_date) VALUES
('John', 'Doe', 'john.doe@example.com', '2023-09-01'),
('Jane', 'Smith', 'jane.smith@example.com', '2023-09-01'),
('Jim', 'Beam', 'jim.beam@example.com', '2023-09-02');

/*
purpose: output every student
functionality: returns a table listing each individual students tuple
				in ascending order based on their student id numbers
*/
CREATE OR REPLACE FUNCTION getAllStudents()
RETURNS TABLE (student_id INT, first_name VARCHAR(128), 
			   last_name VARCHAR(128), email VARCHAR(255),
			   enrollment_date DATE)
language plpgsql
AS
$$
begin
	RETURN QUERY
	SELECT s.student_id, s.first_name, s.last_name, 
			s.email, s.enrollment_date
	FROM students s
	ORDER BY s.student_id;
end;
$$;

/*
purpose: add a student to the database
functionality: a name, last name, email and enrollment date are passed into
				the function and added as a tuple to the table. a spot in memory is
				reserved for the new students id to be put into then said id is returned
*/
CREATE OR REPLACE FUNCTION addStudent(new_first_name VARCHAR(128), 
					new_last_name VARCHAR(128), 
					new_email VARCHAR(255), 
					new_enrollment_date DATE)
RETURNS INT
language plpgsql
AS
$$
DECLARE
	new_student_id INT;
BEGIN
	INSERT INTO students(first_name, last_name, email, enrollment_date)
	values(new_first_name, new_last_name, new_email, new_enrollment_date)
	RETURNING student_id into new_student_id;
	RETURN new_student_id;
END;
$$;

/*
purpose: update the email of a student
functionality: if the student id passed in the function exists, updates
				the email associated with the id key to be the email that
				was passed in the function and returns true 
*/
CREATE OR REPLACE FUNCTION updateStudentEmail(u_student_id INT, new_email VARCHAR(255))
returns boolean
language plpgsql
AS

$$
BEGIN
	UPDATE students
	SET email = new_email
	WHERE student_id = u_student_id;

	RETURN FOUNd;
END;
$$;

/*
purpose: removing a student from the database
functionality: if the student id passed in the function exists,
				deletes the tuple connected to the key and returns true
*/
CREATE OR REPLACE FUNCTION deleteStudent(x_student_id INT)
RETURNS boolean

language plpgsql
AS
$$
BEGIN
	DELETE FROM students
	where student_id = x_student_id;

	RETURN FOUND;
END;
$$;
