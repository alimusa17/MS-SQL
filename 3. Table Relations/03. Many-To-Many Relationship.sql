--03. Many-To-Many Relationship

CREATE TABLE [Students]
(
	        [StudentID] INT PRIMARY KEY,
			[Name] NVARCHAR(30) NOT NULL
)

CREATE TABLE [Exams]
(
			[ExamID] INT PRIMARY KEY IDENTITY (101, 1),
			[Name] NVARCHAR(30) NOT NULL
)

CREATE TABLE [StudentsExams]
(
			[StudentID] INT FOREIGN KEY REFERENCES [Students] ([StudentID]),
			[ExamID] INT FOREIGN KEY REFERENCES [Exams] ([ExamID]),
			PRIMARY KEY ([StudentID], [ExamID])
)