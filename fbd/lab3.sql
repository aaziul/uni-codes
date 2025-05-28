-- CRIE UMA BASE DE DADOS (EX: LAB1DML)
-- ABRA UMA QUERY TOOL
-- tenha sua base de dados selecionada, e com o botao direito abra o menu selecionando query tool

 -- CRIAR TABELA PILOTOS
 -- supoe-se que a nacionalidade dos pilotos é a mesma da companhia ara a qual trabalham

Create table pilotos
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
insert into pilotos values ('p13','pedro', 2000, 100, 5,'BR','gol');
insert into pilotos values ('p12','paulo', 3000, 200, 3,'BR','gol');
insert into pilotos values ('p21','antonio', 1500, 300, 7,'BR','tam');
insert into pilotos values ('p22','carlos', 5000, 200, 10,'BR','tam');
insert into pilotos values ('p31','hanz', 5000, 1000, 6,'AL','lufthansa');
insert into pilotos values ('p41','roel', 5000, 2000, 5,'NL','klm');

-- PRATICAR CLAUSULA SELECT/ORDER BY
-- 1) Listar todos os dados da tabela pilotos
select * from pilotos;

-- 2) Listar o nome das companhias aéreas. ordenar os resultados alfabeticamente. 
-- Faça uma versao sem eliminacao de duplicados, e outra com eliminaçao. 
-- sem eliminação de duplicados, organizados alfabeticamente 
select COMPANHIA from pilotos
order by COMPANHIA;

-- com eliminação de duplicados, organizados alfabeticamente
select distinct COMPANHIA from pilotos
order by COMPANHIA;

-- 3) Listar o nome dos pilotos e da companhia para a qual trabalham. Ordenar os resultados  alfabeticamente
-- por companhia, seguido de nome do piloto
select NOMEP, COMPANHIA from pilotos
order by COMPANHIA, NOMEP;


-- 4) Listar o nome dos pilotos e os seus vencimentos (salario + gratificacoes). Dar um nome vencimentos a essa soma
select NOMEP, SALARIO+GRATIFICACOES as VENCIMENTOS from pilotos
order by NOMEP, VENCIMENTOS;

-- PRATICAR CLAUSULA WHERE
-- 5) Selecionar o nome dos pilotos brasileiros. Ordenar os resultados em ordem alfabética.
select NOMEP from pilotos 
where PAIS='BR';

-- 6) Selecionar o nome das companhias e seu pais, para companhias que pagam menos que 3000 a seus pilotos. Elimine duplicados do resultado.
select distinct COMPANHIA, PAIS from pilotos
where SALARIO < 3000;

-- CRIAR TABELAS ESCALAÇÕES (DE PILOTOS EM VOOS)
Create table escalacoes
(CODV	char(5) not null,	
DATA	char(5)	not null,
CODP	char(3),
AVIAO	varchar(10) not null,
primary key(codv, data),
foreign key (codp) references pilotos);

-- inserir instancias
insert into escalacoes values('GL230','01/05','p11','737'); 
insert into escalacoes values('GL230','01/06','p11','737');
insert into escalacoes values('TM100','01/05','p21','777');
insert into escalacoes values('LF200','01/05','p31','A320');
insert into escalacoes values('GL330','01/06','p12','737');
insert into escalacoes values('GL330','01/07','p12','777');
insert into escalacoes values('GL530','01/05','p12','777');
insert into escalacoes values('GL530','01/07',NULL,'777');

-- PRATICAR CLAUSULA WHERE
-- 7) listar o código dos vôos sem piloto
select CODV from escalacoes
where CODP IS NULL; 

--8) Todos os vôos que iniciam com código GL
select CODV from escalacoes 
where CODV like 'GL%';

-- PRATICAR CLAUSULA FROM (com vários tipos de join)
-- 9 ) LIstar o nome dos pilotos, o voo para o qual estão escalados, e o respectivo aviao. Ordenar por aviao.
-- Fazer esta consulta usando
-- A) junçao com CLÁUSULA ON
select NOMEP, CODV, AVIAO from pilotos left join escalacoes on pilotos.CODP=escalacoes.CODP
order by AVIAO;

-- B) juncao com CLÁUSULA USING
select NOMEP, CODV, AVIAO from pilotos left join escalacoes using (CODP)
order by AVIAO;

-- C) junçao JOIN natural
select NOMEP, CODV, AVIAO from pilotos natural left join escalacoes 
order by AVIAO;

-- 10 ) Considerando pilotos nao brasileiros, listar nome do piloto e código do vôo nos foram escalados.
-- A) junçao com CLÁUSULA ON
select NOMEP, CODV from pilotos left join escalacoes on pilotos.CODP=escalacoes.CODP
where pilotos.PAIS!='BR';

-- B) juncao com CLÁUSULA USING
select NOMEP, CODV from pilotos left join escalacoes using (CODP)
where pilotos.PAIS!='BR';

-- C) junçao JOIN natural
select NOMEP, CODV from pilotos natural left join escalacoes 
where pilotos.PAIS!='BR';

-- 11) Listar os pilotos (nome), código de vôo e as respectivas aeronaves para as quais são escaladas. Eliminar os duplicados, e ordenar por piloto/voo.
-- Fazer a consulta nas seguintes versoes
-- a) somente os pilotos escalados vão para o resultado 
select distinct NOMEP,CODV,AVIAO from escalacoes natural join pilotos order by nomep,codv;

-- b) todos os pilotos, escalados ou não, vao para o resultado 
select distinct NOMEP,CODV,AVIAO from escalacoes right join pilotos order by nomep,codv;

-- c) todos os vôos vão para o resultado, que hajam pilotos escalados ou nao 
select distinct NOMEP,CODV,AVIAO from escalacoes left join pilotos order by nomep,codv;

-- d) todos os vôos e todos os pilotos vão para o resultado, mesmo pilotos não escalados e escalacoes sem piloto
select distinct NOMEP,CODV,AVIAO from escalacoes full join pilotos order by nomep,codv;


