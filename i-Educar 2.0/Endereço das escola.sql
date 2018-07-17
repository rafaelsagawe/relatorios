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
