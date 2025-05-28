-- crie uma base de dados para a aula de hoje
-- abra uma query tool para executar os comandos abaixo

drop table if exists escalacoes;
drop table if exists pilotos;
drop table if exists voos;
drop table if exists aeroportos;

create table aeroportos
(CODA	char(3) not null,
NOMEA 	varchar(20) not null,	
CIDADE 	varchar(20) not null,	
PAIS 	char(2) not null,
primary key(CODA));

insert into aeroportos values ('poa','salgado filho','porto alegre','BR');
insert into aeroportos values ('gru','guarulhos','sao paulo','BR');
insert into aeroportos values ('cgh','congonhas','sao paulo','BR');
insert into aeroportos values ('gal','galeao','rio de janeiro','BR');

select * from aeroportos;

create table voos
(CODV	char(5)	 not null,	
ORIGEM 	char(3)	 not null,	
DEST	char(3)	 not null,
HORA	numeric not null,
primary key(codv),
foreign key (origem) references aeroportos,
foreign key (dest) references aeroportos);

insert into voos values ('GL230','gru','poa','7');
insert into voos values ('GL330','gru','poa','11');
insert into voos values ('GL430','poa','gru','14');
insert into voos values ('GL530','gru','gal','17');
insert into voos values ('GL531','gal','poa','11');
insert into voos values ('GL630','cgh','poa','7');
insert into voos values ('GL730','cgh','poa','7');
insert into voos values ('TM100','gal','poa','7');

select * from voos; 

-- SELECIONANDO AS TABELAS NECESSARIAS
-- 1) Listar o código dos voos que partem do aeroporto de código GRU e chegam no aeroporto de código POA
select codv from voos where origem='gru' and dest='poa';

-- 2) Listar o código dos vôo cuja origem é um aeroporto em São Paulo
select v.codv from voos v join aeroportos a on v.origem=a.coda where a.cidade='sao paulo';

-- ===== ALIASES =============

-- 3) Listar o código dos vôos cujo destino é um aeroporto em Porto Alegre
select v.codv from voos v join aeroportos a on v.dest=a.coda where a.cidade='porto alegre';

-- 4) listar o código dos vôos cuja origem é um aeroporto em São Paulo e o destino, em Porto Alegre
select v.codv from voos v 
join aeroportos a1 on v.origem=a1.coda 
join aeroportos a2 on v.dest=a2.coda 
where a1.cidade='sao paulo' and a2.cidade = 'porto alegre';

--=== OPERACOES DE CONJUNTOS  ==========

create table pilotos
(CODP		char(3) not null,
NOMEP		varchar(10) not null,	
SALARIO		numeric not null,	
GRATIFICACOES	numeric not null,		
TEMPO		numeric not null,	
PAIS		char(2) not null,
COMPANHIA	varchar(10) not null,
primary key(codp));

-- INSTANCIAR TABELA PILOTOS
insert into pilotos values ('p11','joao', 3000, 200, 5,'BR','gol');
insert into pilotos values ('p12','paulo', 3000, 200, 3,'BR','gol');
insert into pilotos values ('p21','antonio', 1500, 300, 7,'BR','tam');
insert into pilotos values ('p22','carlos', 5000, 200, 10,'BR','tam');
insert into pilotos values ('p31','hanz', 5000, 1000, 6,'AL','lufthansa');

select * from pilotos;

create table escalacoes
(CODV	char(5) not null,	
DATA	char(5)	not null,
CODP	char(3),
AVIAO	varchar(10) not null,
primary key(codv, data),
foreign key (codp) references pilotos,
foreign key(codv) references voos);

-- inserir instancias
insert into escalacoes values('GL230','01/05','p11','737'); 
insert into escalacoes values('GL230','10/06','p11','737');
insert into escalacoes values('TM100','20/05','p21','777');
insert into escalacoes values('GL330','01/06','p12','737');
insert into escalacoes values('GL330','01/07','p12','777');
insert into escalacoes values('GL530','01/05','p12','777');
insert into escalacoes values('GL730','01/07',NULL,'777');

select * from escalacoes;

-- 5) listar o nome dos pilotos que voam de 737 ou de 777, junto com o respectivo aviao
select distinct p.nomep, e.aviao
from pilotos p
join escalacoes e on p.codp = e.codp
where e.aviao in ('737', '777');

--6) listar o nome dos pilotos que voam de 737 e de 777
select p.nomep from pilotos p
where p.codp in (
    select codp from escalacoes where aviao = '737')
and p.codp in (
    select codp from escalacoes where aviao = '777');

-- 7) listar o nome dos pilotos que voam de 737 e nao voam de 777
select p.nomep from pilotos p
where p.codp in (
    select codp from escalacoes where aviao = '737') and not p.codp in (select codp from escalacoes where aviao ='777'); 


-- 8) os aeroportos (código) onde a Gol opera
select distinct v.origem from voos v
join escalacoes e on v.codv = e.codv
join pilotos p on e.codp = p.codp
where p.companhia = 'gol' union select distinct v.dest from voos v
join escalacoes e on v.codv = e.codv
join pilotos p on e.codp = p.codp
where p.companhia = 'gol';


-- ===== ESCOLHA DE TABELAS  ========
-- 9) os aviões usados em vôos escalados que parte do aeroporto GRU
select distinct e.aviao from escalacoes e
join voos v on e.codv = v.codv where v.origem = 'gru';

-- 10) o código dos pilotos em em vôos escalados que parte do aeroporto GRU
select distinct e.codp from escalacoes e 
join voos v on e.codv = v.codv where v.origem = 'gru' and e.codp is not null;

-- 11) o nome dos pilotos da Gol que vôam a partir do/para o aeroporto GRU
select distinct p.nomep from pilotos p
join escalacoes e on p.codp = e.codp
join voos v on e.codv = v.codv
where p.companhia = 'gol' and ('gru' in (v.origem, v.dest));

-- ========== CONSULTAS AVANÇADAS ============
-- inserir mais instâncias
insert into aeroportos values ('stu','int de stutgart','stutgart','AL');
insert into aeroportos values ('mun','int de munique','munique','AL');
insert into voos values ('LF200','gru','stu','8');
insert into voos values ('LF210','stu','mun','17');
insert into escalacoes values('LF200','01/06','p31','777');
insert into escalacoes values('LF210','01/07','p31','777');

-- Faça consultas abaixo. Sempre elimine os duplicados.
select * from escalacoes;

--9) o código dos vôos nacionais (isto é no Brasil)
select distinct v.codv from voos v
join aeroportos a1 on v.origem = a1.coda
join aeroportos a2 on v.dest = a2.coda
where a1.pais = 'BR' and a2.pais = 'BR';

--10) O código de todos os vôos que foram escalados para  o primeiro dia de um mes qualquer, junto com a respectiva companhia
select distinct e.codv, p.companhia from escalacoes e
join pilotos p on e.codp = p.codp
where e.data like '01/%';

--11)  o código dos vôos, o nome do piloto escalado, e a respectiva companhia, para todos vôos escalados de 777. 
-- Inlcuir no resultado vôos nao escalados.
select v.codv, p.nomep, p.companhia from voos v
left join escalacoes e on v.codv = e.codv and e.aviao = '777'
left join pilotos p on e.codp = p.codp
where e.aviao = '777' or e.codv is null;

--12) o nome dos aeroportos de onde pilotos da gol voando de 737 partem (origem)
select distinct a.nomea from aeroportos a
join voos v on a.coda = v.origem
join escalacoes e on v.codv = e.codv
join pilotos p on e.codp = p.codp
where p.companhia = 'gol' and e.aviao = '737';

--13) O nome dos pilotos estrangeiros que voam para o próprio pais
select distinct p.nomep from pilotos p
join escalacoes e on p.codp = e.codp
join voos v on e.codv = v.codv
join aeroportos a on v.dest = a.coda
where p.pais = a.pais and p.pais != 'BR';

--14) o nome dos aeronaves usadas no aeroporto de guarulhos, e que nao sao usadas no aeroporto de congonhas
select distinct e.aviao from escalacoes e
join voos v on e.codv = v.codv
where v.origem = 'gru' or v.dest = 'gru'
and e.aviao not in (
    select distinct e2.aviao
    from escalacoes e2
    join voos v2 on e2.codv = v2.codv
    where v2.origem = 'cgh' or v2.dest = 'cgh');

