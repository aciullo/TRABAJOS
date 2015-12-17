declare @idempresa char(3), @dfecha date, @hfecha date,@sucursal char(3)
set @idempresa='050'
set @dfecha='01/01/00'
set @hfecha='01/01/16'

	SELECT     c.IdCliente, rtrim(c.idcliente)+'-'+c.razsocial cliente, v.sucursal + s.descripción as sucursal,
	SUM(CASE when MONTH(v.Fecha)=1 then vd.Importe_pag else 0 end) as I1,
	SUM(CASE when MONTH(v.Fecha)=2 then vd.Importe_pag else 0 end) as I2,
	SUM(CASE when MONTH(v.Fecha)=3 then vd.Importe_pag else 0 end) as I3,
	SUM(CASE when MONTH(v.Fecha)=4 then vd.Importe_pag else 0 end) as I4,
	SUM(CASE when MONTH(v.Fecha)=5 then vd.Importe_pag else 0 end) as I5,
	SUM(CASE when MONTH(v.Fecha)=6 then vd.Importe_pag else 0 end) as I6,
	SUM(CASE when MONTH(v.Fecha)=7 then vd.Importe_pag else 0 end) as I7,
	SUM(CASE when MONTH(v.Fecha)=8 then vd.Importe_pag else 0 end) as I8,
	SUM(CASE when MONTH(v.Fecha)=9 then vd.Importe_pag else 0 end) as I9,
	SUM(CASE when MONTH(v.Fecha)=10 then vd.Importe_pag else 0 end) as I10,
	SUM(CASE when MONTH(v.Fecha)=11 then vd.Importe_pag else 0 end) as I11,
	SUM(CASE when MONTH(v.Fecha)=12 then vd.Importe_pag else 0 end) as I12,
	SUM(vd.Importe_pag) as IT--,
	FROM         vt_pagos v 
				inner join vt_det_pagos VD on v.idpago=VD.idpago and v.idempresa=@idempresa	
				INNER JOIN sucursal AS s ON s.Sucursal=v.sucursal AND s.IdEmpresa=v.idempresa 
				inner join ts_valores_base AS tv ON tv.idcobro=v.idpago 
				LEFT OUTER JOIN bs_bancos AS b ON tv.idbanco = b.idbanco 
				LEFT OUTER JOIN ts_tipovalor AS tpv ON tv.idtipovalor = tpv.idtipovalor 
				left join vt_clientes c on v.idcliente=c.idcliente and v.IdEmpresa = c.idempresa 
				left join vt_cobradores d on v.idcobrador=d.idcobrador  and v.IdEmpresa = d.idempresa	
				left join bs_personas e on d.idpersona=e.idpersona 	
				left join vt_factura f on VD.idfactura=f.idfactura 	
	WHERE v.idempresa = @idempresa
	AND v.fecha between @dfecha and  @hfecha and 
	(v.sucursal=@sucursal or @sucursal is null)
	group by v.sucursal + s.descripción,  c.IdCliente,  rtrim(c.idcliente)+'-'+c.razsocial
	order by v.sucursal + s.descripción,   c.IdCliente,  rtrim(c.idcliente)+'-'+c.razsocial
