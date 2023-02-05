--8 Create Table Users

CREATE TABLE 
            [Users]
(
	        [Id] BIGINT PRIMARY KEY IDENTITY,
	        [Username] VARCHAR(30) NOT NULL,
	        [Password] VARCHAR(26) NOT NULL,
	        [ProfilePicture] VARBINARY(MAX),
	        [LastLoginTime] DATETIME2,
	        [IsDeleted] BIT
)

INSERT INTO [Users]
	 VALUES
	        ('Gosho', 'GoShow', null, '01-17-2023', 0),
	        ('Tosho', 'ToShow123', null, '01-10-2023', 1),
	        ('Tisho', 'TiShow', null, '01-01-2023', 0),
	        ('Pesho', 'PeSh0w', null, '12-27-2022', 1),
	        ('Sasho', 'SaShow', null, '01-07-2023', 0)