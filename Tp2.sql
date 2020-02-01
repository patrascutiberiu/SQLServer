CREATE TABLE AVION(
AV INT NOT NULL PRIMARY KEY IDENTITY(100,1),
AVMARQ VARCHAR(30) NOT NULL,
AVTYPE VARCHAR(30) NOT NULL,
CAP INT NOT NULL,
LOC CHAR(30) NOT NULL
);

INSERT INTO AVION (AVMARQ, AVTYPE, CAP, LOC)
VALUES
('AIRBUS','A320',300,'NICE'),
('BOEING','B707',250,'PARIS'),
('AIRBUS','A320',300,'TOULOUSE'),
('CARAVELLE','CARAVELLE',200,'TOULOUSE'),
('BOEING','B747',400,'PARIS'),
('AIRBUS','A320',300,'GRENOBLE'),
('ART','ART42',50,'PARIS'),
('BOEING','B727',300,'LYON'),
('BOEING','B727',300,'NANTES'),
('AIRBUS','A340',350,'BASTIA');

SELECT * FROM AVION

CREATE TABLE PILOTE(
PIL INT NOT NULL PRIMARY KEY IDENTITY(1,1),
PILNOM CHAR(30) NOT NULL,
ADR CHAR(30)
);

INSERT INTO PILOTE(PILNOM,ADR)
VALUES
('SERGE','NICE'),
('JEAN','PARIS'),
('CLAUDE','GRENOBLE'),
('ROBERT','NANTES'),
('SIMON','PARIS'),
('LUCIEN','TOULOUSE'),
('BERTNARD','LYON'),
('HERVE','BASTIA'),
('LUC','PARIS');

INSERT INTO PILOTE(PILNOM)
VALUES
('Tib');

SELECT * FROM PILOTE

CREATE TABLE VOL(
VOL VARCHAR(30) NOT NULL PRIMARY KEY,
AV INT NOT NULL,
PIL INT NOT NULL,
VD CHAR(30) NOT NULL,
VA CHAR(30) NOT NULL,
HD INT NOT NULL,
HA INT NOT NULL,
CONSTRAINT FK_AV FOREIGN KEY (AV)REFERENCES AVION(AV),
CONSTRAINT FK_PIL FOREIGN KEY (PIL)REFERENCES PILOTE(PIL)
);

SELECT * FROM VOL

INSERT INTO VOL(VOL,AV,PIL,VD,VA,HD,HA)
VALUES
('IT100',100,1,'NICE','PARIS',7,9),
('IT101',100,2,'PARIS','TOULOUSE',11,12),
('IT102',101,1,'PARIS','NICE',12,14),
('IT103',105,3,'GRENOBLE','TOULOUSE',9,11),
('IT104',105,3,'TOULOUSE','GRENOBLE',17,19),
('IT105',107,7,'LYON','PARIS',6,7),
('IT106',109,8,'BASTIA','PARIS',10,13),
('IT107',106,9,'PARIS','BRIVE',7,8),
('IT108',106,9,'BRIVE','PARIS',19,20),
('IT109',107,7,'PARIS','LYON',18,19),
('IT110',102,2,'TOULOUSE','PARIS',15,16),
('IT111',101,4,'NICE','NANTES',17,19),
('IT112',103,5,'PARIS','NICE',11,13),
('IT113',104,6,'NICE','PARIS',13,15);

CREATE TABLE PILOTER(
AV INT NOT NULL,
PIL INT NOT NULL,
CONSTRAINT FK_AV_LIER FOREIGN KEY (AV) REFERENCES AVION(AV),
CONSTRAINT FK_PIL_LIER FOREIGN KEY (PIL) REFERENCES PILOTE(PIL)
);

SELECT * FROM PILOTER

SELECT * FROM VOL

/*1*/
SELECT *
FROM VOL
WHERE VD='PARIS' AND HD IN(12,14);

/*2*/
SELECT PILNOM
FROM PILOTE
WHERE  PILNOM LIKE 'S%';

/*3*/
SELECT LOC, COUNT(AV) AS 'NB_AV',MAX(CAP)AS 'MAX',MIN(CAP)AS 'MIN'
FROM AVION
GROUP BY LOC;

/*4*/
SELECT COUNT (*)AS [nbAvion],AVG (CAP)AS [capMoyen],LOC, AVMARQ 
FROM AVION 
GROUP BY LOC, AVMARQ 
ORDER BY LOC;

/*5*/
SELECT LOC,COUNT(AVTYPE) AS MOY,AVG(CAP) AS 'Cap_Moyen'
FROM AVION
GROUP BY LOC HAVING COUNT(AV) > 1;


/*6*/
SELECT PILNOM,ADR
FROM PILOTE p, AVION a
WHERE p.ADR=a.LOC and a.AVMARQ='AIRBUS'
GROUP BY PILNOM,ADR
ORDER BY PILNOM ;

/*7*/
SELECT PILNOM,AVMARQ,LOC
FROM PILOTE p, AVION a inner join VOL v
on V.AV=a.AV
WHERE a.AVMARQ='AIRBUS' and a.AV=v.AV and p.PIL=v.PIL AND p.ADR=a.LOC
GROUP BY PILNOM,AVMARQ,LOC;


/*8*/
SELECT DISTINCT PILNOM
FROM PILOTE p, AVION a inner join VOL v
on V.AV=a.AV
WHERE (a.AVMARQ='AIRBUS' and p.PIL=v.PIL) 
or 
(p.ADR=a.LOC and a.AV = v.AV and AVMARQ = 'AIRBUS')

select PILNOM from PILOTE where ADR in
(select LOC from AVION where AVMARQ = 'AIRBUS')
or
PIL in 
(select PIL from VOL, AVION where AVION.AV = VOL.AV and AVMARQ = 'AIRBUS');

/*9*/
SELECT PILNOM,AVMARQ,LOC
FROM PILOTE p, AVION a inner join VOL V
on V.AV=a.AV
WHERE(a.AVMARQ='AIRBUS' and a.AV=v.AV and p.PIL=v.PIL  AND p.ADR!=a.LOC)
GROUP BY PILNOM,AVMARQ,LOC;

/*10*/
SELECT p.PILNOM, v2.VD,v2.VA
FROM VOL v 
inner join PILOTE p ON p.PIL=v.PIL
inner join VOL v2 ON v2.VD = v.VD AND v.VA = v2.VA 
WHERE v2.PIL <> p.PIL
AND p.PILNOM<>'SERGE';    


/*11*/
SELECT p1.PILNOM, p2.PILNOM
FROM PILOTE p1, PILOTE p2
WHERE p1.ADR=p2.ADR AND p1.PILNOM <p2.PILNOM;


/*12*/
SELECT p2.PIL,p2.PILNOM,a.AVMARQ
FROM VOL v 
inner join AVION a on a.AV=v.AV 
inner join PILOTE p on p.PIL=v.PIL and p.PIL=1 
inner join PILOTE p2 on p2.PIL=v.PIL
where p2.PIL!=1 and p.PILNOM <> 'SERGE';

SELECT PIL,PILNOM FROM PILOTE
WHERE PIL IN(SELECT DISTINCT PIL FROM VOL WHERE AV IN 
(SELECT AV FROM VOL WHERE PIL=1))AND PIL<>1;

/*13*/
SELECT *
FROM PILOTE p inner join VOL v on p.PIL=v.PIL
inner join AVION a on V.AV=a.AV 
where v.VD = a.LOC AND v.VA = p.ADR AND v.AV=a.AV and v.PIL=p.PIL;

/*14*/
SELECT PILOTE.PIL, PILOTE.PILNOM
FROM PILOTE, AVION a ,VOL v
WHERE a.AVMARQ='AIRBUS' and a.AV=v.AV and PILOTE.PIL=v.PIL
GROUP BY PILOTE.PIL, PILOTE.PILNOM;

select distinct pilnom 
from pilote,avion,vol 
where vol.pil=pilote.pil and avion.av=vol.av 
and vol.av =ALL
(select vol.av from vol,avion where vol.av=avion.av and avmarq='AIRBUS')


SELECT DISTINCT PILOTE.PIL, PILOTE.PILNOM
FROM PILOTE
WHERE(SELECT COUNT(*)FROM AVION WHERE AVMARQ='AIRBUS')
	=
(SELECT COUNT(*)FROM VOL INNER JOIN AVION ON VOL.AV=AVION.AV WHERE VOL.PIL=PILOTE.PIL AND AVMARQ='AIRBUS')
	   
