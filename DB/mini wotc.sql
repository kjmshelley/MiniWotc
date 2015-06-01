USE [master]
GO
CREATE DATABASE [MiniWotc]
GO

USE [MiniWotc]
GO


IF(OBJECT_ID('EmployeeDocuments', 'U') IS NOT NULL)
	DROP TABLE EmployeeDocuments 
GO 

IF(OBJECT_ID('Documents', 'U') IS NOT NULL)
	DROP TABLE Documents 
GO 
IF(OBJECT_ID('Employees', 'U') IS NOT NULL)
	DROP TABLE Employees 
GO 
IF OBJECT_ID('dbo.TargetGroups', 'U') IS NOT NULL
	DROP TABLE TargetGroups 
GO 

IF OBJECT_ID('dbo.[sp_StateExtraction]') IS NOT NULL
	DROP PROCEDURE dbo.[sp_StateExtraction]
GO

/****** Object:  Table [dbo].[Employees]    Script Date: 05/29/2015 10:44:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO


CREATE TABLE [dbo].[TargetGroups](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[targetGroup] [varchar](2) NOT NULL,
	[targetGroupCode] [int] NOT NULL, 
	[description] [varchar](255) NOT NULL,
	[maxCredit] [varchar](50) NULL,
 CONSTRAINT [PK_TargetGroups] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


CREATE TABLE [dbo].[Employees](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ssn] [varchar](9) NULL,
	[name] [varchar](100) NOT NULL,
	[address] [varchar](255) NOT NULL,
	[state] [varchar](2) NOT NULL,
	[qualified_target_groups] [int] NULL,
	[certified_target_group] [int] NULL, 
 CONSTRAINT [FK_Employee_TargetGroup] FOREIGN KEY (certified_target_group)
 REFERENCES TargetGroups(id),
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


CREATE TABLE [dbo].[Documents](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[document] [varchar](200) NOT NULL,
	[allowedDays] [int] NOT NULL
 CONSTRAINT [PK_Documents] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


CREATE TABLE [dbo].[EmployeeDocuments](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[employee_id] int NOT NULL,
	[document_id] int NOT NULL,
	[received_date] DATETIME NULL,
 CONSTRAINT [FK_Documents] FOREIGN KEY (document_id)
 REFERENCES Documents(id),
  CONSTRAINT FK_Employee FOREIGN KEY (employee_id)
 REFERENCES Employees(id),
 CONSTRAINT [PK_Employee_Documents] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
   
INSERT INTO [MiniWotc].[dbo].[TargetGroups]
           ([targetGroup]
           ,[targetGroupCode]
           ,[description]
           ,[maxCredit])
     VALUES
           ('V',
           2,
          'Veteran',
          2500)
GO

INSERT INTO [MiniWotc].[dbo].[TargetGroups]
           ([targetGroup]
           ,[targetGroupCode]
           ,[description]
           ,[maxCredit])
     VALUES
           ('S',
           4,
          'SNAP',
          2500)
GO

INSERT INTO [MiniWotc].[dbo].[TargetGroups]
           ([targetGroup]
           ,[targetGroupCode]
           ,[description]
           ,[maxCredit])
     VALUES
           ('T',
           8,
          'TANF',
          2500)
GO

INSERT INTO [MiniWotc].[dbo].[Employees]
           ([ssn]
           ,[name]
           ,[address]
           ,[state]
           ,[qualified_target_groups]
           ,[certified_target_group])
     VALUES(
		   '999999999',
           'Jason',
           '123 Main St',
           'CA',
           6,
           1
        )
GO
INSERT INTO [MiniWotc].[dbo].[Employees]
           ([ssn]
           ,[name]
           ,[address]
           ,[state]
           ,[qualified_target_groups]
           ,[certified_target_group])
     VALUES (
		   '888888888',
           'John Doe',
           '495 Baker Village',
           'PA',
           2,
           NULL
          )
 GO
 INSERT INTO [MiniWotc].[dbo].[Employees]
           ([ssn]
           ,[name]
           ,[address]
           ,[state]
           ,[qualified_target_groups]
           ,[certified_target_group])
     VALUES(
		   '123456789',
           'James Steward',
           '898 Black Hole Ave.',
           'CA',
           14,
           2
        )  
        
        
 
INSERT INTO [MiniWotc].dbo.Documents(document,[allowedDays])
   VALUES('8850',29)
INSERT INTO [MiniWotc].dbo.Documents(document,[allowedDays])
   VALUES('9061',5)
INSERT INTO [MiniWotc].dbo.Documents(document,[allowedDays])
   VALUES('Driver License',-1)
         
INSERT INTO [MiniWotc].dbo.EmployeeDocuments(employee_id,document_id,received_date)
   VALUES(1,1,GETDATE()-30)
INSERT INTO [MiniWotc].dbo.EmployeeDocuments(employee_id,document_id,received_date)
   VALUES(1,2,NULL)
INSERT INTO [MiniWotc].dbo.EmployeeDocuments(employee_id,document_id,received_date)
   VALUES(1,3,GETDATE())
  
INSERT INTO [MiniWotc].dbo.EmployeeDocuments(employee_id,document_id,received_date)
   VALUES(2,1,NULL)
INSERT INTO [MiniWotc].dbo.EmployeeDocuments(employee_id,document_id,received_date)
   VALUES(2,2,GETDATE()-6)
INSERT INTO [MiniWotc].dbo.EmployeeDocuments(employee_id,document_id,received_date)
   VALUES(2,3,NULL)
   
INSERT INTO [MiniWotc].dbo.EmployeeDocuments(employee_id,document_id,received_date)
   VALUES(3,1,GETDATE())
INSERT INTO [MiniWotc].dbo.EmployeeDocuments(employee_id,document_id,received_date)
   VALUES(3,2,NULL)
INSERT INTO [MiniWotc].dbo.EmployeeDocuments(employee_id,document_id,received_date)
   VALUES(3,3,GETDATE()-2)      
 GO



/* 
since there aren't any hire dates in this table
we will not use them
*/

CREATE PROCEDURE dbo.[sp_StateExtraction]
(
	@state VARCHAR(2),
	@from VARCHAR(10),
	@to VARCHAR(10)
)
AS 
BEGIN 
	SELECT e.*, tg.[description]
	FROM Employees e
	  JOIN TargetGroups tg 
	    ON e.certified_target_group  = tg.id  
	WHERE [state] = @state
END 



