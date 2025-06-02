-- Luiza Souto, 00585260
-- Base de Dados

-- Medico(crm, nomem, especialidade, idadem) - Representa dados de médicos
-- Paciente(pront, nomep, idadep) -  Representa dados de pacientes
-- Consulta(pront, crm, data) pront references paciente, crm references medico -- Representa dados de consultas médicas

-- Crie a base dados Hospital, com suas tabelas e instâncias.

drop Table if exists  consulta;
drop Table if exists  paciente;
drop Table if exists  medico;

create table paciente
(pront	char(2) not null,
nomep 	varchar(20) not null,	
idadep 	smallint not null,
primary key(pront));

create table medico
(crm		char(2) not null,
nomem		varchar(20) not null,	
especialidade varchar(15) not null,
idadem 	smallint not null,	
primary key(crm));

create table consulta
(pront	char(2)	 not null,	
crm 	char(2)	 not null,	
data	char(5)	 not null,
primary key(pront,crm,data),
foreign key (pront) references paciente,
foreign key (crm) references medico);

insert into paciente values ('p1','joao',7);
insert into paciente values ('p2','pedro',10);
insert into paciente values ('p3','maria',14);
insert into paciente values ('p4','jose',30);
insert into paciente values ('p5','marta',60);
insert into paciente values ('p6','paulo',65);

insert into medico values ('m1','ricardo','oftalmologia', 29);
insert into medico values ('m2','romualdo','pediatria', 24);
insert into medico values ('m3','roberto','pediatria', 35);
insert into medico values ('m4','sheila','endocrinologia', 22);
insert into medico values ('m5', 'paula', 'oftalmologia', 60);
insert into medico values ('m6', 'tereza', 'geriatria', 34);
insert into medico values ('m7', 'carla', 'pediatria', 45);

insert into consulta values ('p1','m2','01/01');
insert into consulta values ('p1','m2','01/02');
insert into consulta values ('p1','m3','01/02');
insert into consulta values ('p2','m2','01/01');
insert into consulta values ('p2','m3','01/02');
insert into consulta values ('p2','m1','01/02');
insert into consulta values ('p5','m4','01/02');
insert into consulta values ('p3', 'm2', '01/01');
insert into consulta values ('p4', 'm4', '01/01');
insert into consulta values ('p4', 'm1', '01/01');
insert into consulta values ('p4', 'm3', '01/01');
insert into consulta values ('p1', 'm5', '01/01');
insert into consulta values ('p1', 'm5', '01/02');
insert into consulta values ('p6', 'm5', '01/02');
insert into consulta values ('p6', 'm6', '01/02');
insert into consulta values ('p6', 'm6', '03/03');
insert into consulta values ('p1', 'm7', '04/04');
insert into consulta values ('p2', 'm7', '05/05');

select * from paciente;
select * from medico;
select * from consulta;

-- Lab SQL 4 - Praticando subconsultas
-- Objetivos: Reconhecer situações que necessitam a resolução por subconsultas.

-- Questao 0  - RELEMBRANDO A CONSTRUCAO DE UMA CONSULTA USANDO SUBCONSULTAS (IN, EXISTS)
-- O nome dos médicos que atenderam pacientes no dia 01/02
-- a)	Resolver usando JOIN
select distinct m.nomem from medico m
join consulta c on m.crm = c.crm
where c.data = '01/02';

-- b)	Resolver usando subconsulta conectada com o predicado IN
select m.nomem from medico m 
where m.crm in (select c.crm from consulta c where c.data = '01/02');

-- c)	Resolver usando subconsulta conectada com o predicado EXISTS
select m.nomem from medico m 
where exists (select 1 from consulta c where c.crm = m.crm and c.data = '01/02');

-- NAS PROXIMAS QUESTÕES, CONCENTRE-SE NAS PARTES ONDE A SUBCONSULTA É NECESSARIA. PARA AS DEMAIS PARTES, USE JOIN LIVREMENTE.
-- Cada questao é comparativa, para que note a necessidade de uso deste construto para formular a consulta.
-- Questão 1

-- 1 Compare
-- a) Some 1 à idade dos pacientes que têm mais de 60 anos 
update paciente set idadep = idadep + 1 where idadep > 60;


-- b) Some 1 à idade dos pacientes que foram atendidos na data 03/03
update paciente 
set idadep = idadep + 1 
where pront in (select pront from consulta where data = '03/03');

-- 2 Compare
-- a) Remova as consultas que ocorreram na data 03/03
delete from consulta where data = '03/03';

-- b) Remova as consultas que foram atendidas por médicos geriatras
delete from consulta 
where crm in (select crm from medico where especialidade = 'geriatria');

-- 3. O nome dos médicos que 
-- a. atenderam crianças (criança <= 12 anos)
select distinct m.nomem
from medico m 
where m.crm in (select c.crm from consulta c 
                join paciente p on c.pront = p.pront 
                where p.idadep <= 12);
-- b. não atenderam crianças
select distinct m.nomem
from medico m
where m.crm not in (select c.crm from consulta c
                    join paciente p on c.pront = p.pront
                    where p.idadep <= 12);
-- c. só atenderam crianças
select distinct m.nomem
from medico m
where m.crm in (select c.crm from consulta c
                join paciente p on c.pront = p.pront
                where p.idadep <= 12)
and m.crm not in (select c.crm from consulta c
                    join paciente p on c.pront = p.pront
                    where p.idadep >= 18);
-- d. atenderam crianças e adultos (adulto >=18)
select distinct m.nomem
from medico m
where m.crm in (select c.crm from consulta c
                join paciente p on c.pront = p.pront
                where p.idadep <= 12)
and m.crm in (select c.crm from consulta c
                join paciente p on c.pront = p.pront
                where p.idadep >= 18);

-- 4. Compare
-- a. O nome dos pacientes que consultaram a endocrinologia
select distinct p.nomep
from paciente p
join consulta c on p.pront = c.pront
join medico m on c.crm = m.crm
where m.especialidade = 'endocrinologia';

-- b. O nome dos pacientes e das especialidades consultadas, para todos pacientes que foram
-- atendidos pelo menos uma vez por um endocrinologista
select distinct p.nomep, m.especialidade
from paciente p
join consulta c on p.pront = c.pront
join medico m on c.crm = m.crm
where m.crm in (select crm from medico where especialidade = 'endocrinologia');

-- 5. O nome dos pacientes que foram atendidos por
-- a) no mínimo 3 médicos distintos
select distinct p.nomep
from paciente p
join consulta c on p.pront = c.pront
group by p.nomep
having count(distinct c.crm) >= 3;

-- b) por médicos que atenderam pelo menos 3 pessoas distintas
select distinct p.nomep
from paciente p
join consulta c on p.pront = c.pront
where c.crm in (select crm from consulta group by crm having count(distinct pront) >= 3);

-- 6. O nome e idade dos médicos que são mais velhos que todos pacientes que atenderam
select distinct m.nomem, m.idadem
from medico m
where m.idadem > (select max(p.idadep) from paciente p
                    join consulta c on p.pront = c.pront
                    where c.crm = m.crm);

-- 7.
-- a) Para cada especialidade, a idade do paciente mais velho
select m.especialidade, max(p.idadep) as idade_mais_velho
from medico m
join consulta c on m.crm = c.crm
join paciente p on c.pront = p.pront
group by m.especialidade;

-- b) Para cada especialidade, a média da idade dos médicos
select m.especialidade, avg(m.idadem) as media_idade
from medico m
group by m.especialidade;

-- c) O nome das especialidades cuja idade média dos médicos é menor que a idade do paciente
-- mais velho que atenderam
select m.especialidade
from medico m
join consulta c on m.crm = c.crm
join paciente p on c.pront = p.pront
group by m.especialidade
having avg(m.idadem) < max(p.idadep);

-- 8. Compare
-- a. O nome dos médicos pediatras e o número de consultas que atendeu
select m.nomem, count(c.pront) as num_consultas
from medico m
join consulta c on m.crm = c.crm
where m.especialidade = 'pediatria'
group by m.nomem;

-- b. O nome dos médicos e número total de consultas que atenderam, para todo o médico
-- pediatra que atendeu pelo menos um paciente que consultou também outra especialidade
select m.nomem, count(c.pront) as num_consultas
from medico m
join consulta c on m.crm = c.crm
where m.especialidade = 'pediatria'
and c.pront in (select pront from consulta where crm != m.crm)
group by m.nomem;

-- 9. o nome dos médicos que atenderam pacientes mais velhos que a idade média dos pacientes
-- que consultaram pediatras
select distinct m.nomem
from medico m
join consulta c on m.crm = c.crm
join paciente p on c.pront = p.pront
where p.idadep > (select avg(p2.idadep) from paciente p2
                    join consulta c2 on p2.pront = c2.pront
                    where c2.crm in (select crm from medico where especialidade = 'pediatria'));