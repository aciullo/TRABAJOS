

select 
f.IdFactura,
c.Descripcion TipoComp,
f.Numero,


F.*, CLI.Nombre, CLI.RazSocial from vt_factura F
, Vt_cpbt C, vt_clientes CLI, vt_Condicion cv
WHERE
(F.IdComprobante=C.IdComprobante AND f.IdEmpresa=c.IdEmpresa)
AND
(CLI.IdCliente=F.IdCliente AND F.IdEmpresa=CLI.IdEmpresa)
AND
(cv.IdCondicion=f.IdCondicion AND cv.IdEmpresa=f.IdEmpresa)
AND
C.Abrev LIKE '%NC%'
and 
f.IdEmpresa='050'

SELECT * FROM vt_GestionCobro

SELECT * FROM vt_Hab_Caja where IdHabilitacion=360


SELECT * FROM vt_factura WHERE IdEmpresa='050' --AND TIPO='H'
ORDER BY Fecha DESC
SELECT * FROM vt_factura_dele





