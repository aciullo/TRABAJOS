--alter PROCEDURE ts_notacredicli (@idempresa char(3),@dfecha date,@hfecha date,@sucursal char(3))
--as
--begin
declare @dfecha date, @hfecha date, @sucursal char(3)
SELECT 
f1.IdFactura,
f1.Fecha,
f1.NroProyecto,
p1.Descripcion DesProyecto,
f1.Numero,
RTRIM(cli1.IdCliente)  + COALESCE (+ '-' +RTRIM( CLI1.Nombre),'') + '-' + CLI1.RazSocial Cliente,
cli1.Ruc,
cli1.Direccion,
v1.IdVendedor,
v1.NombreVendedor,
f1.IdMoneda,
f1.Cotizacion,
f1.NroContrato,
f1.Numero,
s1.Sucursal,
s1.Descripción DesSucursal,
c1.Descripcion TipoComp,
CV1.Descripcion Condicion,
LP1.Descripcion ListaPrecio,
ISNULL(rtrim(clides1.Nombre),'') + '' + ISNULL(rtrim(clides1.RazSocial ),'') CliDestino,
fd1.IdProducto Producto,
fd1.Descripcion,
fd1.Cantidad,
fd1.Precio
 from vt_factura		 AS F1
 INNER JOIN st_movimiento_Det AS fd1 ON (f1.IdFactura=fd1.IdFactura and f1.IdEmpresa=fd1.IdEmpresa)
 INNER JOIN Vt_cpbt		 AS C1		ON (F1.IdComprobante=C1.IdComprobante AND f1.IdEmpresa=c1.IdEmpresa)
 INNER JOIN vt_clientes  AS CLI1	ON (CLI1.IdCliente=F1.IdCliente AND F1.IdEmpresa=CLI1.IdEmpresa)
 INNER JOIN vt_Condicion AS cv1		ON (cv1.IdCondicion=f1.IdCondicion AND cv1.IdEmpresa=f1.IdEmpresa)
 INNER JOIN	sucursal	 AS s1		ON (f1.Sucursal=s1.Sucursal AND F1.IdEmpresa=S1.IdEmpresa)
 LEFT  JOIN vt_clientes  AS clides1  ON (f1.IdCliente1=clides1.IdCliente AND F1.IdEmpresa=clides1.IdEmpresa)
 LEFT  JOIN vt_ListaPrecio  AS LP1	ON (f1.IdLista=lp1.IdLista AND F1.IdEmpresa=LP1.IdEmpresa)
 LEFT  JOIN pr_Proyecto		AS p1	ON (p1.IdProyecto=f1.NroProyecto AND p1.IdEmpresa=f1.IdEmpresa)
 LEFT  JOIN vvt_Vendedores	AS v1	ON (v1.IdVendedor=f1.IdVendedor AND v1.IdEmpresa=f1.idempresa)
WHERE

C1.Abrev LIKE '%NC%'
AND 
fd1.VISIBLE = ( 1 )
and
f1.IdEmpresa= '050'

--and
--f1.IdEmpresa= @idempresa
and ( (F1.fecha between @dfecha and @hfecha) or  @dfecha IS NULL OR  @hfecha IS NULL )
and (S1.sucursal=@sucursal or @sucursal is null) 
and cli1.IdCliente=0671
--end


select  precio, real, * from st_movimiento_Det where IdFactura='27297'

select * from st_movimiento_Det  where IdFactura='27297'


select * from vt_ListaPrecio

--exec sp_executesql N'SELECT St_movimiento_det.IdEmpresa, St_movimiento_det.IdDetalle, St_movimiento_det.IdMovimiento, St_movimiento_det.IdCompra, St_movimiento_det.IdFactura, St_movimiento_det.IdRemision, St_movimiento_det.IdComprobante, St_movimiento_det.Número, St_movimiento_det.IdProducto, St_movimiento_det.Talle, St_movimiento_det.Lote, St_movimiento_det.Categoria, St_movimiento_det.Cantidad, St_movimiento_det.Precio, St_movimiento_det.Ult_Costo, St_movimiento_det.Costo_Pro, St_movimiento_det.Iva, St_movimiento_det.Descuento, St_movimiento_det.Descripcion, St_movimiento_det.real, St_movimiento_det.Vendedor, St_movimiento_det.Agrupa, St_movimiento_det.IdDetalleGrupo, St_movimiento_det.GrupoSer, St_movimiento_det.Modelo, St_movimiento_det.Marca, St_movimiento_det.Serie, St_movimiento_det.IdListaPrecio, St_movimiento_det.IdDeposito_Sal, St_movimiento_det.IdDeposito_Ent, St_movimiento_det.Cuenta, St_movimiento_det.Clase, St_movimiento_det.PNeto, St_movimiento_det.PBruto, St_movimiento_det.ITotal, St_movimiento_det.IPromedio, St_movimiento_det.TipoMov, St_movimiento_det.PgAncho, St_movimiento_det.obs, St_movimiento_det.Comision, St_movimiento_det.GravadaIncluido, St_movimiento_det.ValorIva, St_movimiento_det.RegimenTurismo, St_movimiento_det.IdCliente, LEFT(descripcion,254) AS descrip, St_movimiento_det.Imprime, St_movimiento_det.PrecioLista, St_movimiento_det.dSerie, St_movimiento_det.hSerie FROM  dbo.st_movimiento_Det St_movimiento_det WHERE  St_movimiento_det.IdFactura = ( @P1  ) AND  St_movimiento_det.VISIBLE = ( 1 )',N'@P1 float',27284

--SELECT * FROM vt_Hab_Caja where IdHabilitacion=360


--SELECT * FROM vt_factura WHERE IdEmpresa='050' AND IdCiclo=27277--AND TIPO='H'
--ORDER BY Fecha DESC
--SELECT * FROM vt_factura_dele

--select * from vvt_Vendedores
--select * from vt_Vendedores

--select * from pr_Proyecto
--select * from vt_ListaPrecio

--select * from clientes --where idempresa='050'
--select * from vt_clientes where idempresa='050' and IdCliente1 is not null
--select * from vt_factura WHERE IdEmpresa='050' and IdFactura=27271
--select * from st_movimiento_Det where IdEmpresa='050' and IdFactura=27271



--sp_help sucursal