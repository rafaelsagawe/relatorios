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