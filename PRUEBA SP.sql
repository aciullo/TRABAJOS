USE [Futura]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[cn_estadoresultado]
		@empresa = N'050',
		@dfecha = N'01/01/00',
		@hfecha = N'01/01/15',
		@ejercicio = 2014,
		@sucursal = N'01',
		@centro = N'%',
		@moneda = N'L'

SELECT	'Return Value' = @return_value

GO
