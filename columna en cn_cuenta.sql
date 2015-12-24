USE [Futura]
GO

/****** Object:  Table [dbo].[cn_cuentas]    Script Date: 12/21/2015 11:23:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

alter TABLE [dbo].[cn_cuentas]
	add 
	[sinonimoSET] [char](15) NULL,
	estadofinanciero CHAR (1) NULL

GO

SET ANSI_PADDING OFF
GO

