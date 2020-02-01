create database avions
go

use avions
go

/* -----------------------------------------------------------------------------
      TABLE : LIAISON
----------------------------------------------------------------------------- */

create table LIAISON
  (
     NUMERO int  not null  ,
     VILLE_ORIGINE varchar(255)  not null  ,
     VILLE_DESTINATION varchar(255)  not null  
     ,
     constraint PK_LIAISON primary key (NUMERO)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : VOL
----------------------------------------------------------------------------- */

create table VOL
  (
     NUMERO_VOL int  not null  ,
     NUMERO int  not null  ,
     NUMERO_IMMATRICULATION int  not null  ,
     DATE_VALIDITE_DEBUT datetime  not null  ,
     DATE_VALIDITE_FIN datetime  not null  ,
     HEURE_DEPART datetime  not null  ,
     HEURE_ARRIVEE datetime  not null  
     ,
     constraint PK_VOL primary key (NUMERO_VOL)
  ) 
go

/* -----------------------------------------------------------------------------
      TABLE : BILLET
----------------------------------------------------------------------------- */

create table BILLET
  (
     NUMERO_BILLLET int  not null  ,
     DATE_DEPART datetime  not null  ,
     NUMERO_VOL_EXISTER int  not null  ,
     NUMERO_PASSAGER int  not null  ,
     DATE_RESERV datetime  not null  ,
     PRIX money  not null  
     ,
     constraint PK_BILLET primary key (NUMERO_BILLLET)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : DEPART
----------------------------------------------------------------------------- */

create table DEPART
  (
     DATE_DEPART datetime  not null  ,
     NUMERO_VOL_EXISTER int  not null  ,
     PLACES_LIBRES tinyint  not null  ,
     PLACES_OCCUPEES tinyint  not null  
     ,
     constraint PK_DEPART primary key (DATE_DEPART, NUMERO_VOL_EXISTER)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : APPAREIL
----------------------------------------------------------------------------- */

create table APPAREIL
  (
     NUMERO_IMMATRICULATION int  not null  ,
     TYPEA varchar(128)  not null  ,
	CAPACITE tinyint  not null  ,
     MODELE char(32)  not null  
     ,
     constraint PK_APPAREIL primary key (NUMERO_IMMATRICULATION)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : CONSTRUCTEURS
----------------------------------------------------------------------------- */

create table CONSTRUCTEURS
  (
     ID_CONSTRUCTEUR char(32)  not null  ,
     NOM_CONSTRUCTEUR char(32)  not null  ,
     NATIONALITÉ_CONSTRUCTEUR char(32)  null  
     ,
     constraint PK_CONSTRUCTEURS primary key (ID_CONSTRUCTEUR)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : EQUIPAGE ( l' équipage navigant ne concerne pas les pilotes mais uniquement le personnel d'embarquement et  d'assistance de vol  : Hôtesses, Stewards...)
----------------------------------------------------------------------------- */

create table EQUIPAGE
  (
     ID_EQUIPAGE_NAVIGANT varchar(255)  not null  ,
     NBRE_MEMBRE char(32)  null  
     ,
     constraint PK_EQUIPAGE primary key (ID_EQUIPAGE_NAVIGANT)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : PASSAGER
----------------------------------------------------------------------------- */

create table PASSAGER
  (
     NUMERO_PASSAGER int  not null  ,
     NOM varchar(128)  not null  ,
     PRENOM varchar(128)  not null  ,
     ADRESSE varchar(255)  not null  ,
     PROFESSION varchar(128)  not null  ,
     BANQUE varchar(128)  not null  
     ,
     constraint PK_PASSAGER primary key (NUMERO_PASSAGER)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : PILOTE
----------------------------------------------------------------------------- */

create table PILOTE
  (
     NUMERO_LICENCE smallint  not null  ,
     NOM_PILOTE char(32)  null  ,
     PRENOM_PILOTE char(32)  null  
     ,
     constraint PK_PILOTE primary key (NUMERO_LICENCE)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : EMBARQUER
----------------------------------------------------------------------------- */

create table EMBARQUER
  (
     ID_EQUIPAGE_NAVIGANT varchar(255)  not null  ,
     DATE_DEPART datetime  not null  ,
     NUMERO_VOL_EXISTER int  not null  
     ,
     constraint PK_EMBARQUER primary key (ID_EQUIPAGE_NAVIGANT, DATE_DEPART, NUMERO_VOL_EXISTER)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : APPARTENIR
----------------------------------------------------------------------------- */

create table APPARTENIR
  (
     NUMERO_IMMATRICULATION int  not null  ,
     ID_CONSTRUCTEUR char(32)  not null  
     ,
     constraint PK_APPARTENIR primary key (NUMERO_IMMATRICULATION, ID_CONSTRUCTEUR)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : PILOTER
----------------------------------------------------------------------------- */

create table PILOTER
  (
     NUMERO_LICENCE smallint  not null  ,
     DATE_DEPART datetime  not null  ,
     NUMERO_VOL_EXISTER int  not null  
     ,
     constraint PK_PILOTER primary key (NUMERO_LICENCE, DATE_DEPART, NUMERO_VOL_EXISTER)
  ) 
go



/* -----------------------------------------------------------------------------
      REFERENCES SUR LES TABLES
----------------------------------------------------------------------------- */



alter table VOL 
     add constraint FK_VOL_LIAISON foreign key (NUMERO) 
               references LIAISON (NUMERO)
go




alter table VOL 
     add constraint FK_VOL_APPAREIL foreign key (NUMERO_IMMATRICULATION) 
               references APPAREIL (NUMERO_IMMATRICULATION)
go




alter table BILLET 
     add constraint FK_BILLET_DEPART foreign key (DATE_DEPART, NUMERO_VOL_EXISTER) 
               references DEPART (DATE_DEPART, NUMERO_VOL_EXISTER)
go




alter table BILLET 
     add constraint FK_BILLET_PASSAGER foreign key (NUMERO_PASSAGER) 
               references PASSAGER (NUMERO_PASSAGER)
go




alter table DEPART 
     add constraint FK_DEPART_VOL foreign key (NUMERO_VOL_EXISTER) 
               references VOL (NUMERO_VOL)
go




alter table EMBARQUER 
     add constraint FK_EMBARQUER_EQUIPAGE foreign key (ID_EQUIPAGE_NAVIGANT) 
               references EQUIPAGE (ID_EQUIPAGE_NAVIGANT)
go




alter table EMBARQUER 
     add constraint FK_EMBARQUER_DEPART foreign key (DATE_DEPART, NUMERO_VOL_EXISTER) 
               references DEPART (DATE_DEPART, NUMERO_VOL_EXISTER)
go




alter table APPARTENIR 
     add constraint FK_APPARTENIR_APPAREIL foreign key (NUMERO_IMMATRICULATION) 
               references APPAREIL (NUMERO_IMMATRICULATION)
go




alter table APPARTENIR 
     add constraint FK_APPARTENIR_CONSTRUCTEURS foreign key (ID_CONSTRUCTEUR) 
               references CONSTRUCTEURS (ID_CONSTRUCTEUR)
go




alter table PILOTER 
     add constraint FK_PILOTER_PILOTE foreign key (NUMERO_LICENCE) 
               references PILOTE (NUMERO_LICENCE)
go




alter table PILOTER 
     add constraint FK_PILOTER_DEPART foreign key (DATE_DEPART, NUMERO_VOL_EXISTER) 
               references DEPART (DATE_DEPART, NUMERO_VOL_EXISTER)
go
