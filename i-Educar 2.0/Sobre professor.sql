-- Query's relativas aos professores 

-- Alocação de servidor com base em turma
select servidor.nm, servidor.nm_Turma, cadastro.pessoa.nome
from
	(select
	cadastro.pessoa.nome as nm,
	pmieducar.turma.nm_turma as nm_Turma,
	pmieducar.turma.ref_ref_cod_escola,
	pmieducar.escola.ref_idpes,
	cadastro.juridica.idpes as cod_ue
	from pmieducar.servidor
	join cadastro.pessoa
	on cadastro.pessoa.idpes=pmieducar.servidor.cod_servidor
	join modules.professor_turma
	on modules.professor_turma.servidor_id=pmieducar.servidor.cod_servidor
	join pmieducar.turma
	on pmieducar.turma.cod_turma=modules.professor_turma.turma_id
	join pmieducar.escola
	on pmieducar.escola.cod_escola=pmieducar.turma.ref_ref_cod_escola
	join cadastro.juridica
	on cadastro.juridica.idpes=pmieducar.escola.ref_idpes) 
as servidor
join cadastro.pessoa on cadastro.pessoa.idpes=servidor.cod_ue
order by servidor.nm, servidor.cod_ue, servidor.nm_Turma

-- Função do Servidor
select servidor.nm, cadastro.pessoa.nome, servidor.nm_Turma, servidor.nome as Disciplina
from
	(select
	cadastro.pessoa.nome as nm,
	pmieducar.turma.nm_turma as nm_Turma,
	modules.componente_curricular.nome,
	pmieducar.turma.ref_ref_cod_escola,
	pmieducar.escola.ref_idpes,
	cadastro.juridica.idpes as cod_ue
	from pmieducar.servidor
	join cadastro.pessoa
	on cadastro.pessoa.idpes=pmieducar.servidor.cod_servidor
	join modules.professor_turma
	on modules.professor_turma.servidor_id=pmieducar.servidor.cod_servidor
	join pmieducar.turma
	on pmieducar.turma.cod_turma=modules.professor_turma.turma_id
	join pmieducar.escola
	on pmieducar.escola.cod_escola=pmieducar.turma.ref_ref_cod_escola
	join cadastro.juridica
	on cadastro.juridica.idpes=pmieducar.escola.ref_idpes
	join pmieducar.servidor_disciplina 
	on pmieducar.servidor.cod_servidor=pmieducar.servidor_disciplina.ref_cod_servidor
	join modules.componente_curricular 
	on modules.componente_curricular.id=pmieducar.servidor_disciplina.ref_cod_disciplina)
as servidor
join cadastro.pessoa on cadastro.pessoa.idpes=servidor.cod_ue
order by servidor.nm, servidor.cod_ue, servidor.nm_Turma

-- Graduação do servidor
select
	cadastro.pessoa.nome as servidor,
	cadastro.escolaridade.descricao,
	pmieducar.servidor.codigo_curso_superior_1
	from pmieducar.servidor
	join cadastro.pessoa
	on cadastro.pessoa.idpes=pmieducar.servidor.cod_servidor
	join modules.professor_turma
	on modules.professor_turma.servidor_id=pmieducar.servidor.cod_servidor
	join cadastro.escolaridade
	on cadastro.escolaridade.idesco=pmieducar.servidor.ref_idesco
	--join modules.educacenso_curso_superior
	--on modules.educacenso_curso_superior.id=pmieducar.servidor.codigo_curso_superior_1

	
	
	