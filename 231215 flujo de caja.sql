
declare @empresa char(3), 
@dfecha datetime, 
@hfecha datetime, 
@ejercicio int,
@sucursal char(2), 
@centro char(2),
@moneda char(1)


set		@empresa = N'045'
set		@dfecha = N'01/01/15'
set		@hfecha = N'30/12/15'
set		@ejercicio = 2015
set		@sucursal = N'01'
set		@centro = N'%'
set		@moneda = N'L'
--Declaramos las Variables para indicar las cuentas del Activo e Ingresos
Declare @Cuenta_Egresos CHAR(1),@cuenta_Activo CHAR(1)
set  	@Cuenta_Egresos = CONVERT(CHAR(1),dbo.LeerConstante(@empresa,'CN_CUENTA_EGRESOS'),1)
SET	@cuenta_Activo = CONVERT(CHAR(1),dbo.LeerConstante(@empresa,'CN_CUENTA_ACTIVO'),1)



--Sumamos el movimiento de las cuentas
select   cuenta,	
	sum(case when left(cuenta,1) in (@Cuenta_Activo,@Cuenta_Egresos) then debe-haber else haber-debe end / 
		(case when @moneda = 'L' then 1 else cotizacion end)) as saldo
into #a
from cn_asientos a inner join cn_detalle d on a.idasiento = d.idAsiento
where a.ejercicio = @ejercicio and 
	a.idempresa = @empresa and 
	a.fecha between @dfecha and @hfecha and
	a.sucursal like @sucursal and
	d.centro like @centro
and tipo<>'C'	
group by cuenta
having sum(debe-haber) <> 0 
order by cuenta

select * from #a

select sum(saldo),p.codcuenta, p.nroplanilla

from #a  a
INNER JOIN cn_planillasdet1 p
on a.cuenta=p.codcuenta
--where p.nroplanilla=10

group by p.codcuenta, p.nroplanilla






drop table #a







--select mc.CUENTA sinonimoSET,mc.descripción,c.Ejercicio , mc.nivel, mc.integradora integradoraset,c.Cuenta
--into #c
--from cn_cuentas  c
--inner join cn_ModeloCuentas_Det mc ON c.sinonimoSET=mc.cuenta and mc.idmodelo=5
--where idempresa = @empresa
--and ejercicio = @ejercicio

----Creamos el orden jerarquico de las cuentas
--select  isnull(c1.sinonimoSET,'') c1, isnull(c2.sinonimoSET,'') c2,
-- isnull(c3.sinonimoSET,'') c3, isnull(c4.sinonimoSET,'') c4,isnull(c5.sinonimoSET,'') c5
--into #t1
--from #c c1 right join #c c2 on  c1.sinonimoSET = c2.integradoraSET 
--	right join #c c3 on c2.sinonimoSET = c3.integradoraSET 
--	right join #c c4 on c3.sinonimoSET = c4.integradoraSET 
--	right join #c c5 on c4.sinonimoSET = c5.integradoraSET 

--order by c1,c2,c3, c4, c5


----Sumamos el movimiento de las cuentas
--select   cuenta,	
--	sum(case when left(cuenta,1) in (@Cuenta_Activo,@Cuenta_Egresos) then debe-haber else haber-debe end / 
--		(case when @moneda = 'L' then 1 else cotizacion end)) as saldo
--into #a
--from cn_asientos a inner join cn_detalle d on a.idasiento = d.idAsiento
--where a.ejercicio = @ejercicio and 
--	a.idempresa = @empresa and 
--	a.fecha between @dfecha and @hfecha and
--	a.sucursal like @sucursal and
--	d.centro like @centro
--and tipo<>'C'	
--group by cuenta
--having sum(debe-haber) <> 0 
--order by cuenta


--select * from #a
----select * from #t1
----Relacionamos las cuentas con sus saldos y creamos los totales con rollup
--select isnull(c5,isnull(c4,isnull(c3,isnull(c2,isnull(c1,''))))) as cuenta,
--	sum(saldo) as saldo
--into #t2
--from #a  inner join #C C ON C.Cuenta=#a.cuenta
--INNER JOIN  #t1 on C.sinonimoSET = left(c5,9)
--group by c1,c2,c3,c4,c5  with rollup
--order by cuenta


----Eliminamos los totales reduntantes en jerarquias no normalizadas
--select #t2.cuenta+descripción cuenta ,nivel, 
--sum(saldo) as saldo
--from #t2 inner join #c on #c.sinonimoSET = #t2.cuenta
--where #t2.cuenta <>''
--group by #t2.cuenta+descripción, nivel
--order by #t2.cuenta+descripción
--drop table #t1
--drop table #c
--drop table #a
--drop table #t2
