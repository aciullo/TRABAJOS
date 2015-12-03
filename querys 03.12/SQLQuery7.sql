declare @empresa as char(3)

declare @dfecha datetime, 
@hfecha datetime, 
@ejercicio int,
@sucursal char(2), 
@centro char(2),
@moneda char(1)

set @empresa = '050'
set @ejercicio='2014'



select * 
into #c
from cn_cuentas
where idempresa = @empresa 
	and ejercicio = @ejercicio
	
--Creamos el orden jerarquico de las cuentas
select  isnull(c1.cuenta,'') c1, isnull(c2.cuenta,'') c2,
 isnull(c3.cuenta,'') c3, isnull(c4.cuenta,'') c4,isnull(c5.cuenta,'') c5
into #t1
from #c c1 right join #c c2 on  c1.cuenta = c2.integradora 
	right join #c c3 on c2.cuenta = c3.integradora 
	right join #c c4 on c3.cuenta = c4.integradora 
	right join #c c5 on c4.cuenta = c5.integradora 
order by c1,c2,c3, c4, c5

select * from #c
select * from #t1