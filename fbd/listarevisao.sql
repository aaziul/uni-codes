drop table if exists atuacoes;
drop table  if exists filmes;
drop table if exists pessoas;

create table pessoas
(codp int not null primary key,
nomep varchar(50) not null,
nacionalidade char(2) not null);

create table filmes
(codf int not null primary key,
nomef varchar(50),
ano int not null,
diretor int,
premios int not null,
foreign key(diretor) references pessoas);

create table atuacoes
(codf int not null,
codp int not null,
papel varchar(50),
cache int not null,
primary key(codf,codp),
foreign key (codf) references filmes,
foreign key (codp) references pessoas);

insert into pessoas values (1, 'rodrigo santoro', 'br');
insert into pessoas values (2, 'cassia kiss', 'br');
insert into pessoas values (3, 'emma thompson', 'gb');
insert into pessoas values (4, 'kenneth branagh', 'gb');
insert into pessoas values (5, 'keanu reeves', 'us');
insert into pessoas values (6, 'laurence fishburne', 'us');
insert into pessoas values (8, 'richard curtis', 'nz');
insert into pessoas values (7, 'laís bodanzky', 'br');
insert into pessoas values (9, 'lilly wachowski', 'us');

insert into filmes values (1, 'bicho de 7 cabecas', 2000, 7, 5);
insert into filmes values (2, 'simplesmente amor', 2003, 8, 0);
insert into filmes values (3, 'muito barulho por nada', 1993, 4, 0);
insert into filmes values (4, 'matrix', 1999, 9, 3);
insert into filmes values (5, 'matrix reloaded', 2003, 9, 0);

insert into atuacoes values (1, 1, 'neto', 20000);
insert into atuacoes values (1, 2, 'meire', 25000);
insert into atuacoes values (2, 1, 'karl', 10000);
insert into atuacoes values (2, 3, 'karen', 50000);
insert into atuacoes values (3, 3, 'beatrice', 30000);
insert into atuacoes values (3, 4, 'benedick', 30000);
insert into atuacoes values (3, 5, 'don john', 10000);
insert into atuacoes values (4, 5, 'neo', 50000);
insert into atuacoes values (4, 6, 'morpheus', 50000);
insert into atuacoes values (5, 5, 'neo', 100000);
insert into atuacoes values (5, 6, 'morpheus', 10000);

select * from pessoas;
select * from filmes;
select * from atuacoes;

-- 1) O nome dos atores brasileiros que participaram em filmes premiados;
select distinct p.nomep from pessoas p
join atuacoes a on p.codp = a.codp
join filmes f on a.codf = f.codf
where p.nacionalidade = 'br' and f.premios > 0;

-- 2) o nome dos filmes onde atuam atores brasileiros;
select distinct f.nomef from filmes f
join atuacoes a on f.codf = a.codf
join pessoas p on a.codp = p.codp
where p.nacionalidade = 'br';

-- 3) o nome dos filmes onde não atuam atores brasileiros
select f.nomef from filmes f
where not exists (
    select 1 from atuacoes a
    join pessoas p on a.codp = p.codp
    where a.codf = f.codf and p.nacionalidade = 'br'
);

-- 4) o nome dos filmes com mais de 2 atores;
select f.nomef from filmes f
join atuacoes a on f.codf = a.codf
group by f.codf, f.nomef
having count (distinct codp) > 2;

-- 5) para cada filme, seu nome, o numero de artistas, e o total pago em caches
select f.nomef, count (distinct a.codp) as numArtistas, sum(a.cache) as totalCache from filmes f
left join atuacoes a on f.codf = a.codf
group by f.codf, f.nomef
order by f.nomef;

-- 6) para cada diretor, seu nome, o número de filmes que dirigiu, e o número de artistas com os quais trabalhou (isto é, dirigiu)
select p.nomep as nomeDiretor, count(distinct f.codf) as numFilmesDirigidos, count(distinct a.codp) as numArtistasTrabalhados from pessoas p
left join filmes f on p.codp = f.diretor
left join atuacoes a on f.codf = a.codf
group by p.codp, p.nomep
order by p.nomep;

-- 7) o nome dos filmes onde todos atores tem a mesma nacionalidade
select f.nomef from filmes f
where not exists (
    select 1 from atuacoes a1
    join pessoas p1 on a1.codp = p1.codp
    where a1.codf = f.codf
    group by a1.codf
    having count(distinct p1.nacionalidade) > 1
)
and exists (select 1 from atuacoes a2 where a2.codf = f.codf); 

-- 8) o nome dos filmes da franquia Matrix
select nomef from filmes
where nomef like 'Matrix%';

-- 9) o nome dos filmes quem têm os personagens neo e morpheus
select f.nomef from filmes f
join atuacoes a_neo on f.codf = a_neo.codf
join atuacoes a_morpheus on f.codf = a_morpheus.codf
where a_neo.papel = 'neo' and a_morpheus.papel = 'morpheus';

-- 10) o nome dos filmes onde o diretor também atua
select distinct f.nomef from filmes f
join atuacoes a on f.codf = a.codf
where f.diretor = a.codp;

-- 11) o total pago em caches em filmes onde atuou keanu reeves, junto do respectivo filme
select f.nomef, sum(a.cache) as totalCacheKeanuReeves from filmes f 
join atuacoes a on f.codf = a.codf
join pessoas p on a.codp = p.codp
where p.nomep = 'keanu reeves'
group by f.codf, f.nomef;

-- 12) o nome das pessoas que contracenaram com a emma thompson, junto com o nome do filme
select distinct p.nomep as nomeAtor, f.nomef as nomeFilme from pessoas p
join atuacoes a on p.codp = a.codp
join filmes f on a.codf = f.codf
where a.codf in (select A_et.codf from atuacoes A_et join pessoas P_et on A_et.codp = P_et.codp where P_et.nomep = 'emma thompson') and p.nomep != 'emma thompson'
order by f.nomef, p.nomep;


-- 13) o nome dos atores que desempenharam o mesmo personagem (papel) mais de uma vez (por exemplo, em uma franquia ou remake)
select p.nomep from pessoas
join atuacoes a on p.codp = a.codp
group by p.codp, p.nomep, a.papel
having count(a.papel) > 1;

-- 14) o nome dos atores que sempre foram dirigidos por diretores diferentes
select P_ator.nomep from pessoas P_ator
where P_ator.codp in (select a.codp from atuacoes a) 
group by P_ator.codp, P_ator.nomep
having count(distinct f.diretor) = count(distinct a.codf);

-- 15) o nome dos atores que participaram em todos os filmes nos quais laurence fishburne atuou
select p.nomep from pessoas p
where p.codp in (select a.codp from atuacoes a) and p.nomep != 'laurence fishburne'
group by p.codp, p.nomep
having count(distinct a.codf) = (select count(distinct A_lf.codf) from atuacoes A_lf
                                join pessoas P_lf on A_lf.codp = P_lf.codp
                                where P_lf.nomep = 'laurence fishburne')
and sum(case when a.codf in (select A_lf2.codf from atuacoes A_lf2 join pessoas P_lf2 on A_lf2.codp = P_lf2.codp where P_lf2.nomep = 'laurence fishburne') then 1 else 0 end) = (select count(distinct A_lf3.codf) from atuacoes A_lf3 join pessoas P_lf3 on A_lf3.codp = P_lf3.codp where P_lf3.nomep = 'laurence fishburne');

-- 16) o nome dos atores que não participaram (nem como ator, nem diretor) em nenhum dos filmes nos quais keanu reeves atuou
select p.nomep from pessoas p
where p.codp not in (
    select distinct a.codp from atuacoes a join pessoas P_kr on a.codp = P_kr.codp where P_kr.nomep = 'keanu reeves' 
)
and p.codp not in (
    select distinct f.diretor from filmes f join atuacoes A_kr on f.codf = A_kr.codf join pessoas P_kr on A_kr.codp = P_kr.codp where P_kr.nomep = 'keanu reeves' 
)
and p.codp not in (
    select distinct P2.codp from pessoas P2 where P2.nomep = 'keanu reeves' 
);
