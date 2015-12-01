-- ================================================
-- Template generated from Template Explorer using:
-- Create Scalar Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION saldoanterior
(
	-- Add the parameters for the function here
	@dfecha date, @idempresa varchar(10),@idproveedor char(6)
)
RETURNS numeric(18,2)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @saldoant as numeric(18,2)

	-- Add the T-SQL statements to compute the return value here
	set @saldoant=(SELECT sum(Total) AS importe 
		FROM cp_factura a inner join cp_Condicion cp on a.IdCondicion = cp.IdCondicion and a.IdEmpresa=cp.IdEmpresa 
		WHERE  a.idproveedor = @idproveedor 
		and a.fecha <= @dfecha  and a.IdEmpresa=@idEmpresa and a.IdCuentaPago is null and cp.Plazo>0 )
	
	set @saldoant= isnull(@saldoant,0)- (SELECT sum(Isnull(b.importe_pag,0)) as importe  
			 FROM cp_pagos_base a, cp_pagosdet_base b
			 WHERE a.idpago = b.idpago 
			  and a.fecha <= @dfecha 
			  AND a.idproveedor = @idproveedor and a.IdEmpresa=@idEmpresa)

			  
			  
	-- Return the result of the function
	RETURN @saldoant

END
GO

