drop table if exists alocacoes;
drop table if exists projetos;
drop table if exists funcionarios;

create table projetos
(codp char(2) not null primary key,
nomep varchar(50) not null,
linguagem varchar(20),
custo numeric not null,
cliente varchar(30));

insert into projetos values ('p1', 'projeto1', 'python', 300000, 'cli1');
insert into projetos values ('p2', 'projeto2', 'python', 400000, 'cli1');
insert into projetos values ('p3', 'projeto3', 'cobol', 400000, 'cli1');
insert into projetos values ('p4', 'projeto4', 'java', 200000, 'cli2');
insert into projetos values ('p5', 'projeto5', 'java', 50000, 'cli2');
insert into projetos values ('p6', 'projeto6', 'java', 200000, 'cli3');
insert into projetos values ('p7', 'projeto7', NULL, 50000, 'cli3');

-- ====================
-- Funções de sumarização min, max, sum e avg
-- a)	Considerando os projetos do cliente cli1, o custo do projeto mais barato, 
-- mais caro, a médio do custo dos projetos, e o custo total de todos seus projetos
select * from projetos where cliente = 'cli1' order by custo;

select 
	min(custo) as custoMin,
	max(custo) as custoMax, 
	avg(custo) as custoMed,
	sum(custo) as custoTotal
from projetos 
where cliente = 'cli1';

-- ====================
-- Função count: count(*) vs count(atributo) vs count(distinct atributo)
-- b)	Considerando os projetos do cliente cli3, o número de projetos e de linguagens usadas
select * from projetos where cliente = 'cli3' order by linguagem;

select count(*) as num_projetos, count(distinct linguagem) as num_linguagens from projetos
where cliente = 'cli3';

-- c)	considerando os projetos em java, o número de projetos e o número de clientes envolvidos
select * from projetos where linguagem = 'java' order by cliente;

select count(*) as num_projetos, count(distinct cliente) as num_clientes
from projetos
where linguagem = 'java';

-- ====================
--	Cláusula group by
-- d)	Para cada linguagem, o número de projetos, o custo do projeto mais barato e mais caro. 
select * from projetos order by linguagem, custo;

select linguagem, count(*) as num_projetos, min(custo) as custoMin, max(custo) as custoMax from projetos
group by linguagem;

-- e)	para cada cliente, o custo total de seus projetos em java
select * from projetos where linguagem = 'java' order by cliente;

select cliente, sum(custo) as custoTotalJava from projetos
where linguagem = 'java'
group by cliente;

-- ====================
-- 	Cláusula Where vs Having
-- f)	considerando apenas projetos de no mínimo 100000, para cada cliente que tem projetos 
-- em mais de uma linguagem, o nome do cliente, e o número de projetos. 
select * from projetos where custo >= 100000 order by cliente, linguagem;

select cliente, count(*) as num_projetos from projetos 
where custo >= 100000
group by cliente 
having count(distinct linguagem) > 1;

-- g)	considerando apenas projetos em java, o nome do cliente e custo total de seus projetos, 
-- desde que o cliente só tenha projetos com custo acima de 100000.
select * from projetos where linguagem = 'java' order by cliente;

select cliente, sum(custo) as custoTotal from projetos
where linguagem = 'java'
group by cliente
having min(custo) >= 100000;


-- ===== ESCOLHENDO TABELAS
-- considere funcionários que são alocados em projetos (tabelas funcionarios e alocacoes)
create table funcionarios
(codf char(2) not null primary key,
nomef varchar(10) not null,
salario numeric not null);

insert into funcionarios values ('f1', 'maria', 10000);
insert into funcionarios values ('f2', 'pedro', 5000);
insert into funcionarios values ('f3', 'carlos', 7000);
insert into funcionarios values ('f4', 'pedro', 15000);

create table alocacoes
(codp char(2) not null references projetos,
codf char(2) not null references funcionarios,
horas numeric not null,
funcao varchar(15),
primary key (codp, codf));

insert into alocacoes values ('p1', 'f1', 10, 'programador');
insert into alocacoes values ('p1', 'f2', 20, 'analista');
insert into alocacoes values ('p2', 'f1', 15, 'programador');
insert into alocacoes values ('p2', 'f2', 20, 'analista');
insert into alocacoes values ('p4', 'f1', 5, 'analista');
insert into alocacoes values ('p5', 'f3', 10, 'programador');
insert into alocacoes values ('p4', 'f4', 10, 'programador');
insert into alocacoes values ('p3', 'f2', 10, 'programador');
insert into alocacoes values ('p3', 'f4', 5, 'programador');

-- Escolhendo as tabelas
-- h)	Para cada projeto em python, o nome do projeto, o número de pessoas trabalhando e o total de horas alocadas
select p.nomep, count(a.codf) as num_pessoas, sum(a.horas) as total_horas from projetos p
join alocacoes a on p.codp=a.codp
where p.linguagem = 'pyhton'
group by p.nomep;

-- i)	Para cada funcionário, seu nome, e o número de projetos e de horas que trabalha
select f.nomef, count(distinct a.codp) as num_projetos, sum(a.horas) as total_horas from funcionarios f
left join alocacoes a on f.codf = a.codf
group by f.nomef;

-- j)	Para cada projeto, o número de pessoas alocadas (listar todos os projetos, mesmo os sem funcionarios alocados)
select p.nomep, count(a.codf) as num_pessoas from projetos p
left join alocacoes a on p.codp = a.codp
group by p.nomep;

-- k)	Considerando apenas os programadores, listar o nome do funcionário, 
-- número de projetos nos quais trabalha nesta função, e número de clientes
select f.nomef, count(distinct a.codp) as num_projetos, count(distinct p.cliente) as num_clientes from funcionarios f
join alocacoes a on f.codf = a.codf
join projetos p on a.codp = p.codp
where a.funcao = 'programador'
group by f.nomef;

-- Complicando
-- l)	listar o nome dos funcionários que exercem diferentes funções, e o número de projetos onde trabalham
select f.nomef, count(distinct a.codp) as num_projetos from funcionarios f
join alocacoes a on f.codf = a.codf
group by f.nomef
having count(distinct a.funcao) >1;

-- m)	 listar o nome dos funcionários que exercem diferentes funções, o número de projetos onde trabalham e o número de clientes para os quais trabalham
select f.nomef, count(distinct a.codp) as num_projetos, count(distinct p.cliente) as num_clientes from funcionarios f
join alocacoes a on f.codf = a.codf
join projetos p on a.codp = p.codp
group by f.nomef
having count(distinct a.funcao) >1;

-- n)	 listar o nome dos funcionários cujos projetos envolvem todos a mesma linguagem
select f.nomef from funcionarios f
join alocacoes a on f.codf = a.codf
join projetos p on a.codp = p.codp
group by f.nomef
having count(distinct p.linguagem) = 1;

-- o)	 listar o nome dos funcionários que trabalham para um único cliente
select f.nomef from funcionarios f
join alocacoes a on f.codf = a.codf
join projetos p on a.codp = p.codp
group by f.nomef
having count(distinct p.cliente) = 1;

-- p)	listar o nome dos funcionários cujos projetos são todos para clientes distintos
select f.nomef from funcionarios f
join alocacoes a on f.codf = a.codf
join projetos p on a.codp = p.codp
group by f.nomef
having count(distinct p.cliente) = count(distinct a.codp);

