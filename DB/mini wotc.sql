USE [master]
GO
IF(EXISTS(SELECT 'x' FROM master.dbo.sysdatabases WHERE name = 'MiniWotc'))
	DROP DATABASE MiniWotc 
GO

CREATE DATABASE [MiniWotc]
GO

USE [MiniWotc]
GO

IF(OBJECT_ID('Companies', 'U') IS NOT NULL)
	DROP TABLE Companies 
GO 

IF(OBJECT_ID('Locations', 'U') IS NOT NULL)
	DROP TABLE Locations 
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
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TargetGroup] [varchar](2) NOT NULL,
	[TargetGroupCode] [int] NOT NULL, 
	[Description] [varchar](255) NOT NULL,
	[MaxCredit] [varchar](50) NULL,
 CONSTRAINT [PK_TargetGroups] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
CREATE TABLE [dbo].[Companies](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL
 CONSTRAINT [PK_Companies] PRIMARY KEY CLUSTERED
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


CREATE TABLE [dbo].[Locations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyId] [int] NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Address] [varchar](255) NOT NULL,
	[City] [varchar] (255) NOT NULL,
	[State] [varchar](2) NOT NULL,
 CONSTRAINT [FK_Company] FOREIGN KEY (CompanyId)
 REFERENCES Companies(id),
 CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


CREATE TABLE [dbo].[Employees](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SSN] [varchar](9) NULL,
	[Name] [varchar](100) NOT NULL,
	[Address] [varchar](255) NOT NULL,
	[LocationId] int NOT NULL,
	[City] [varchar] (255) NOT NULL,
	[State] [varchar](2) NOT NULL,
	[QualifiedTargetGroup] [int] NULL,
	[CertifiedTargetGroupId] [int] NULL, 
 CONSTRAINT [FK_Employee_TargetGroup] FOREIGN KEY (CertifiedTargetGroupId)
 REFERENCES TargetGroups(id),
 CONSTRAINT [FK_Employee_Location] FOREIGN KEY (LocationId)
 REFERENCES Locations(id),
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


CREATE TABLE [dbo].[Documents](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Document] [varchar](200) NOT NULL,
	[AllowedDays] [int] NOT NULL
 CONSTRAINT [PK_Documents] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


CREATE TABLE [dbo].[EmployeeDocuments](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] int NOT NULL,
	[DocumentId] int NOT NULL,
	[ReceivedDate] DATETIME NULL,
 CONSTRAINT [FK_Documents] FOREIGN KEY (DocumentId)
 REFERENCES Documents(id),
  CONSTRAINT FK_Employee FOREIGN KEY (EmployeeId)
 REFERENCES Employees(id),
 CONSTRAINT [PK_Employee_Documents] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


INSERT INTO [MiniWotc].[dbo].Companies(Name) VALUES('Abc Company')
GO

INSERT INTO MiniWotc.[dbo].[Locations](
	[CompanyId]
	,[Name]
	,[Address]
	,[City]
	,[State])
	VALUES (
	1, 'First Location', '123 A Street', 'Scrambton', 'CA')
GO
	
INSERT INTO MiniWotc.[dbo].[Locations](
	[CompanyId]
	,[Name]
	,[Address]
	,[City]
	,[State])
	VALUES (
	1, 'Second Location', '4775 W. Crave Ln', 'Boulding', 'CA')
GO	
	
INSERT INTO MiniWotc.[dbo].[Locations](
	[CompanyId]
	,[Name]
	,[Address]
	,[City]
	,[State])
   VALUES (
	1, 'Final Location', '823 Wanyi Blvd', 'Fireplace', 'PA')
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
           ,[city]
           ,[state]
           ,[locationid]
           ,[qualifiedtargetgroup]
           ,[certifiedtargetgroupid])
     VALUES(
		   '999999999',
           'Jason',
           '123 Main St',
           'Scrambton',
           'CA',
           1,
           6,
           1
        )
GO
INSERT INTO [MiniWotc].[dbo].[Employees]
           ([ssn]
           ,[name]
           ,[address]
           ,[city]
           ,[state]
           ,[LocationId]
           ,[qualifiedtargetgroup]
           ,[certifiedtargetgroupid])
     VALUES (
		   '888888888',
           'John Doe',
           '495 Baker Village',
           'Fireplace',
           'PA',
           3,
           2,
           NULL
          )
 GO
 INSERT INTO [MiniWotc].[dbo].[Employees]
           ([ssn]
           ,[name]
           ,[Address]
           ,[city]
           ,[state]
           ,[LocationId]
           ,[qualifiedtargetgroup]
           ,[certifiedtargetgroupid])
     VALUES(
		   '123456789',
           'James Steward',
           '898 Black Hole Ave.',
           'Boulding',
           'CA',
           2,
           14,
           2
        )  
        
        
 
INSERT INTO [MiniWotc].dbo.Documents(document,[allowedDays])
   VALUES('8850',29)
INSERT INTO [MiniWotc].dbo.Documents(document,[allowedDays])
   VALUES('9061',5)
INSERT INTO [MiniWotc].dbo.Documents(document,[allowedDays])
   VALUES('Driver License',-1)
         
INSERT INTO [MiniWotc].dbo.EmployeeDocuments(EmployeeId,documentid,receiveddate)
   VALUES(1,1,GETDATE()-30)
INSERT INTO [MiniWotc].dbo.EmployeeDocuments(EmployeeId,documentid,receiveddate)
   VALUES(1,2,NULL)
INSERT INTO [MiniWotc].dbo.EmployeeDocuments(EmployeeId,documentid,receiveddate)
   VALUES(1,3,GETDATE())
  
INSERT INTO [MiniWotc].dbo.EmployeeDocuments(EmployeeId,documentid,receiveddate)
   VALUES(2,1,NULL)
INSERT INTO [MiniWotc].dbo.EmployeeDocuments(EmployeeId,documentid,receiveddate)
   VALUES(2,2,GETDATE()-6)
INSERT INTO [MiniWotc].dbo.EmployeeDocuments(EmployeeId,documentid,receiveddate)
   VALUES(2,3,NULL)
   
INSERT INTO [MiniWotc].dbo.EmployeeDocuments(EmployeeId,documentid,receiveddate)
   VALUES(3,1,GETDATE())
INSERT INTO [MiniWotc].dbo.EmployeeDocuments(EmployeeId,documentid,receiveddate)
   VALUES(3,2,NULL)
INSERT INTO [MiniWotc].dbo.EmployeeDocuments(EmployeeId,documentid,receiveddate)
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
	    ON e.CertifiedTargetGroupId  = tg.id  
	WHERE [state] = @state
END 



