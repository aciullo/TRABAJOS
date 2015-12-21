
DECLARE
	@empresa CHAR(3),
		@dfecha DATE,
		@hfecha DATE,
		@ejercicio INT,
		@sucursal CHAR(2),
		@centro  CHAR(2),
		@moneda CHAR(2)

SET		@empresa = N'050'
SET		@dfecha = N'01/01/00'
SET		@hfecha = N'01/01/16'
SET		@ejercicio = 2014
SET		@sucursal = N'01'
SET		@centro = N'%'
SET		@moneda = N'L'


Declare @Cuenta_Egresos CHAR(1),@cuenta_Activo CHAR(1)
set  	@Cuenta_Egresos = CONVERT(CHAR(1),dbo.LeerConstante(@empresa,'CN_CUENTA_EGRESOS'),1)
SET	@cuenta_Activo = CONVERT(CHAR(1),dbo.LeerConstante(@empresa,'CN_CUENTA_ACTIVO'),1)



--select mc.cuenta sinonimoSET,mc.descripción,c.Ejercicio , c.nivel, mc.integradora integradoraset,c.Cuenta, c.Integradora
--into #c
--from cn_cuentas  c
--inner join cn_ModeloCuentas_Det mc ON c.sinonimoSET=mc.cuenta and mc.idmodelo=5
--where idempresa = @empresa
--and ejercicio = @ejercicio

select MC.cuenta sinonimoSET,mc.descripción,c.Ejercicio , c.nivel, mc.integradora integradoraset,c.Cuenta
into #c
from cn_cuentas  c
inner join cn_ModeloCuentas_Det mc ON c.sinonimoSET COLLATE Modern_Spanish_CI_AS =mc.cuenta and mc.idmodelo=5
where idempresa = @empresa
and ejercicio = @ejercicio
	
	SELECT * FROM #c
--Creamos el orden jerarquico de las cuentas
select  isnull(c1.sinonimoSET,'') c1, isnull(c2.sinonimoSET,'') c2,
 isnull(c3.sinonimoSET,'') c3, isnull(c4.sinonimoSET,'') c4,isnull(c5.sinonimoSET,'') c5

into #t1
from #c c1 right join #c c2 on  c1.sinonimoSET = c2.integradoraSET 
	right join #c c3 on c2.sinonimoSET = c3.integradoraSET 
	right join #c c4 on c3.sinonimoSET = c4.integradoraSET 
	right join #c c5 on c4.sinonimoSET = c5.integradoraSET 
	
order by c1,c2,c3, c4, c5

SELECT * FROM #t1

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

SELECT * FROM #a


select isnull(c5,isnull(c4,isnull(c3,isnull(c2,isnull(c1,''))))) as cuenta,
	sum(saldo) as saldo
--into #t2
from #a  inner join #C C ON C.Cuenta=#a.cuenta
INNER JOIN  #t1 on C.sinonimoSET = left(c5,9)
group by --#a.cuenta 
c1,c2,c3,c4,c5  
with rollup
order by cuenta



--SELECT * FROM #t2,#t2,

drop table #T1,#c,#a