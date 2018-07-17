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

