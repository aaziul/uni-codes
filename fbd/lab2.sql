-- comandos uteis -- remocao das tabelas
--drop table if exists turmas;
--drop table if exists turmas2;
--drop table if exists disciplinas;
--drop table if exists salas;

-- Tarefa 2
-- criacao das tabelas
create table disciplinas
(codd char(2) not null primary key,
nomed varchar(20) not null unique, 
creditos smallint not null);

create table salas
(numero smallint not null primary key,
predio varchar(10) not null,
capacidade smallint not null);

create table turmas
(codd char(2) not null,
turma char(1) not null,
local smallint,
primary key (codd, turma),
foreign key(codd) references disciplinas,
foreign key(local) references salas);

-- Tarefa 3

--criar instâncias de salas
insert into salas values (10, 'P1', 40);
insert into salas values (20, 'P2', 10);
insert into salas values (30, 'P3', 10);
select * from salas;

--criar instâncias de disciplinas
insert into disciplinas values ('d1', 'matematica', 4);
insert into disciplinas values ('d2', 'portugues', 6);
insert into disciplinas values ('d3', 'geografia', 4);
select * from disciplinas;

-- criar instâncias de turmas
insert into turmas values ('d1', 'A', 10);
insert into turmas values ('d1', 'B', 20);
insert into turmas values ('d2', 'A', null);
insert into turmas values ('d2', 'B', 20);
insert into turmas values ('d3', 'A', null);
select * from turmas;

-- Tarefa 4 - INTEGRIDADE REFERENCIAL - POLÍTICA RESTRICTED

-- trocar o numero das salas 10 e 30;
UPDATE salas SET numero = 300 WHERE numero = 30;
UPDATE salas SET numero = 100 WHERE numero = 10; -- não é possivel fazer a alteração pois a sala 10 esta sendo referenciada em uma turma 
select * from salas;
-- remover as salas 10 e 300
DELETE FROM salas WHERE numero = 300;
DELETE FROM salas WHERE numero = 10; -- não é possivel pois esta sendo referenciado na tabela de turmas 
select * from salas;

-- Q1: Descreva o erro que ocorre e o porquê.
-- - qual a diferença entre trocar o número da sala 30 e da 10?
-- - qual a diferença entre remover a sala 300 e a sala 10?
-- O número da sala 10 está sendo referenciado na tabela de turmas, então nao é possível fazer uma alteração ou deleção, ja a sala 30 nao esta sendo utilizado em ooutra tabela, logo pode ser deletada e alterada.

-- Tarefa 5 - Políticas compensatórias

drop table turmas; 
-- COMPLETE O COMANDO ABAIXO COM AS POLITICAS COMPENSATORIAS
create table turmas2
(codd char(2) not null,
turma char(1) not null,
local smallint,
primary key (codd, turma),
foreign key(codd) references disciplinas
 -- completar,
on delete cascade,
 ----
foreign key(local) references salas 
-- completar
on delete set null
);

-- Q2: Como ficou o comando create table TURMAS2 para contemplar as políticas acima?
--create table turmas2
--(codd char(2) not null,
--turma char(1) not null,
--local smallint,
--primary key (codd, turma),
--foreign key(codd) references disciplinas
--on delete cascade,
--foreign key(local) references salas 
--on delete set null
--);

-- inserir instancias
insert into turmas2 values ('d1', 'A', 10);
insert into turmas2 values ('d1', 'B', 20);
insert into turmas2 values ('d2', 'A', null);
insert into turmas2 values ('d2', 'B', 20);
insert into turmas2 values ('d3', 'A', null);

-- Q3: Descreva o que acontece em cada uma das situações abaixo, explicando porque o comando ocorre com sucesso ou com erro:

-- a) trocar o numero da sala 10 para 100;
UPDATE salas SET numero = 100 WHERE numero = 10; 
-- o valor esta sendo referenciado na tabela de turmas2
select * from salas;
select * from turmas2;

-- b) remover a sala 20;
DELETE FROM salas WHERE numero = 20; -- deletou com sucesso
select * from salas;
select * from turmas2;

-- c) remover a disciplina d3;
DELETE FROM disciplinas WHERE codd = 'd3'; -- deletou com sucesso
select * from disciplinas;
select * from turmas2;

-- d) trocar o código da discipina d1 para d8;
UPDATE disciplinas SET codd = 'd8' WHERE codd = 'd1'; -- nao é possivel atualizar pois esta sendo referenciada na tabela turmas2
select * from disciplinas;
select * from turmas2;

-- Tarefa 6 - criação de nova tabela Professores

create table professores
(codprof integer not null primary key,
nomeprof char(20) not null,
disc char(2) not null,
foreign key (disc) references disciplinas);

insert into disciplinas values ('d3', 'geografia', 4);
insert into turmas2 values ('d3', 'A', null);
insert into professores values (1, 'joao', 'd3');

-- Q4: Na tarefa 5 excluímos uma disciplina de DISCIPLINAS, observando seus efeitos em TURMAS2. O que acontece se tentarmos excluir a disciplina de código ‘d3’? Relate se o comando ocorre com sucesso ou erro, explicando.

-- remover a disciplina d3;
DELETE FROM disciplinas WHERE codd = 'd3';
-- a disciplina de codigo d3 esta sedo referenciada na tabela de professores entao nao pode ser removida

-- Tarefa 7 - definição de chaves estrangeiras para o esquema AEROPORTO. Complete os esquemas com as chaves estrangeiras necessárias.

-- tabela de aeroportos
CREATE TABLE AEROPORTOS 
(coda CHAR(3) NOT NULL,
nome VARCHAR(60) NOT NULL, 
cidade VARCHAR(30) NOT NULL, 
pais VARCHAR NOT NULL, 
primary key(coda));

insert into aeroportos values ('a1', 'aeroporto1', 'porto alegre', 'BR');
insert into aeroportos values ('a2', 'aeroporto2', 'sao paulo', 'BR');
insert into aeroportos values ('a3', 'aeroporto3', 'rio de janeiro', 'BR');

-- tabela de voos - representa um voo regular disponível
-- um voo sai de um aeroporto origem, e chega em um aeroporto destino
-- complete a definição da tabela VOOS para que reflita a relaçao com aeroportos

CREATE TABLE VOOS  
(codv CHAR(5) NOT NULL, 
origem CHAR(3) NOT NULL, 
destino CHAR(3) NOT NULL, 
horapartida time, 
primary key(codv),
foreign key (origem) references AEROPORTOS,
foreign key (destino) references AEROPORTOS);

-- deve executar sem erro
insert into voos values ('v1', 'a1', 'a2', '9:30');
insert into voos values ('v2', 'a2', 'a1', '11:30');
insert into voos values ('v3', 'a1', 'a3', '16:00');

-- deve executar com erro
insert into voos values ('v4', 'a1', 'a4', '9:30'); -- aeroporto 'a4' nao existe

-- Q5: Modifique o(s) esquemas da(s) tabela(s) com a chave estrangeira apropriada. Como ficam as definições das tabelas que foram modificadas?

-- tabela de pilotos
CREATE TABLE PILOTOS
(codp CHAR(4) NOT NULL,
nomep VARCHAR(60),
companhia varchar(50),
primary key(codp));

insert into pilotos values ('p1', 'maria', 'gol');
insert into pilotos values ('p2', 'joana', 'gol'); 
insert into pilotos values ('p3', 'pedro', 'tam');

-- tabela de escalacoes --
-- escalacoes de voos regulares em alguma data, com o piloto e aviao definido na escalaçao
-- complete a definição da tabela ESCALACOES para que reflita a relaçao com voos e pilotos

CREATE TABLE ESCALACOES 
(codv CHAR(5) NOT NULL, 
data DATE NOT NULL, 
aviao VARCHAR(10),
codp CHAR(4), 
primary key(codv, data),
foreign key (codv) references voos);


-- deve executar sem erro
insert into escalacoes values ('v1', '1-1-2025', '737', 'p1');
insert into escalacoes values ('v1', '2-2-2025', '777', 'p2');
insert into escalacoes values ('v2', '1-1-2025', '777', 'p1');
insert into escalacoes values ('v3', '3-3-2025', '737', 'p3');

-- deve executar com erro
insert into escalacoes values ('v4', '3-3-2025', '737', 'p3'); -- v4 n existe na tabela de voos
insert into escalacoes values ('v3', '3-3-2025', '737', 'p4'); -- erro, valor duplicado

-- tarefa 7

-- Q6: Modifique o(s) esquemas da(s) tabela(s) com a chave estrangeira apropriada. Como ficam as definições das tabelas que foram modificadas?

-- vamos refazer as tabelas para poder atender as seguintes políticas do UdD
drop table escalacoes;
drop table voos;
drop table pilotos;
drop table aeroportos;

-- Regras de Negócio: 
-- A companhia se reserva o direito de suprimir um vôo, sendo canceladas (i.e. removidas) assim todas as escalas para ele previstas. 
-- Se um piloto escalado para um vôo for demitido (i.e. removido), a escala daquele vôo fica em aberto (i.e. a escala não é removida, e fica aguardando a designação de um novo piloto). 
-- Pilotos e vôos não podem ter sua identificação alterada (codp e codv, respectivamente).
-- Aeroportos podem ter seu código alterado, mas todos os vôos correspondentes devem ser atualizados de forma correspondente.

-- Q7: Como ficam as definições das tabelas ?
CREATE TABLE AEROPORTOS 
(coda CHAR(3) NOT NULL,
nome VARCHAR(60) NOT NULL, 
cidade VARCHAR(30) NOT NULL, 
pais VARCHAR NOT NULL, 
primary key(coda),
);

CREATE TABLE VOOS  
(codv CHAR(5) NOT NULL, 
origem CHAR(3) NOT NULL, 
destino CHAR(3) NOT NULL, 
horapartida time, 
primary key(codv),
foreign key (origem) references AEROPORTOS
on update cascade,
foreign key (destino) references AEROPORTOS
on update cascade);

CREATE TABLE PILOTOS
(codp CHAR(4) NOT NULL,
nomep VARCHAR(60),
companhia varchar(50),
primary key(codp));

CREATE TABLE ESCALACOES 
(codv CHAR(5) NOT NULL, 
data DATE NOT NULL, 
aviao VARCHAR(10),
codp CHAR(4), 
primary key(codv, data),
foreign key (codv) references voos,
foreign key (codp) references pilotos
on delete set null
);

-- Teste seu esquema fazendo remoções e atualizações em todas as tabelas. 
-- Q8: Forneça um comando de atualização e de remoção por tabela que afetem as restrições de integridade referencial definidas.





