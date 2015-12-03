SELECT 
db.nrooperacion
,CASE WHEN DB.idcuenta IS NULL THEN 
(SELECT rtrim(nombre)+'  '+idmoneda  FROM ts_cuentas	
WHERE DB.idcuenta_ent= ts_cuentas.idcuenta)
ELSE
(SELECT rtrim(nombre)+'  '+idmoneda  FROM ts_cuentas	
WHERE DB.idcuenta= ts_cuentas.idcuenta)
END
nombrecuenta
,db.fecha
, op.descripcion TipoOperacion
,ISNULL( db.totalcheque,0) totalcheque
,ISNULL( db.totalefectivo,0) totalefectivo
, tv.tipovalor 
, ISNULL(b.descripcion,'') Banco
,dtd.nrocheque
,ISNULL( dtd.importe,0) importe
,ech.estado_cheque estadoOperacion
FROM  ts_depositos_base AS db
INNER JOIN   ts_detdepos_base AS dtd ON db.iddeposito = dtd.iddeposito
INNER JOIN ts_tipovalor AS tv		ON dtd.tipovalor= tv.idtipovalor	
INNER JOIN   ts_operacion	AS op	ON db.idoperacion = op.idoperacion	
left JOIN bs_bancos AS B ON dtd.idbanco=b.idbanco
LEFT  JOIN  ts_estado_cheque AS ech ON dtd.idestado = ech.idestado
where 
db.idempresa='050'

--AND 
--db.fecha Between @dfecha and @hfecha
ORDER BY 2,1

select * from ts_operacion