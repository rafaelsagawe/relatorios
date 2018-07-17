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
