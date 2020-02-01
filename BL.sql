select * from emp, dept where emp.DEPTNO=dept.DEPTNO;
select * from emp inner join  dept on emp.DEPTNO=dept.DEPTNO;
select * from emp alias, emp autres where alias.ENAME='SCOTT' and alias.sal=autres.sal AND autres.ENAME <> 'SCOTT';

select * from emp where sal > (select avg(sal)from emp)

select ename , count(*)*100/(select count(*)from emp) as '% 'from emp group by ename;

select ename, sum(sal+comm) as 'plm'
from emp
group by ename having sum(sal+comm) <= 3000
order by 2 desc; 

select ename from emp union select dname from dept;

select ename from emp minus select dname from dept;

update emp set comm=0 where comm is null

delete from EMP INNER join PROJET ON EMP.nomP=PROJET.nomP where nomP=(select nomP from emp where nomP like '%101%');