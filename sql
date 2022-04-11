.open Library

.mode column
.header on

DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS book_copies;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS organizations;
DROP TABLE IF EXISTS tutors;
DROP TABLE IF EXISTS study_rooms;

CREATE TABLE IF NOT EXISTS student(
  student_id INTEGER NOT NULL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  phone_number INTEGER NOT NULL UNIQUE,
  address TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS books(
  book_id INTEGER NOT NULL PRIMARY KEY,
  title VARCHAR(50) NOT NULL,
  description TEXT NOT NULL,
  cost REAL NOT NULL
);


CREATE TABLE IF NOT EXISTS book_copies(
  copy_id INTEGER NOT NULL PRIMARY KEY,
  book_id INTEGER NOT NULL,
  available INTEGER(1) NOT NULL DEFAULT 1,
  FOREIGN KEY (book_id) REFERENCES items(item_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS payments (
  payment_id INTEGER NOT NULL PRIMARY KEY,
  copy_id INTEGER NOT NULL,
  student_id INTEGER NOT NULL,
  start_date DATE DEFAULT (datetime('now', 'localtime')),
  end_date DATE DEFAULT (datetime('now', '+10days', 'localtime')),
  returned INTEGER(1) NOT NULL DEFAULT 0,
  FOREIGN KEY (student_id) REFERENCES student (student_id) ON DELETE CASCADE,
  FOREIGN KEY (copy_id) REFERENCES book_copies (book_copies) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS organizations (
  organization_id INTEGER NOT NULL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  meeting_time TEXT NOT NULL,
  meeting_day TEXT NOT NULL,
  student_id INTEGER NOT NULL,
  FOREIGN KEY (student_id) REFERENCES student (student_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS tutors(
  tutor_id INTEGER NOT NULL PRIMARY KEY,
  name VARCHAR NOT NULL,
  phone_number INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS study_rooms(
  room_id INTEGER NOT NULL PRIMARY KEY,
  reserved INTEGER(1) NOT NULL DEFAULT (0),
  tutor_id INTEGER NOT NULL,
  student_id INTEGER NOT NULL,
  subject VARCHAR NOT NULL,
  FOREIGN KEY (tutor_id) REFERENCES tutor (tutor_id) ON DELETE CASCADE,
  FOREIGN KEY (student_id) REFERENCES student (student_id) ON DELETE CASCADE
);

INSERT INTO student (name, phone_number, address) VALUES
  ("Robert Hull", "8018018801", "123 street apt. 123"),
("Veronica Nelly", "8018028802", "123 street apt. 124");

SELECT * FROM student;



INSERT INTO books (title, description, cost) VALUES
  ("Fablehaven", "Fantasy", "150"),
("Flag of Our Fathers", "Historical", "100");

SELECT * FROM books;


INSERT INTO book_copies (book_id, available) VALUES
  (1,1), (1,0), (2,1), (2,0);


SELECT books.title, count(book_copies.book_id)
FROM books
INNER JOIN book_copies
ON books.book_id=book_copies.book_id
WHERE book_copies.available=1
GROUP BY books.title;

INSERT INTO payments (student_id, copy_id) VALUES
  (1,1), (2,3);

SELECT s.name, b.title
FROM student as s
INNER JOIN payments AS '1'
ON s.student_id = '1.student_id'
INNER JOIN book_copies AS bc
ON '1.copy_id' = bc.copy_id
INNER JOIN books AS b
on b.book_id = bc.book_id;

SELECT * FROM payments;

INSERT INTO organizations (name, meeting_time, meeting_day, student_id) VALUES
  ("SmashBros", "7:00PM", "WEDNESDAYS", "1"),
("BBQ", "8:00PM", "WEDNESDAYS", "2");

SELECT * FROM organizations;

INSERT INTO tutors (name, phone_number) VALUES
  ("James Marcus", "8018038033"),
("Kyler Kyln", "8028048044");

SELECT * FROM tutors;

INSERT INTO study_rooms (reserved, tutor_id, student_id, subject) VALUES
  (0, 0 ,0 ,0), (1, 2, 1, "Mathematics"), (1, 1, 2, "Data Analytics");

SELECT * FROM study_rooms;
