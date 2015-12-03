select *  into #a from (exec cn_balance '050', '01/01/10','01/01/15', '2014', '01', '%','L')ab
 
exec cn_balance '050', '01/01/10','01/01/15', '2013', '01', '%','L' 
--from cn_cuenta
Declare @Cuenta_Egresos CHAR(1),@cuenta_Activo CHAR(1)
set  	@Cuenta_Egresos = CONVERT(CHAR(1),dbo.LeerConstante('050','CN_CUENTA_EGRESOS'),1)
SET	@cuenta_Activo = CONVERT(CHAR(1),dbo.LeerConstante('050','CN_CUENTA_ACTIVO'),1)
select @Cuenta_Egresos e,@cuenta_Activo a
select   cuenta,	
	sum(case when left(cuenta,1) in (1,5) then debe-haber else haber-debe end / 
		(case when 'L' = 'L' then 1 else cotizacion end)) as saldo
--into #a
from cn_asientos a inner join cn_detalle d on a.idasiento = d.idAsiento
where a.ejercicio = '2014' and
	a.idempresa = '050' and 
	a.fecha between '01/01/10' and '01/01/15' and
	a.sucursal like '01' 
	--and
	--d.centro like @centro
and tipo<>'C'	
group by cuenta
having sum(debe-haber) <> 0 
order by cuenta


select * from bs_Monedas