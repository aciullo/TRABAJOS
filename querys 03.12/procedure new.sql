CREATE procedure cn_balance2
 @empresa char(3)
, @dfecha date
, @hfecha date
, @ejercicio int 
, @sucursal char(2)
, @centro char(2)
, @moneda char(1)

as

--SET @empresa='050'
--SET @dfecha='01/01/10'
--SET @hfecha='01/01/15'

--SET @ejercicio='2014'
--SET @sucursal= '01'
--SET @centro='%'
--SET @moneda='L'


CREATE TABLE #BALACT ( CUENTA VARCHAR(100),NIVEL int ,SALDO NUMERIC(18,2))

INSERT  #BALACT
EXECUTE  cn_balance @empresa, @dfecha,@hfecha, @ejercicio,@sucursal,@centro,@moneda


SET @dfecha= (SELECT convert (varchar(10),DATEPART(day,@dfecha)) + '/' + convert (varchar(10), datepart(month, @dfecha)) + '/' +  convert (varchar(10),datepart(year, @dfecha)-1) )

SET @hfecha= (SELECT convert (varchar(10),DATEPART(day,@hfecha)) + '/' + convert (varchar(10), datepart(month, @hfecha)) + '/' +  convert (varchar(10),datepart(year, @hfecha)-1) )

SET @ejercicio= @ejercicio-1

CREATE TABLE #BALANTERIOR ( CUENTA VARCHAR(100),NIVEL int ,SALDO NUMERIC(18,2))

INSERT  #BALANTERIOR
EXECUTE  cn_balance @empresa, @dfecha,@hfecha, @ejercicio,@sucursal,@centro,@moneda


SELECT B1.*, ISNULL(B2.SALDO,0) AS SALDOANTERIOR
FROM #BALACT B1
left join #BALANTERIOR B2
ON B1.cuenta=b2.CUENTA
and b1.Nivel=b2.NIVEL



DROP TABLE #BALANTERIOR,#BALACT
	


--exec cn_balance '050', '01/01/10','01/01/15', '2014', '01', '%','L'



 

 
--exec cn_balance '050', '01/01/10','01/01/15', '2013', '01', '%','L' 
----from cn_cuenta
--Declare @Cuenta_Egresos CHAR(1),@cuenta_Activo CHAR(1)
--set  	@Cuenta_Egresos = CONVERT(CHAR(1),dbo.LeerConstante('050','CN_CUENTA_EGRESOS'),1)
--SET	@cuenta_Activo = CONVERT(CHAR(1),dbo.LeerConstante('050','CN_CUENTA_ACTIVO'),1)
--select @Cuenta_Egresos e,@cuenta_Activo a
--select   cuenta,	
--	sum(case when left(cuenta,1) in (1,5) then debe-haber else haber-debe end / 
--		(case when 'L' = 'L' then 1 else cotizacion end)) as saldo
----into #a
--from cn_asientos a inner join cn_detalle d on a.idasiento = d.idAsiento
--where a.ejercicio = '2014' and
--	a.idempresa = '050' and 
--	a.fecha between '01/01/10' and '01/01/15' and
--	a.sucursal like '01' 
--	--and
--	--d.centro like @centro
--and tipo<>'C'	
--group by cuenta
--having sum(debe-haber) <> 0 
--order by cuenta


--select * from bs_Monedas