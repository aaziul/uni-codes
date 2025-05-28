-- TAREFA 0 - rodar o SGBD POSTGRES
-- SEGUIR AS INSTRUÇÕES NO LINK ABAIXO CONFORME O SISTEMA OPERACIONAL (WINDOWS OU LINUX)

--TAREFA 1 - CRIAR A BASE DE DADO E SE FAMILIARIZAR COM O AMBIENTE POSTGRES (DICIONARIO DE DADOS, FERRAMENTAS)

-- TAREFA 2 (DDL) - COMANDOS PARA CRIAR AS TABELAS. APOS EXECUTAR CADA UM DELES, VEJA OS REFLEXOS NO NAVEGADOR. 
-- INSPECIONE AS TABELAS E OS ATRIBUTOS.
create table DISCIPLINAS
(codd char(2) not null primary key,
nomed varchar(20) not null unique, 
creditos smallint not null);

create table SALAS
(numero smallint not null primary key,
predio varchar(10) not null,
capacidade smallint not null);

create table TURMAS
(codd char(2) not null,
turma char(1) not null,
local smallint,
primary key (codd, turma),
foreign key(codd) references disciplinas,
foreign key(local) references salas);

select * from turmas;
select * from salas;
select * from disciplinas;

-- TAREFA 3 (DML) - CRIAÇAO DE INSTANCIAS COM E SEM ERRO
--inserção de instâncias em SALAS sem erro
insert into salas values (10, 'P1', 40);
insert into salas values (20, 'P2', 10);
insert into salas values (30, 'P3', 10);

-- ver as  salas criadas
select * from salas;

-- inserçao de instancias em SALAS com erros 
-- Q1: qual erro aconteceu para cada comando abaixo?

-- ERROR:  Key (numero)=(10) already exists.duplicate key value violates unique constraint "salas_pkey" 
insert into salas values (10, 'P1', 40);

-- ERROR:  value too long for type character varying(10) 
insert into salas values (40,'PREDIO DOM PEDRO DE ALCANTARA BRAGANCA', 100);

-- ERROR:  Failing row contains (50, P3, null).null value in column "capacidade" of relation "salas" violates not-null constraint 
insert into salas values (50,'P3');

-- confira como está a tabela salas
select * from salas;

-- inserção de instâncias em DISCIPLINAS
-- Q2: Diga quais comandos executaram com erro, com o respectivo erro.
-- criar instancias de disciplina e verificar se ocorrem erros
insert into disciplinas values ('d1', 'matematica', 4);
insert into disciplinas values ('d2', 'portugues', 6);

-- ERROR:  Key (nomed)=(matematica) already exists.duplicate key value violates unique constraint "disciplinas_nomed_key" 
insert into disciplinas values ('d3', 'matematica', 4);

select * from disciplinas;

-- criar instâncias de TURMAS e verificar se ocorrem erros
-- Q3: Diga quais comandos executaram com erro, com o respectivo erro.
insert into turmas values ('d1', 'A', 10);
insert into turmas values ('d1', 'B', 20);
insert into turmas values ('d2', 'A', null);

-- ERROR:  Key (local)=(40) is not present in table "salas".insert or update on table "turmas" violates foreign key constraint "turmas_local_fkey" 
insert into turmas values ('d2', 'B', 40);

-- ERROR:  Key (codd, turma)=(d2, A) already exists.duplicate key value violates unique constraint "turmas_pkey" 
insert into turmas values ('d2', 'A', 20);

-- ERROR:  Key (codd)=(d3) is not present in table "disciplinas".insert or update on table "turmas" violates foreign key constraint "turmas_codd_fkey" 
insert into turmas values ('d3', 'A', null);

select * from turmas;

-- TAREFA 4 (DDL) - MODIFICAR TABELAS COM ALTER TABLE

-- vamos remover a tabela TURMAS e criar uma tabela TURMAS2 sem restricoes de integridade. 
-- vamos usar o comando alter table para criar chave primária e chaves estrangeiras para DISCIPLINAS e SALAS. Além disso, vamos restringir que o valor de turma seja A, B ou U.
drop table turmas;
create table TURMAS2
(codd char(2) not null,
turma char(1) not null,
local smallint);

-- adicionar chave primária
alter table TURMAS2
add constraint t2PK primary key (codd, turma);

-- adicionar chave estrangeiras
alter table TURMAS2
add constraint t2salaFK foreign key(local) references salas;

alter table TURMAS2
add foreign key(codd) references disciplinas;

-- vamos colocar uma restrição de integridade em usando a cláusula CHECK 
-- para controlar que o atributo turma tenha apenas valores A, B ou U
alter table TURMAS2
add check(turma in ('A','B','U'));

-- vamos instanciar TURMAS2 e verificar se as restrições estão sendo mantidas. 
-- Q4 quais os comandos abaixo resultam em erro, e por quê?
insert into disciplinas values ('d3', 'logica', 4);
insert into turmas2 values ('d1', 'A', 10);
insert into turmas2 values ('d2', 'A', null);
insert into turmas2 values ('d3', 'B', 20);

-- ERROR:  Key (local)=(40) is not present in table "salas".insert or update on table "turmas2" violates foreign key constraint "t2salafk" 
insert into turmas2 values ('d2', 'B', 40);

-- ERROR:  Key (codd, turma)=(d2, A) already exists.duplicate key value violates unique constraint "t2pk" 
insert into turmas2 values ('d2', 'A', 20);

-- ERROR:  Key (codd)=(d4) is not present in table "disciplinas".insert or update on table "turmas2" violates foreign key constraint "turmas2_codd_fkey" 
insert into turmas2 values ('d4', 'A', null);

-- ERROR:  Failing row contains (d1, C, 10).new row for relation "turmas2" violates check constraint "turmas2_turma_check" 
insert into turmas2 values ('d1', 'C', 10);

select * from turmas2;

--- vamos restringir mais ainda TURMAS2: o atributo turma pode ter apenas os valores A ou U, e o atributo local não pode ser nulo.
-- restrição de integridade -  turma apenas com valores A e U
alter table TURMAS2
add check(turma in ('A','U'));
-- ERROR:  check constraint "turmas2_turma_check1" of relation "turmas2" is violated by some row 

-- restrição de integridade -  atributo local deve ser obrigatório
alter table TURMAS2
add check(local is not null);
-- ERROR:  check constraint "turmas2_local_check" of relation "turmas2" is violated by some row 

--Q5: Alguma dessas alterações foi possível? Explique.
-- Não foi possivel. O mesmo erro foi apresentado em ambos os comandos. 

-- TAREFA 5 (DML) - INTEGRIDADE REFERENCIAL - POLÍTICA RESTRICTED

-- veja quais salas e disciplinas existem
select * from salas;
select * from disciplinas;

-- trocar o numero das salas 10 e 30;
UPDATE salas SET numero = 300 WHERE numero = 30;

--ERROR:  Key (numero)=(10) is still referenced from table "turmas2".update or delete on table "salas" violates foreign key constraint "t2salafk" on table "turmas2"
UPDATE salas SET numero = 100 WHERE numero = 10;

select * from salas;

-- remover as salas 10 e 300
DELETE FROM salas WHERE numero = 300;

-- ERROR:  Key (numero)=(10) is still referenced from table "turmas2".update or delete on table "salas" violates foreign key constraint "t2salafk" on table "turmas2" 
DELETE FROM salas WHERE numero = 10;

select * from salas;

-- Q6: Descreva o erro que ocorre e o porquê.
-- qual a diferença entre trocar o número da sala 30 e da 10? 
-- qual a diferença entre remover a sala 300 e a sala 10?
-- Foi possivel atualizar/deletar pois numero da sala 30 nao esta sendo utilizado como referencia em outra tabela, ja a sala de numero 10 esta sendo utilizada entao nao é possivel atualizar/deletar a sala 10.
