-- listagem de quantitativo de alunos por turma e vagas 
select turmas.ue, turmas.series, 
--turmas.turma, 
sum (turmas.qtdAlunos) as qtdAlunos, 
sum (turmas.lotacaoMax) as maximo,
(sum (turmas.lotacaoMax) - sum (turmas.qtdAlunos)) as vagas,
turmas.ano
from
			(select cadastro.juridica.fantasia as ue,
			pmieducar.serie.nm_serie as series,
			pmieducar.turma.nm_turma as turma,
			count (pmieducar.matricula_turma.ref_cod_turma) as qtdAlunos, 
			pmieducar.turma.max_aluno as lotacaoMax,
			pmieducar.turma.ano as ano
			from pmieducar.turma
			join pmieducar.matricula_turma on pmieducar.matricula_turma.ref_cod_turma=pmieducar.turma.cod_turma
			join pmieducar.escola on pmieducar.escola.cod_escola=pmieducar.turma.ref_ref_cod_escola
			join cadastro.juridica on cadastro.juridica.idpes=pmieducar.escola.ref_idpes
			join pmieducar.serie on pmieducar.serie.cod_serie=pmieducar.turma.ref_ref_cod_serie
			group by cadastro.juridica.fantasia, pmieducar.turma.nm_turma, pmieducar.turma.cod_turma, 
			pmieducar.turma.max_aluno,pmieducar.matricula_turma.ref_cod_turma, pmieducar.serie.nm_serie)
as turmas
group by  turmas.ue, turmas.series, turmas.ano