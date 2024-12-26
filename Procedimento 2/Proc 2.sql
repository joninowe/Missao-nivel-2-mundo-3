use Loja;

insert into usuario
values (1, 'op1', 'op1'),(2, 'op2', 'op2');

insert into produto
values (1, 'Banana', 100, 5.00),(3, 'Laranja', 500, 2.00),(4, 'Manga', 800, 4.00);

insert into pessoa
values (NEXT VALUE FOR seq_Pessoa, 'Joao', 'Rua 12, cas 3, Quitanda', 
'Riacho do Sul', 'PA', '1111-1111','joao@riacho.com');

insert into pessoa
values (NEXT VALUE FOR seq_Pessoa, 'JJC', 'Rua 11, Centro', 
'Riacho do Norte', 'PA', '1212-1212','jjc@riacho.com');

insert into pessoa_fisica
values (1,'11111111111');

insert into pessoa_juridica
values (2,'22222222222222');

insert into movimento
values (1,1,1,1,20,'S',4.00),
(4,1,1,3,15,'S',2.00),
(5,2,1,3,10,'S',3.00),
(7,1,2,3,15,'E',5),
(8,1,2,4,20,'E',4.00);

-- Dados completos de pessoas físicas.
select *
from pessoa, pessoa_fisica
where pessoa.idpessoa = pessoa_fisica.idpessoa_fisica;

--Dados completos de pessoas jurídicas.
select *
from pessoa, pessoa_juridica
where pessoa.idpessoa = pessoa_juridica.idpessoa_juridica;

--Movimentações de entrada, com produto, fornecedor, quantidade, preço unitário e valor total.
select idmovimento, produto_idproduto, produto.nome as 'Produto',pessoa_idpessoa, pessoa.nome as 'Fornecedor', movimento.quantidade, valorUnitario,
(movimento.quantidade *  valorUnitario) as valor_total
from movimento
join pessoa
on movimento.pessoa_idpessoa = pessoa.idpessoa
join produto 
on movimento.produto_idproduto = produto.idproduto
where movimento.tipo = 'E';

--Movimentações de saída, com produto, comprador, quantidade, preço unitário e valor total
select idmovimento, produto_idproduto, produto.nome as 'Produto',pessoa_idpessoa, pessoa.nome as 'Comprador', movimento.quantidade, valorUnitario,
(movimento.quantidade * valorUnitario) as valor_total
from movimento
join pessoa
on movimento.pessoa_idpessoa = pessoa.idpessoa
join produto 
on movimento.produto_idproduto = produto.idproduto
where movimento.tipo = 'S';

--Valor total das entradas agrupadas por produto.
select produto.nome, SUM (movimento.quantidade * movimento.valorUnitario) AS 'VALOR TOTAL ENTRADAS'
from movimento
JOIN produto
on produto.idproduto = movimento.produto_idproduto 
where movimento.tipo = 'E'
group by produto.nome;

--Valor total das saídas agrupadas por produto.
select produto.nome, SUM (movimento.quantidade * movimento.valorUnitario) AS 'VALOR TOTAL SAIDAS'
from movimento
JOIN produto
on produto.idproduto = movimento.produto_idproduto 
where movimento.tipo = 'S'
group by produto.nome;

--Operadores que não efetuaram movimentações de entrada (compra).
select movimento.Usuario_idUsuario AS 'ID DO OPERADOR'
from movimento
except
select movimento.Usuario_idUsuario
from movimento
where movimento.tipo = 'E';

--Valor total de entrada, agrupado por operador.
select usuario.login AS OPERADOR, SUM (movimento.quantidade * movimento.valorUnitario) AS 'VALOR TOTAL ENTRADAS'
from movimento
JOIN usuario
on usuario.idusuario = movimento.Usuario_idUsuario 
where movimento.tipo = 'E'
group by usuario.login;

--Valor total de saída, agrupado por operador.
select usuario.login AS OPERADOR, SUM (movimento.quantidade * movimento.valorUnitario) AS 'VALOR TOTAL SAIDAS'
from movimento
JOIN usuario
on usuario.idusuario = movimento.Usuario_idUsuario 
where movimento.tipo = 'S'
group by usuario.login;

--Valor médio de venda por produto, utilizando média ponderada.
select produto.nome, SUM (movimento.quantidade * movimento.valorUnitario) / SUM(movimento.quantidade) as 'Valor médio de venda'
from movimento
JOIN produto
on produto.idproduto = movimento.produto_idproduto 
where movimento.tipo = 'S'
group by produto.nome;


