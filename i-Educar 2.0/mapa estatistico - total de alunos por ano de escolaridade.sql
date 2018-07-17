-- Total de Alunos por Ano de Escolaridade

-- Series de cadas escola
select 
pmieducar.serie.nm_serie,
cadastro.juridica.fantasia as UE
from pmieducar.turma
join pmieducar.serie
on pmieducar.turma.ref_ref_cod_serie=pmieducar.serie.cod_serie
join pmieducar.escola
on pmieducar.escola.cod_escola=pmieducar.turma.ref_ref_cod_escola
join cadastro.juridica
on pmieducar.escola.ref_idpes=cadastro.juridica.idpes
group by 
turma.ref_ref_cod_serie,
pmieducar.serie.nm_serie,
pmieducar.turma.ref_ref_cod_escola,
pmieducar.escola.ref_idpes,
cadastro.juridica.fantasia
order by pmieducar.serie.nm_serie


--total de alunos por serie em escola
select 
count (distinct pmieducar.matricula.ref_cod_aluno) as "QTD aluno",
pmieducar.serie.nm_serie as series
--cadastro.juridica.fantasia
from  pmieducar.matricula
join pmieducar.serie
on pmieducar.serie.cod_serie=pmieducar.matricula.ref_ref_cod_serie
join pmieducar.escola
on pmieducar.matricula.ref_ref_cod_escola=pmieducar.escola.cod_escola
join cadastro.juridica
on cadastro.juridica.idpes=pmieducar.escola.ref_idpes
--where pmieducar.serie.nm_serie like '1%'
group by 
pmieducar.serie.nm_serie



-- quantidade alunos por escola
select 
count ((pmieducar.matricula.ref_cod_aluno)) as "QTD alunos",
cadastro.juridica.fantasia as UE
from pmieducar.matricula
join pmieducar.escola
on pmieducar.matricula.ref_ref_cod_escola=pmieducar.escola.cod_escola
join cadastro.juridica
on cadastro.juridica.idpes=pmieducar.escola.ref_idpes
group by 
cadastro.juridica.fantasia

-- usando o like
select 
count (distinct pmieducar.matricula.ref_cod_aluno),
pmieducar.serie.nm_serie as ANOdaSERIE,
cadastro.juridica.fantasia
from  pmieducar.matricula
join pmieducar.serie
on pmieducar.serie.cod_serie=pmieducar.matricula.ref_ref_cod_serie
join pmieducar.escola
on pmieducar.matricula.ref_ref_cod_escola=pmieducar.escola.cod_escola
join cadastro.juridica
on cadastro.juridica.idpes=pmieducar.escola.ref_idpes
--where pmieducar.serie.nm_serie like '1%' 
group by 
pmieducar.serie.nm_serie,
cadastro.juridica.fantasia
order by 
pmieducar.serie.nm_serie


