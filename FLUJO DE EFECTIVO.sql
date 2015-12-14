
SELECT 
 
SUM(F.TotalFactura) 
VENTASNETAS

 from vt_factura		 AS F
 
WHERE

--C.Abrev LIKE '%F%'
--AND
f.IdEmpresa='050'
and
F.IdMoneda='GS'
and 
f.IdComprobante <>'NC'
and
F.Anulado<>1
AND
datepart(year,f.fecha)=2014

--FALTA RESTAR LAS DEVOLUCIONES

(SELECT ISNULL(SUM(F2.TOTALFACTURA),0) NOTASCREDITO FROM vt_factura F2
WHERE 
f2.IdEmpresa='050'
and
F2.IdMoneda='GS'
and 
f2.IdComprobante = 'NC'
AND
F2.Anulado<>1
and
datepart(year,f2.fecha)=2014)




--SELECT * FROM vt_Condicion
--SELECT idfactura, exenta, gravada, Gravada10,Gravada5, iva, totalfactura FROM vt_factura WHERE IdEmpresa='050' 
--ORDER BY FECHA DESC

----SELECT * FROM vt_Condicion
--SELECT * FROM vt_factura WHERE IdEmpresa='050' AND IdCondicion NOT LIKE '%co%'
--ORDER BY FECHA DESC

SELECT * FROM vt_factura WHERE IdEmpresa='050' AND IdCondicion  LIKE '%co%' and IdComprobante like '%cr%' and numero=1088
ORDER BY FECHA DESC
SELECT * FROM vt_factura WHERE IdEmpresa='050' and IdComprobante like '%nc%' and NUMERO_REF=1088
ORDER BY FECHA DESC
--SELECT * FROM vt_factura WHERE IdEmpresa='050' and Numero=1071

--select * from vt_cpbt WHERE IdEmpresa='050' 
--select * from cn_iva_detalle WHERE IdEmpresa='050' 

--select * from st_movimiento_Det where IdEmpresa='050' and idfactura is not null
--select * from vt_cpbt


--select * from st_movimiento_Det where IdFactura=27255

/*PAGO A PROVEEDORES (NETO)*/

SELECT  
   SUM(b.importe_pag) AS importe_pag
  
FROM             cp_pagos_base	  AS a 
INNER JOIN       cp_pagosdet_base AS b ON a.idpago = b.idpago 

WHERE  a.idempresa='050' and datepart(year,A.fecha)=2015
AND 
A.idmoneda='GS'


/*EFECTIVO PAGADO A LOS EMPLEADOS*/


SELECT * FROM rh_liquida_conceptos
SELECT * FROM rh_liquidacion
SELECT * FROM rh_liquidet
select * from rh_procesos


exec sp_executesql N'SELECT Rh_liquidacion.idempresa, Rh_liquidacion.idliquidacion, Rh_liquidacion.nroliquidacion, Rh_liquidacion.descripcion, Rh_liquidacion.fecha, Rh_liquidacion.mes, Rh_liquidacion.año, Rh_liquidacion.idfrecuencia, Rh_liquidacion.confirmado, Rh_liquidacion.fechahora, Rh_liquidacion.dFecha, Rh_liquidacion.hFecha, Rh_liquidacion.IdSeccion, Rh_liquidacion.Tipo FROM  dbo.rh_liquidacion Rh_liquidacion WHERE  Rh_liquidacion.idempresa = ( @P1  ) AND  Rh_liquidacion.idliquidacion = ( @P2  ) ORDER BY Rh_liquidacion.idliquidacion',N'@P1 varchar(3),@P2 float','050',54
go