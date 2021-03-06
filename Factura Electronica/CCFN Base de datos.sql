USE [master]
GO
/****** Object:  Database [CCFN]    Script Date: 2/1/2017 3:11:02 PM ******/
CREATE DATABASE [CCFN]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CCFN', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\CCFN.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CCFN_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\CCFN_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [CCFN] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CCFN].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CCFN] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CCFN] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CCFN] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CCFN] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CCFN] SET ARITHABORT OFF 
GO
ALTER DATABASE [CCFN] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CCFN] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [CCFN] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CCFN] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CCFN] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CCFN] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CCFN] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CCFN] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CCFN] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CCFN] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CCFN] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CCFN] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CCFN] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CCFN] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CCFN] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CCFN] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CCFN] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CCFN] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CCFN] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CCFN] SET  MULTI_USER 
GO
ALTER DATABASE [CCFN] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CCFN] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CCFN] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CCFN] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [CCFN]
GO
/****** Object:  User [CCFNuser]    Script Date: 2/1/2017 3:11:03 PM ******/
CREATE USER [CCFNuser] FOR LOGIN [CCFNuser] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [CCFNuser]
GO
/****** Object:  UserDefinedFunction [dbo].[udfGetActionNameByActionId]    Script Date: 2/1/2017 3:11:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udfGetActionNameByActionId]
(
	@ActionId INT
)
RETURNS VARCHAR(32)
AS
BEGIN
	DECLARE @Result VARCHAR(32)
	SELECT @Result = Name FROM Actions WHERE ActionId = @ActionId
	RETURN @Result
END
GO
/****** Object:  UserDefinedFunction [dbo].[udfGetStatusNameByStatusId]    Script Date: 2/1/2017 3:11:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udfGetStatusNameByStatusId]
(
	@StatusId INT
)
RETURNS VARCHAR(128)
AS
BEGIN
	DECLARE @Result VARCHAR(32)
	SELECT @Result = Name FROM Statuses WHERE StatusId = @StatusId
	RETURN @Result
END
GO
/****** Object:  UserDefinedFunction [dbo].[udfGetUserNameByUserId]    Script Date: 2/1/2017 3:11:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udfGetUserNameByUserId]
(
	@UserId INT
)
RETURNS VARCHAR(128)
AS
BEGIN
	DECLARE @Result VARCHAR(128)
	SELECT @Result = Name + ' ' + Lastname FROM Users WHERE UserId = @UserId
	RETURN @Result
END

GO
/****** Object:  UserDefinedFunction [dbo].[udfGetUserRoles]    Script Date: 2/1/2017 3:11:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udfGetUserRoles]
(
	@UserId INT
)
RETURNS VARCHAR(128)
AS
BEGIN
	DECLARE @Result VARCHAR(128)
	SELECT @Result =
	(
		SELECT ' ' + r.Name
			FROM Roles r
				INNER JOIN UserRoleXREF urx ON r.RoleId = urx.RoleId
			WHERE urx.UserId = @UserId
			ORDER BY r.Name
			FOR XML PATH('')
	)
	RETURN @Result
END
GO
/****** Object:  Table [dbo].[Actions]    Script Date: 2/1/2017 3:11:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Actions](
	[ActionId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](32) NULL,
 CONSTRAINT [PK_Actions] PRIMARY KEY CLUSTERED 
(
	[ActionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Facturas]    Script Date: 2/1/2017 3:11:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Facturas](
	[FacturaId] [int] IDENTITY(1,1) NOT NULL,
	[RFC] [varchar](16) NULL,
	[PDF] [varchar](256) NULL,
	[XML] [varchar](256) NULL,
	[Folio] [varchar](32) NULL,
	[Fecha] [datetime] NULL,
	[Sucursal] [varchar](8) NULL,
	[CodigoCliente] [varchar](64) NULL,
	[RazonSocial] [varchar](128) NULL,
	[ID] [varchar](16) NULL,
	[Total] [decimal](18, 2) NULL,
	[Subtotal] [decimal](18, 2) NULL,
	[IVA] [decimal](18, 2) NULL,
	[IEPS] [decimal](18, 2) NULL,
	[Serie] [varchar](8) NULL,
 CONSTRAINT [PK_Facturas] PRIMARY KEY CLUSTERED 
(
	[FacturaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Logs]    Script Date: 2/1/2017 3:11:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Logs](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[ActionId] [int] NULL,
	[ActionName]  AS ([dbo].[udfGetActionNameByActionId]([ActionId])),
	[PerformedBy] [int] NULL,
	[PerformedByName]  AS ([dbo].[udfGetUserNameByUserId]([PerformedBy])),
	[Performed] [datetime] NULL,
	[SearchText] [varchar](256) NULL,
	[InvoiceId] [int] NULL,
 CONSTRAINT [PK_Logs] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 2/1/2017 3:11:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](64) NULL,
	[Description] [varchar](256) NULL,
	[Created] [datetime] NULL CONSTRAINT [DF_Roles_Created]  DEFAULT (getdate()),
	[CreatedBy] [int] NULL,
	[CreatedByName]  AS ([dbo].[udfGetUserNameByUserId]([CreatedBy])),
	[LastUpdated] [datetime] NULL CONSTRAINT [DF_Roles_LastUpdated]  DEFAULT (getdate()),
	[LastUpdatedBy] [int] NULL,
	[LastUpdatedByName]  AS ([dbo].[udfGetUserNameByUserId]([LastUpdatedBy])),
	[ActiveFlag] [bit] NOT NULL CONSTRAINT [DF_Roles_ActiveFlag]  DEFAULT ((1)),
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Statuses]    Script Date: 2/1/2017 3:11:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Statuses](
	[StatusId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](32) NULL,
 CONSTRAINT [PK_Statuses] PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SysParameters]    Script Date: 2/1/2017 3:11:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SysParameters](
	[ParameterId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](64) NULL,
	[Value] [varchar](1024) NULL,
 CONSTRAINT [PK_SysParameters] PRIMARY KEY CLUSTERED 
(
	[ParameterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserRoleXREF]    Script Date: 2/1/2017 3:11:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoleXREF](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
	[Created] [datetime] NULL CONSTRAINT [DF_UserRoleXREF_Created]  DEFAULT (getdate()),
 CONSTRAINT [PK_UserRoleXREF] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 2/1/2017 3:11:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](64) NULL,
	[Lastname] [varchar](64) NULL CONSTRAINT [DF_Users_Lastname]  DEFAULT (''),
	[Phone] [varchar](32) NULL,
	[Email] [varchar](64) NULL,
	[Mobile] [varchar](32) NULL,
	[Created] [datetime] NULL CONSTRAINT [DF_Users_Created_1]  DEFAULT (getdate()),
	[CreatedBy] [int] NULL,
	[CreatedByName]  AS ([dbo].[udfGetUserNameByUserId]([CreatedBy])),
	[LastUpdated] [datetime] NULL CONSTRAINT [DF_Users_LastUpdated_1]  DEFAULT (getdate()),
	[LastUpdatedBy] [int] NULL,
	[LastUpdatedByName]  AS ([dbo].[udfGetUserNameByUserId]([LastUpdatedBy])),
	[ActiveFlag] [bit] NOT NULL CONSTRAINT [DF_Users_ActiveFlag_1]  DEFAULT ((1)),
	[Username] [varchar](32) NULL,
	[Password] [varchar](32) NULL,
	[StatusId] [int] NULL,
	[StatusName]  AS ([dbo].[udfGetStatusNameByStatusId]([StatusId])),
	[RFC] [varchar](16) NULL,
	[CommercialName] [varchar](128) NULL,
	[UserRoles]  AS ([dbo].[udfGetUserRoles]([UserId])),
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Logs]  WITH CHECK ADD  CONSTRAINT [FK_Logs_ActionId] FOREIGN KEY([ActionId])
REFERENCES [dbo].[Actions] ([ActionId])
GO
ALTER TABLE [dbo].[Logs] CHECK CONSTRAINT [FK_Logs_ActionId]
GO
ALTER TABLE [dbo].[Logs]  WITH CHECK ADD  CONSTRAINT [FK_Logs_PerformedBy] FOREIGN KEY([PerformedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Logs] CHECK CONSTRAINT [FK_Logs_PerformedBy]
GO
ALTER TABLE [dbo].[Roles]  WITH CHECK ADD  CONSTRAINT [FK_Roles_CreatedBy] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Roles] CHECK CONSTRAINT [FK_Roles_CreatedBy]
GO
ALTER TABLE [dbo].[Roles]  WITH CHECK ADD  CONSTRAINT [FK_Roles_LastUpdatedBy] FOREIGN KEY([LastUpdatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Roles] CHECK CONSTRAINT [FK_Roles_LastUpdatedBy]
GO
ALTER TABLE [dbo].[UserRoleXREF]  WITH CHECK ADD  CONSTRAINT [FK_UserRoleXREF_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[UserRoleXREF] CHECK CONSTRAINT [FK_UserRoleXREF_RoleId]
GO
ALTER TABLE [dbo].[UserRoleXREF]  WITH CHECK ADD  CONSTRAINT [FK_UserRoleXREF_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UserRoleXREF] CHECK CONSTRAINT [FK_UserRoleXREF_UserId]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_LastUpdatedBy] FOREIGN KEY([LastUpdatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_LastUpdatedBy]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_StatusId] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Statuses] ([StatusId])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_StatusId]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_UserId] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_UserId]
GO
USE [master]
GO
ALTER DATABASE [CCFN] SET  READ_WRITE 
GO
