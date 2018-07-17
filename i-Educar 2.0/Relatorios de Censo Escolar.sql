-- Relatório - Alunos Dados Cadastrais
select distinct 
row_number() over(order by nm_aluno asc) as ordem,
modules.educacenso_cod_aluno.cod_aluno_inep, 
alunos.nm_aluno, 
alunos.Idade, 
--alunos.serie, 
cadastro.pessoa.nome, 
alunos.DataNascimento, alunos.genero, 
alunos.cpf, alunos.nis_pis_pasep
from 
	(
	select
	pmieducar.aluno.cod_aluno,
	cadastro.pessoa.nome as nm_aluno,
	cadastro.fisica.data_nasc as DataNascimento,
	cast (extract (year from age(cadastro.fisica.data_nasc)) as integer) as Idade,
	cadastro.fisica.sexo,
		case cadastro.fisica.sexo
			when 'M' then 'Masculino'
			else 'Feminino'
		end as genero,
	pmieducar.serie.nm_serie as serie,
	pmieducar.matricula.ref_ref_cod_escola,
	cadastro.fisica.nis_pis_pasep,
	cadastro.fisica.cpf
	from cadastro.fisica
	join cadastro.pessoa on cadastro.pessoa.idpes=cadastro.fisica.idpes
	join pmieducar.aluno on pmieducar.aluno.ref_idpes=cadastro.fisica.idpes
	join pmieducar.matricula on pmieducar.matricula.ref_cod_aluno=pmieducar.aluno.cod_aluno
	join pmieducar.serie on pmieducar.serie.cod_serie=pmieducar.matricula.ref_ref_cod_serie
	)
as alunos
join pmieducar.escola on pmieducar.escola.cod_escola=alunos.ref_ref_cod_escola
join cadastro.pessoa on cadastro.pessoa.idpes=pmieducar.escola.ref_idpes
join modules.educacenso_cod_aluno on modules.educacenso_cod_aluno.cod_aluno=alunos.cod_aluno
order by alunos.nm_aluno
