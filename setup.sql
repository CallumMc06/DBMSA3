create table students
	(student_id		INT AUTO_INCREMENT,
	 first_name		varchar(128) NOT NULL,
	 last_name		varchar(128) NOT NULL,
	 email			varchar(255) NOT NULL UNIQUE,
	 enrollment_date		DATE,
	 primary key(student_id)
);

INSERT INTO students (first_name, last_name, email, enrollment_date) VALUES
('John', 'Doe', 'john.doe@example.com', '2023-09-01'),
('Jane', 'Smith', 'jane.smith@example.com', '2023-09-01'),
('Jim', 'Beam', 'jim.beam@example.com', '2023-09-02');

CREATE FUNCTION getAllStudents()
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
	FROM student s
	ORDER BY s.student_id;
end;
$$;

CREATE FUNCTION addStudent(new_first_name VARCHAR(128), 
					new_last_name VARCHAR(128), 
					new_email VARCHAR(255), 
					new_enrollment_date DATE)
RETURNS INT
language plpsql
AS
$$
DECLARE
	new_student_id INT;
BEGIN
	INSERT INTO students(first_name, last_name, email, enrollment_date)
	values(new_first_name, new_last_name, new_email, new_enrollment_date)
	RETURN new_student_id;
END;
$$;

CREATE FUNCTION updateStudentEmail(u_student_id INT, u_email VARCHAR(255))
returns boolean
language plpgsql
AS

$$
BEGIN
	UPDATE students
	SET email = u_email
	WHERE student_id = u_student_id;

	RETURN FOUND;
END;
$$;

/*
purpose: removing a student from the database
*/
CREATE FUNCTION deleteStudent(x_student_id INT)
RETURNS boolean

language plpgsql
AS
$$
BEGIN
	DELETE FROM students
	where student_id = x_student_id

	RETURN FOUND;
END;
$$;