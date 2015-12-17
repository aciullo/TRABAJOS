declare @idempresa char(3), @dfecha date, @hfecha date,@sucursal char(3)
set @idempresa='050'


select a.idpago
,a.sucursal codsuc
,a.num_recibo
,a.tip_reci
,a.fecha
,rtrim(a.idcliente)+'-'+c.razsocial cliente
,	rtrim(a.idcobrador)+'-'+rtrim(e.nombre)+' '+rtrim(e.apellido) cobrador
,c.Ruc
,VD.numero
,VD.idmoneda,VD.importe,VD.importe_pag,f.fecha fechafact,TotalFacturas,f.Idcomprobante,VD.Cuota	
,v.nrocheque, v.fchcheque, v.importe, b.descripcion AS Banco, tv.tipovalor,IdCobro,S.Descripción sucursal 
from vt_pagos a 
inner join vt_det_pagos VD on a.idpago=VD.idpago and a.idempresa=@idempresa	
INNER JOIN sucursal AS s ON s.Sucursal=A.sucursal AND s.IdEmpresa=A.idempresa 
inner join ts_valores_base AS v ON V.idcobro=A.idpago 
LEFT OUTER JOIN bs_bancos AS b ON v.idbanco = b.idbanco 
LEFT OUTER JOIN ts_tipovalor AS tv ON v.idtipovalor = tv.idtipovalor 
left join vt_clientes c on a.idcliente=c.idcliente and a.IdEmpresa = c.idempresa 
left join vt_cobradores d on a.idcobrador=d.idcobrador  and a.IdEmpresa = d.idempresa	
left join bs_personas e on d.idpersona=e.idpersona 	
left join vt_factura f on VD.idfactura=f.idfactura 	
where 	 ( (A.fecha between @dfecha and @hfecha) or  @dfecha IS NULL OR  @hfecha IS NULL ) and (S.sucursal=@sucursal or @sucursal is null) 


--	SELECT     v.nrocheque, v.fchcheque, v.importe, b.descripcion AS Banco, tv.tipovalor,IdCobro
--FROM         ts_valores_base AS v LEFT OUTER JOIN
--                      bs_bancos AS b ON v.idbanco = b.idbanco LEFT OUTER JOIN
--                      ts_tipovalor AS tv ON v.idtipovalor = tv.idtipovalor
--                      where v.IdCobro= ?m.IdRecibo


--					  select * from vt_clientes where IdCliente='0001'
SELECT * FROM vt_det_pagos

select * from bs_Monedas