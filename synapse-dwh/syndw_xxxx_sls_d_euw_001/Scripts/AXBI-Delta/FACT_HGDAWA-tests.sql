select top(100) * from [pgr].[FACT_HGDAWA_delta]
order by DW_Id

select count(*) from [pgr].[FACT_HGDAWA_delta]
select count(*) from (
    select Invoiceno, Posno
    from [pgr].[FACT_HGDAWA_delta]
    group by Invoiceno, Posno
) a

select Invoiceno, Posno
from [pgr].[FACT_HGDAWA_delta]
group by Invoiceno, Posno
having COUNT(CONCAT(Invoiceno, Posno)) > 1

select * from [pgr].[FACT_HGDAWA_delta]
where Invoiceno = '5316SIN037237       '

select * from [pgr].[FACT_HGDAWA_delta]
where Invoiceno = '9999999999999       '

