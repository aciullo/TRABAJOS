

SELECT 
 
f.IdFactura,
f.Fecha,
f.NroProyecto,
p.Descripcion DesProyecto,
f.Numero,
CLI.Nombre, 
CLI.RazSocial,
cli.Ruc,
cli.Direccion,
v.IdVendedor,
v.NombreVendedor,
f.IdMoneda,
f.Cotizacion,
f.NroContrato,
f.Numero,
s.Descripción DesSucursal,
c.Descripcion TipoComp,
CV.Descripcion Condicion,
LP.Descripcion ListaPrecio,
ISNULL(rtrim(clides.Nombre),'') + '' + ISNULL(rtrim(clides.RazSocial ),'') CliDestino
 from vt_factura		 AS F
 INNER JOIN st_movimiento_Det md    ON (md.IdFactura=f.IdFactura AND md.IdEmpresa=f.IdEmpresa) 
 INNER JOIN Vt_cpbt		 AS C		ON (F.IdComprobante=C.IdComprobante AND f.IdEmpresa=c.IdEmpresa)
 INNER JOIN vt_clientes  AS CLI		ON (CLI.IdCliente=F.IdCliente AND F.IdEmpresa=CLI.IdEmpresa)
 INNER JOIN vt_Condicion AS cv		ON (cv.IdCondicion=f.IdCondicion AND cv.IdEmpresa=f.IdEmpresa)
 INNER JOIN	sucursal	 AS s		ON (f.Sucursal=s.Sucursal AND F.IdEmpresa=S.IdEmpresa)
 LEFT  JOIN vt_clientes  AS clides  ON (f.IdCliente1=clides.IdCliente AND F.IdEmpresa=clides.IdEmpresa)
 LEFT  JOIN vt_ListaPrecio  AS LP	ON (f.IdLista=lp.IdLista AND F.IdEmpresa=LP.IdEmpresa)
 LEFT  JOIN pr_Proyecto		AS p	ON (p.IdProyecto=f.NroProyecto AND p.IdEmpresa=f.IdEmpresa)
 LEFT  JOIN vvt_Vendedores	AS v	ON (v.IdVendedor=f.IdVendedor AND v.IdEmpresa=f.idempresa)
WHERE

C.Abrev LIKE '%NC%'
AND 
f.IdEmpresa='050'

SELECT * FROM vt_GestionCobro

SELECT * FROM vt_Hab_Caja where IdHabilitacion=360


SELECT * FROM vt_factura WHERE IdEmpresa='050' AND IdCiclo=27277--AND TIPO='H'
ORDER BY Fecha DESC
SELECT * FROM vt_factura_dele

select * from vvt_Vendedores
select * from vt_Vendedores

select * from pr_Proyecto
select * from vt_ListaPrecio

select * from clientes --where idempresa='050'
select * from vt_clientes where idempresa='050' and IdCliente1 is not null
select * from vt_factura WHERE IdEmpresa='050' and IdFactura=27271
select * from st_movimiento_Det where IdEmpresa='050' and IdFactura=27271



