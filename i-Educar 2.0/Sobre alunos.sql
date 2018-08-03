-- Querys relativas aos alunos

-- Quantitativos por generos
-- Metodo A
select
	case cadastro.fisica.sexo when 'M' then
		count (cadastro.fisica.sexo) end as Masculino,
	case cadastro.fisica.sexo when 'F' then
		count (cadastro.fisica.sexo) end as Feminino
from pmieducar.aluno
join cadastro.fisica
on cadastro.fisica.idpes=pmieducar.aluno.ref_idpes
group by cadastro.fisica.sexo;

-- Metodo B
select
cadastro.fisica.sexo,
	case cadastro.fisica.sexo when 'M' then
		count (cadastro.fisica.sexo)
		else count (cadastro.fisica.sexo) end as Genero
	--case cadastro.fisica.sexo when 'F' then
from pmieducar.aluno
join cadastro.fisica
on cadastro.fisica.idpes=pmieducar.aluno.ref_idpes
group by cadastro.fisica.sexo;

-- Absorção de alunos de outros municipios
-- cod INEP - Alunos - Pessoa Fisica - lograouro - Bairro - Municipio
select
pmieducar.matricula.ano,
modules.educacenso_cod_aluno.cod_aluno_inep,
cadastro.pessoa.nome as NomeAluno,
public.logradouro.nome as Logradouro,
public.bairro.nome as bairro,
public.municipio.nome as Municipio,
public.municipio.sigla_uf
from pmieducar.aluno
join pmieducar.matricula
on pmieducar.matricula.ref_cod_aluno=pmieducar.aluno.cod_aluno
join modules.educacenso_cod_aluno
on modules.educacenso_cod_aluno.cod_aluno=pmieducar.aluno.cod_aluno
join cadastro.fisica
on cadastro.fisica.idpes=pmieducar.aluno.ref_idpes
join cadastro.pessoa
on cadastro.pessoa.idpes=cadastro.fisica.idpes
join cadastro.endereco_pessoa
on cadastro.endereco_pessoa.idpes=pmieducar.aluno.ref_idpes
join public.bairro
on public.bairro.idbai=cadastro.endereco_pessoa.idbai
join public.logradouro
on public.logradouro.idlog=cadastro.endereco_pessoa.idlog
join public.municipio
on public.municipio.idmun=public.logradouro.idmun
--where public.municipio.nome  'São Paulo'
order by public.municipio.nome

-- Quantitativo de alunos por municipio
select
count (public.municipio.nome) as QTD,
public.municipio.nome as Municipios
from pmieducar.aluno
join cadastro.fisica
on cadastro.fisica.idpes=pmieducar.aluno.ref_idpes
join cadastro.pessoa
on cadastro.pessoa.idpes=cadastro.fisica.idpes
join cadastro.endereco_pessoa
on cadastro.endereco_pessoa.idpes=pmieducar.aluno.ref_idpes
join public.logradouro
on public.logradouro.idlog=cadastro.endereco_pessoa.idlog
join public.municipio
on public.municipio.idmun=public.logradouro.idmun
group by public.municipio.nome
order by public.municipio.nome

-- Alunos NE
-- Lista de alunos NE
select
--cadastro.fisica_deficiencia.ref_idpes,
cadastro.pessoa.nome,
pmieducar.aluno.ref_idpes,
cadastro.deficiencia.nm_deficiencia
from cadastro.fisica_deficiencia
join cadastro.deficiencia on cadastro.deficiencia.cod_deficiencia=cadastro.fisica_deficiencia.ref_cod_deficiencia
-- Filtro para sá aparecer os alunos
join pmieducar.aluno on pmieducar.aluno.ref_idpes=cadastro.fisica_deficiencia.ref_idpes
join cadastro.pessoa on cadastro.pessoa.idpes=pmieducar.aluno.ref_idpes

-- Quantitativo por NE
 select
count (pmieducar.aluno.ref_idpes),
cadastro.deficiencia.nm_deficiencia
from cadastro.fisica_deficiencia
join cadastro.deficiencia on cadastro.deficiencia.cod_deficiencia=cadastro.fisica_deficiencia.ref_cod_deficiencia
-- Filtro para sá aparecer os alunos
join pmieducar.aluno on pmieducar.aluno.ref_idpes=cadastro.fisica_deficiencia.ref_idpes
group by cadastro.deficiencia.nm_deficiencia

-- media de idade dos alunos
select
cast (avg (extract (year from age(cadastro.fisica.data_nasc)))as integer) as media
--pmieducar.matricula.ref_ref_cod_serie,
--pmieducar.aluno.cod_aluno
--extract (year from age(cadastro.fisica.data_nasc)) -- cria a idade com ponto flutuante
from cadastro.fisica
join cadastro.pessoa on cadastro.pessoa.idpes=cadastro.fisica.idpes
join pmieducar.aluno on pmieducar.aluno.ref_idpes=cadastro.fisica.idpes

-- idade dos alunos
select distinct
alunos.nm_aluno, alunos.Idade, alunos.serie, cadastro.pessoa.nome
from
	(
	-- Listagem de alunos com data de nascimento e idade
	select
	cadastro.pessoa.nome as nm_aluno,
	--cadastro.fisica.idpes,
	cadastro.fisica.data_nasc as DataNascimento,
	cast (extract (year from age(cadastro.fisica.data_nasc)) as integer) as Idade,
	pmieducar.serie.nm_serie as serie,
	pmieducar.matricula.ref_ref_cod_escola
	--pmieducar.aluno.cod_aluno
	--extract (year from age(cadastro.fisica.data_nasc)) -- cria a idade com ponto flutuante
	from cadastro.fisica
	join cadastro.pessoa on cadastro.pessoa.idpes=cadastro.fisica.idpes
	join pmieducar.aluno on pmieducar.aluno.ref_idpes=cadastro.fisica.idpes
	join pmieducar.matricula on pmieducar.matricula.ref_cod_aluno=pmieducar.aluno.cod_aluno
	join pmieducar.serie on pmieducar.serie.cod_serie=pmieducar.matricula.ref_ref_cod_serie
	)
as alunos
join pmieducar.escola on pmieducar.escola.cod_escola=alunos.ref_ref_cod_escola
join cadastro.pessoa on cadastro.pessoa.idpes=pmieducar.escola.ref_idpes

-- Vagas
select ano,
cadastro.pessoa.nome as ue,
pmieducar.serie.nm_serie,
pmieducar.turma_turno.nome as turno,
vagas
from pmieducar.serie_vaga
join pmieducar.serie on pmieducar.serie.cod_serie=pmieducar.serie_vaga.ref_cod_serie
join pmieducar.turma_turno on pmieducar.turma_turno.id=pmieducar.serie_vaga.turno
join pmieducar.escola on pmieducar.escola.cod_escola=pmieducar.serie_vaga.ref_cod_escola
join cadastro.pessoa on cadastro.pessoa.idpes=pmieducar.escola.ref_idpes

-- Relatório de Freguência para geração da FICAI
select cadastro.pessoa.nome as aluno,
modules.falta_componente_curricular.etapa as bimestre,
modules.falta_componente_curricular.quantidade as faltas
from modules.falta_componente_curricular
join modules.falta_aluno on modules.falta_aluno.id=modules.falta_componente_curricular.falta_aluno_id
join pmieducar.matricula on pmieducar.matricula.cod_matricula=modules.falta_aluno.matricula_id
join pmieducar.aluno on pmieducar.aluno.cod_aluno=pmieducar.matricula.ref_cod_aluno
join cadastro.pessoa on cadastro.pessoa.idpes=pmieducar.aluno.ref_idpes
where modules.falta_componente_curricular.quantidade > 10

-- Levantamento de notas
select
cadastro.pessoa.nome as aluno,
modules.componente_curricular.nome as disciplina,
modules.nota_componente_curricular.etapa,
modules.nota_componente_curricular.nota_arredondada
from modules.nota_componente_curricular
join modules.nota_aluno on modules.nota_aluno.id=modules.nota_componente_curricular.nota_aluno_id
join pmieducar.matricula on pmieducar.matricula.cod_matricula=modules.nota_aluno.matricula_id
join pmieducar.aluno on pmieducar.aluno.cod_aluno=pmieducar.matricula.ref_cod_aluno
join cadastro.pessoa on cadastro.pessoa.idpes=pmieducar.aluno.ref_idpes
join modules.componente_curricular on modules.componente_curricular.id=modules.nota_componente_curricular.componente_curricular_id
