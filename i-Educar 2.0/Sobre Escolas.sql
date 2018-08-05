-- Codigo para a criação do formulario com numeros de cadastros das escolas
-- Usar como base a tabela escola
-- Usar o ID de pessoa juridica para pegar os nomes
-- Usar o ID de Escola para Pegar o INEP

-- Lista de nomes das escolas
select
cadastro.juridica.fantasia
from pmieducar.escola
join cadastro.juridica
on pmieducar.escola.ref_idpes=cadastro.juridica.idpes

--Dados de identificação das escolas
select
cadastro.juridica.fantasia,
cadastro.juridica.cnpj,
modules.educacenso_cod_escola.cod_escola_inep
from pmieducar.escola
join cadastro.juridica
on pmieducar.escola.ref_idpes=cadastro.juridica.idpes
join modules.educacenso_cod_escola
on pmieducar.escola.cod_escola=modules.educacenso_cod_escola.cod_escola

-- Numero de funcionarios
select
modules.educacenso_cod_escola.cod_escola_inep as INEP,
cadastro.juridica.fantasia,
pmieducar.escola.total_funcionario
from pmieducar.escola
join cadastro.juridica
on pmieducar.escola.ref_idpes=cadastro.juridica.idpes
join modules.educacenso_cod_escola
on pmieducar.escola.cod_escola=modules.educacenso_cod_escola.cod_escola
order by pmieducar.escola.total_funcionario

-- Email das UE
select distinct
modules.educacenso_cod_escola.cod_escola_inep as INEP,
cadastro.juridica.fantasia,
cadastro.pessoa.email
from pmieducar.escola
join cadastro.juridica
on pmieducar.escola.ref_idpes=cadastro.juridica.idpes
join modules.educacenso_cod_escola
on pmieducar.escola.cod_escola=modules.educacenso_cod_escola.cod_escola
join cadastro.pessoa
on cadastro.pessoa.idpes=cadastro.juridica.idpes
order by cadastro.juridica.fantasia

-- Relação de diretores inep - Escola - Nome do Diretor - Telefone diretor
select distinct
modules.educacenso_cod_escola.cod_escola_inep as INEP,
cadastro.juridica.fantasia,
cadastro.pessoa.nome,
pmieducar.escola.email_gestor
from pmieducar.escola
join cadastro.juridica
on pmieducar.escola.ref_idpes=cadastro.juridica.idpes
join modules.educacenso_cod_escola
on pmieducar.escola.cod_escola=modules.educacenso_cod_escola.cod_escola
join cadastro.pessoa
on cadastro.pessoa.idpes=pmieducar.escola.ref_idpes_gestor
order by cadastro.juridica.fantasia

-- Infraestrutura
select cadastro.juridica.fantasia, cadastro.juridica.cnpj,
modules.educacenso_cod_escola.cod_escola_inep,
pmieducar.escola.condicao,
pmieducar.escola.area_terreno_total,
pmieducar.escola.area_construida,
pmieducar.escola.area_disponivel,
pmieducar.escola.num_pavimentos
from pmieducar.escola
join cadastro.juridica
on pmieducar.escola.ref_idpes=cadastro.juridica.idpes
join modules.educacenso_cod_escola
on pmieducar.escola.cod_escola=modules.educacenso_cod_escola.cod_escola

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
