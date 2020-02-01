ALTER TABLE CONTROLER_2 ADD CONSTRAINT PK_CTRL PRIMARY KEY (DATECTRL,IDMATIERE,IDETUDIANT)

SELECT e.ename, e.deptno, e.sal 
FROM EMP e
INNER JOIN EMP m ON m.ename = 'JONES' AND m.job = e.job AND e.ENAME <> 'JONES'

SELECT JOB,
AVG(SAL) as SAL_MOYEN
FROM EMP 
GROUP BY JOB HAVING AVG(SAL) <> any (SELECT
max(SAL)
FROM EMP 
GROUP BY JOB)

SELECT e.ename, e.deptno, e.sal 
FROM EMP e
INNER JOIN EMP m ON m.ename = 'JONES' AND m.job = e.job AND e.ENAME <> 'JONES'


SELECT JOB, MIN(e) as 
FROM (
SELECT e.JOB,
	AVG(e.SAL) as e
	FROM EMP e 
	INNER JOIN EMP m 
	ON m.job = e.job
	group by e.JOB
)
where min
ORDER BY job

SELECT TOP 1 JOB,
AVG(SAL) as 'M'
FROM EMP
group by JOB
order by M asc

SELECT JOB,
min(SAL) 
FROM emp 
GROUP BY JOB





