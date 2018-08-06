-- Codigo para a criação do formulario com numeros de cadastros das escolas
-- Usar como base a tabela escola
-- Usar o ID de pessoa juridica para pegar os nomes
-- Usar o ID de Escola para Pegar o INEP

<<<<<<< HEAD
-- Codigo para a criação do formulario com numeros de cadastros das escolas
-- Usar como base a tabela escola
-- Usar o ID de pessoa juridica para pegar os nomes
-- Usar o ID de Escola para Pegar o INEP
select cadastro.juridica.fantasia, cadastro.juridica.cnpj,
modules.educacenso_cod_escola.cod_escola_inep
from pmieducar.escola
join cadastro.juridica
on pmieducar.escola.ref_idpes=cadastro.juridica.idpes
join modules.educacenso_cod_escola
on pmieducar.escola.cod_escola=modules.educacenso_cod_escola.cod_escola

=======
>>>>>>> cd16d4eea3674f66868608ce3cc86ec8d571a119
-- Lista de nomes das escolas
select
cadastro.juridica.fantasia
from pmieducar.escola
join cadastro.juridica
on pmieducar.escola.ref_idpes=cadastro.juridica.idpes

-- Endereço das escola
select cadastro.juridica.fantasia as UE,
public.logradouro.nome as logradouro,
cadastro.endereco_pessoa.numero,
public.bairro.nome as bairro,
cadastro.endereco_pessoa.cep
from pmieducar.escola
join cadastro.juridica
on pmieducar.escola.ref_idpes=cadastro.juridica.idpes
join cadastro.endereco_pessoa
on cadastro.endereco_pessoa.idpes=cadastro.juridica.idpes
join public.bairro
on cadastro.endereco_pessoa.idbai=public.bairro.idbai
join public.logradouro
on cadastro.endereco_pessoa.idlog=public.logradouro.idlog

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

-- Relatorio de TI das escolas
-- Caso a acesso_internet = 0 'Não' senão 'Sim'
select cadastro.juridica.fantasia,
pmieducar.escola.dependencia_laboratorio_informatica as Lab,
pmieducar.escola.copiadoras,
pmieducar.escola.retroprojetores,
pmieducar.escola.impressoras,
pmieducar.escola.projetores_digitais,
pmieducar.escola.computadores,
pmieducar.escola.computadores_administrativo,
pmieducar.escola.computadores_alunos,
--pmieducar.escola.acesso_internet,
	case pmieducar.escola.acesso_internet
		when '0' then 'Não'
		else 'Sim'
	end
from pmieducar.escola
join cadastro.juridica
on pmieducar.escola.ref_idpes=cadastro.juridica.idpes

-- Relatorio municipal
select
sum(pmieducar.escola.computadores_alunos) as pc_aluno,
sum(pmieducar.escola.dependencia_laboratorio_informatica) as lab,
sum(pmieducar.escola.copiadoras) as cop,
sum(pmieducar.escola.retroprojetores) as retro,
sum(pmieducar.escola.impressoras) as imp,
sum(pmieducar.escola.projetores_digitais) as projetor,
sum(pmieducar.escola.computadores_administrativo) as pc_adm,
sum(pmieducar.escola.acesso_internet) as net
from pmieducar.escola

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
pmieducar.escola.condicao, -- Forma de ocupação
pmieducar.escola.area_terreno_total,
pmieducar.escola.area_construida,
pmieducar.escola.area_disponivel,
pmieducar.escola.num_pavimentos
from pmieducar.escola
join cadastro.juridica
on pmieducar.escola.ref_idpes=cadastro.juridica.idpes
join modules.educacenso_cod_escola
on pmieducar.escola.cod_escola=modules.educacenso_cod_escola.cod_escola

-- Tamanho das Salas de aula
select cadastro.juridica.fantasia,
pmieducar.infra_predio.nm_predio,
nm_comodo, area
from pmieducar.infra_predio_comodo
join pmieducar.infra_predio
on pmieducar.infra_predio.cod_infra_predio=pmieducar.infra_predio_comodo.ref_cod_infra_predio
join pmieducar.escola
on pmieducar.escola.cod_escola=pmieducar.infra_predio.ref_cod_escola
join cadastro.juridica
on cadastro.juridica.idpes=pmieducar.escola.ref_idpes
