/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     5/12/2018 12:13:31 PM                        */
/*==============================================================*/


drop index if exists CAMPUS_PK;

drop table if exists CAMPUS cascade;

drop index if exists CARACTERISTIQUELOCAL2_FK;

drop index if exists CARACTERISTIQUELOCAL_FK;

drop index if exists CARACTERISTIQUELOCAL_PK;

drop table if exists CARACTERISTIQUELOCAL cascade;

drop index if exists CARACTERISTIQUES_PK;

drop table if exists CARACTERISTIQUES cascade;

drop index if exists CATEGORIES_PK;

drop table if exists CATEGORIES cascade;

drop index if exists FACULTES_DEPARTEMENTS_FK;

drop index if exists DEPARTEMENTS_PK;

drop table if exists DEPARTEMENTS cascade;

drop index if exists EVENEMENTS_PK;

drop table if exists EVENEMENTS cascade;

drop index if exists FACULTES_PK;

drop table if exists FACULTES cascade;

drop index if exists LOCAUX_LOCAUX_FK;

drop index if exists CATEGORIES_LOCAUX_FK;

drop index if exists PAVILLIONS_LOCAUX_FK;

drop index if exists LOCAUX_PK;

drop table if exists LOCAUX cascade;

drop index if exists MEMBRES_LOGS_FK;

drop index if exists LOCAUX_LOGS_FK;

drop table if exists LOGS cascade;

drop index if exists DEPARTEMENTS_MEMBRES_FK;

drop index if exists MEMBRES_PK;

drop table if exists MEMBRES cascade;

drop index if exists CAMPUS_PAVILLIONS_FK;

drop index if exists PAVILLONS_PK;

drop table if exists PAVILLONS cascade;

drop index if exists PRIVILEGESRESERVATION2_FK;

drop index if exists PRIVILEGESRESERVATION_FK;

drop index if exists PRIVILEGESRESERVATION_PK;

drop table if exists PRIVILEGESRESERVATION cascade;

drop index if exists MEMBRE_RESERVATIONS_FK;

drop index if exists LOCAUX_RESERVATION_FK;

drop index if exists EVENEMENTS_RESERVATION_FK;

drop index if exists RESERVATIONS_PK;

drop table if exists RESERVATIONS cascade;

drop index if exists STATUS_PK;

drop table if exists STATUS cascade;

drop index if exists STATUSMEMBRE2_FK;

drop index if exists STATUSMEMBRE_FK;

drop index if exists STATUSMEMBRE_PK;

drop table if exists STATUSMEMBRE cascade;

drop index if exists TEMPSAVANTRESERVATION3_FK;

drop index if exists TEMPSAVANTRESERVATION2_FK;

drop index if exists TEMPSAVANTRESERVATION_FK;

drop index if exists TEMPSAVANTRESERVATION_PK;

drop table if exists TEMPSAVANTRESERVATION cascade;

/*==============================================================*/
/* Table: CAMPUS                                                */
/*==============================================================*/
create table CAMPUS (
   CAMPUSID             INT4                 not null,
   NOM                  VARCHAR(1024)        not null,
   constraint PK_CAMPUS primary key (CAMPUSID)
);

/*==============================================================*/
/* Index: CAMPUS_PK                                             */
/*==============================================================*/
create unique index CAMPUS_PK on CAMPUS (
CAMPUSID
);

/*==============================================================*/
/* Table: CARACTERISTIQUELOCAL                                  */
/*==============================================================*/
create table CARACTERISTIQUELOCAL (
   EQUIPEMENTID         INT4                 not null,
   NUMEROPAVILLON       VARCHAR(16)          not null,
   NUMEROLOCAL          INT4                 not null,
   constraint PK_CARACTERISTIQUELOCAL primary key (NUMEROPAVILLON, EQUIPEMENTID, NUMEROLOCAL)
);

/*==============================================================*/
/* Index: CARACTERISTIQUELOCAL_PK                               */
/*==============================================================*/
create unique index CARACTERISTIQUELOCAL_PK on CARACTERISTIQUELOCAL (
NUMEROPAVILLON,
EQUIPEMENTID,
NUMEROLOCAL
);

/*==============================================================*/
/* Index: CARACTERISTIQUELOCAL_FK                               */
/*==============================================================*/
create  index CARACTERISTIQUELOCAL_FK on CARACTERISTIQUELOCAL (
EQUIPEMENTID
);

/*==============================================================*/
/* Index: CARACTERISTIQUELOCAL2_FK                              */
/*==============================================================*/
create  index CARACTERISTIQUELOCAL2_FK on CARACTERISTIQUELOCAL (
NUMEROPAVILLON,
NUMEROLOCAL
);

/*==============================================================*/
/* Table: CARACTERISTIQUES                                      */
/*==============================================================*/
create table CARACTERISTIQUES (
   EQUIPEMENTID         INT4                 not null,
   NOM                  VARCHAR(1024)        not null,
   constraint PK_CARACTERISTIQUES primary key (EQUIPEMENTID)
);

/*==============================================================*/
/* Index: CARACTERISTIQUES_PK                                   */
/*==============================================================*/
create unique index CARACTERISTIQUES_PK on CARACTERISTIQUES (
EQUIPEMENTID
);

/*==============================================================*/
/* Table: CATEGORIES                                            */
/*==============================================================*/
create table CATEGORIES (
   CATEGORIEID          INT4                 not null,
   NOM                  VARCHAR(1024)        not null,
   BLOCDEBUT            INT4                 not null,
   BLOCFIN              INT4                 not null,
   constraint PK_CATEGORIES primary key (CATEGORIEID)
);

/*==============================================================*/
/* Index: CATEGORIES_PK                                         */
/*==============================================================*/
create unique index CATEGORIES_PK on CATEGORIES (
CATEGORIEID
);

/*==============================================================*/
/* Table: DEPARTEMENTS                                          */
/*==============================================================*/
create table DEPARTEMENTS (
   FACULTEID            INT4                 not null,
   DEPARTEMENTID        INT4                 not null,
   NOM                  VARCHAR(1024)        not null,
   constraint PK_DEPARTEMENTS primary key (FACULTEID, DEPARTEMENTID)
);

/*==============================================================*/
/* Index: DEPARTEMENTS_PK                                       */
/*==============================================================*/
create unique index DEPARTEMENTS_PK on DEPARTEMENTS (
FACULTEID,
DEPARTEMENTID
);

/*==============================================================*/
/* Index: FACULTES_DEPARTEMENTS_FK                              */
/*==============================================================*/
create  index FACULTES_DEPARTEMENTS_FK on DEPARTEMENTS (
FACULTEID
);

/*==============================================================*/
/* Table: EVENEMENTS                                            */
/*==============================================================*/
create table EVENEMENTS (
   EVENEMENTID          INT4                 not null,
   constraint PK_EVENEMENTS primary key (EVENEMENTID)
);

/*==============================================================*/
/* Index: EVENEMENTS_PK                                         */
/*==============================================================*/
create unique index EVENEMENTS_PK on EVENEMENTS (
EVENEMENTID
);

/*==============================================================*/
/* Table: FACULTES                                              */
/*==============================================================*/
create table FACULTES (
   FACULTEID            INT4                 not null,
   NOM                  VARCHAR(1024)        not null,
   constraint PK_FACULTES primary key (FACULTEID)
);

/*==============================================================*/
/* Index: FACULTES_PK                                           */
/*==============================================================*/
create unique index FACULTES_PK on FACULTES (
FACULTEID
);

/*==============================================================*/
/* Table: LOCAUX                                                */
/*==============================================================*/
create table LOCAUX (
   NUMEROPAVILLON       VARCHAR(16)          not null,
   NUMEROLOCAL          INT4                 not null,
   NUMEROPAVILLONPARENT VARCHAR(16)          null,
   NUMEROLOCALPARENT    INT4                 null,
   CATEGORIEID          INT4                 not null,
   CAPACITE             INT4                 not null,
   NOTE                 TEXT                 null,
   constraint PK_LOCAUX primary key (NUMEROPAVILLON, NUMEROLOCAL)
);

/*==============================================================*/
/* Index: LOCAUX_PK                                             */
/*==============================================================*/
create unique index LOCAUX_PK on LOCAUX (
NUMEROPAVILLON,
NUMEROLOCAL
);

/*==============================================================*/
/* Index: PAVILLIONS_LOCAUX_FK                                  */
/*==============================================================*/
create  index PAVILLIONS_LOCAUX_FK on LOCAUX (
NUMEROPAVILLON
);

/*==============================================================*/
/* Index: CATEGORIES_LOCAUX_FK                                  */
/*==============================================================*/
create  index CATEGORIES_LOCAUX_FK on LOCAUX (
CATEGORIEID
);

/*==============================================================*/
/* Index: LOCAUX_LOCAUX_FK                                      */
/*==============================================================*/
create  index LOCAUX_LOCAUX_FK on LOCAUX (
NUMEROPAVILLONPARENT,
NUMEROLOCALPARENT
);

/*==============================================================*/
/* Table: LOGS                                                  */
/*==============================================================*/
create table LOGS (
   CIP                  VARCHAR(8)           not null,
   NUMEROPAVILLON       VARCHAR(16)          null,
   NUMEROLOCAL          INT4                 null,
   LOGDATE              DATE                 not null,
   MESSAGE              VARCHAR(1024)        not null
);

/*==============================================================*/
/* Index: LOCAUX_LOGS_FK                                        */
/*==============================================================*/
create  index LOCAUX_LOGS_FK on LOGS (
NUMEROPAVILLON,
NUMEROLOCAL
);

/*==============================================================*/
/* Index: MEMBRES_LOGS_FK                                       */
/*==============================================================*/
create  index MEMBRES_LOGS_FK on LOGS (
CIP
);

/*==============================================================*/
/* Table: MEMBRES                                               */
/*==============================================================*/
create table MEMBRES (
   CIP                  VARCHAR(8)           not null,
   FACULTEID            INT4                 not null,
   DEPARTEMENTID        INT4                 not null,
   NOM                  VARCHAR(1024)        not null,
   PRENOM               VARCHAR(1024)        not null,
   constraint PK_MEMBRES primary key (CIP)
);

/*==============================================================*/
/* Index: MEMBRES_PK                                            */
/*==============================================================*/
create unique index MEMBRES_PK on MEMBRES (
CIP
);

/*==============================================================*/
/* Index: DEPARTEMENTS_MEMBRES_FK                               */
/*==============================================================*/
create  index DEPARTEMENTS_MEMBRES_FK on MEMBRES (
FACULTEID,
DEPARTEMENTID
);

/*==============================================================*/
/* Table: PAVILLONS                                             */
/*==============================================================*/
create table PAVILLONS (
   NUMEROPAVILLON       VARCHAR(16)          not null,
   CAMPUSID             INT4                 not null,
   NOM                  VARCHAR(1024)        not null,
   constraint PK_PAVILLONS primary key (NUMEROPAVILLON)
);

/*==============================================================*/
/* Index: PAVILLONS_PK                                          */
/*==============================================================*/
create unique index PAVILLONS_PK on PAVILLONS (
NUMEROPAVILLON
);

/*==============================================================*/
/* Index: CAMPUS_PAVILLIONS_FK                                  */
/*==============================================================*/
create  index CAMPUS_PAVILLIONS_FK on PAVILLONS (
CAMPUSID
);

/*==============================================================*/
/* Table: PRIVILEGESRESERVATION                                 */
/*==============================================================*/
create table PRIVILEGESRESERVATION (
   STATUSID             INT4                 not null,
   CATEGORIEID          INT4                 not null,
   PLUSDE24H            INT4                 not null,
   LECTURE              INT4                 not null,
   ECRITURE             INT4                 not null,
   OVERRIDE             INT4                 not null,
   constraint PK_PRIVILEGESRESERVATION primary key (STATUSID, CATEGORIEID)
);

/*==============================================================*/
/* Index: PRIVILEGESRESERVATION_PK                              */
/*==============================================================*/
create unique index PRIVILEGESRESERVATION_PK on PRIVILEGESRESERVATION (
STATUSID,
CATEGORIEID
);

/*==============================================================*/
/* Index: PRIVILEGESRESERVATION_FK                              */
/*==============================================================*/
create  index PRIVILEGESRESERVATION_FK on PRIVILEGESRESERVATION (
STATUSID
);

/*==============================================================*/
/* Index: PRIVILEGESRESERVATION2_FK                             */
/*==============================================================*/
create  index PRIVILEGESRESERVATION2_FK on PRIVILEGESRESERVATION (
CATEGORIEID
);

/*==============================================================*/
/* Table: RESERVATIONS                                          */
/*==============================================================*/
create table RESERVATIONS (
   NUMEROPAVILLON       VARCHAR(16)          not null,
   NUMEROLOCAL          INT4                 not null,
   DATE                 DATE                 not null,
   NUMEROBLOC           INT4                 not null,
   EVENEMENTID          INT4                 not null,
   CIP                  VARCHAR(8)           not null,
   constraint PK_RESERVATIONS primary key (NUMEROPAVILLON, NUMEROLOCAL, DATE, NUMEROBLOC)
);

/*==============================================================*/
/* Index: RESERVATIONS_PK                                       */
/*==============================================================*/
create unique index RESERVATIONS_PK on RESERVATIONS (
NUMEROPAVILLON,
NUMEROLOCAL,
DATE,
NUMEROBLOC
);

/*==============================================================*/
/* Index: EVENEMENTS_RESERVATION_FK                             */
/*==============================================================*/
create  index EVENEMENTS_RESERVATION_FK on RESERVATIONS (
EVENEMENTID
);

/*==============================================================*/
/* Index: LOCAUX_RESERVATION_FK                                 */
/*==============================================================*/
create  index LOCAUX_RESERVATION_FK on RESERVATIONS (
NUMEROPAVILLON,
NUMEROLOCAL
);

/*==============================================================*/
/* Index: MEMBRE_RESERVATIONS_FK                                */
/*==============================================================*/
create  index MEMBRE_RESERVATIONS_FK on RESERVATIONS (
CIP
);

/*==============================================================*/
/* Table: STATUS                                                */
/*==============================================================*/
create table STATUS (
   STATUSID             INT4                 not null,
   NOM                  VARCHAR(1024)        not null,
   constraint PK_STATUS primary key (STATUSID)
);

/*==============================================================*/
/* Index: STATUS_PK                                             */
/*==============================================================*/
create unique index STATUS_PK on STATUS (
STATUSID
);

/*==============================================================*/
/* Table: STATUSMEMBRE                                          */
/*==============================================================*/
create table STATUSMEMBRE (
   CIP                  VARCHAR(8)           not null,
   STATUSID             INT4                 not null,
   constraint PK_STATUSMEMBRE primary key (CIP, STATUSID)
);

/*==============================================================*/
/* Index: STATUSMEMBRE_PK                                       */
/*==============================================================*/
create unique index STATUSMEMBRE_PK on STATUSMEMBRE (
CIP,
STATUSID
);

/*==============================================================*/
/* Index: STATUSMEMBRE_FK                                       */
/*==============================================================*/
create  index STATUSMEMBRE_FK on STATUSMEMBRE (
CIP
);

/*==============================================================*/
/* Index: STATUSMEMBRE2_FK                                      */
/*==============================================================*/
create  index STATUSMEMBRE2_FK on STATUSMEMBRE (
STATUSID
);

/*==============================================================*/
/* Table: TEMPSAVANTRESERVATION                                 */
/*==============================================================*/
create table TEMPSAVANTRESERVATION (
   STATUSID             INT4                 not null,
   CATEGORIEID          INT4                 not null,
   FACULTEID            INT4                 not null,
   DEPARTEMENTID        INT4                 not null,
   NUMEROBLOC           INT4                 not null,
   constraint PK_TEMPSAVANTRESERVATION primary key (FACULTEID, STATUSID, CATEGORIEID, DEPARTEMENTID)
);

/*==============================================================*/
/* Index: TEMPSAVANTRESERVATION_PK                              */
/*==============================================================*/
create unique index TEMPSAVANTRESERVATION_PK on TEMPSAVANTRESERVATION (
FACULTEID,
STATUSID,
CATEGORIEID,
DEPARTEMENTID
);

/*==============================================================*/
/* Index: TEMPSAVANTRESERVATION_FK                              */
/*==============================================================*/
create  index TEMPSAVANTRESERVATION_FK on TEMPSAVANTRESERVATION (
STATUSID
);

/*==============================================================*/
/* Index: TEMPSAVANTRESERVATION2_FK                             */
/*==============================================================*/
create  index TEMPSAVANTRESERVATION2_FK on TEMPSAVANTRESERVATION (
CATEGORIEID
);

/*==============================================================*/
/* Index: TEMPSAVANTRESERVATION3_FK                             */
/*==============================================================*/
create  index TEMPSAVANTRESERVATION3_FK on TEMPSAVANTRESERVATION (
FACULTEID,
DEPARTEMENTID
);

alter table CARACTERISTIQUELOCAL
   add constraint FK_CARACTER_CARACTERI_CARACTER foreign key (EQUIPEMENTID)
      references CARACTERISTIQUES (EQUIPEMENTID)
      on delete restrict on update restrict;

alter table CARACTERISTIQUELOCAL
   add constraint FK_CARACTER_CARACTERI_LOCAUX foreign key (NUMEROPAVILLON, NUMEROLOCAL)
      references LOCAUX (NUMEROPAVILLON, NUMEROLOCAL)
      on delete restrict on update restrict;

alter table DEPARTEMENTS
   add constraint FK_DEPARTEM_FACULTES__FACULTES foreign key (FACULTEID)
      references FACULTES (FACULTEID)
      on delete restrict on update restrict;

alter table LOCAUX
   add constraint FK_LOCAUX_CATEGORIE_CATEGORI foreign key (CATEGORIEID)
      references CATEGORIES (CATEGORIEID)
      on delete restrict on update restrict;

alter table LOCAUX
   add constraint FK_LOCAUX_LOCAUX_LO_LOCAUX foreign key (NUMEROPAVILLONPARENT, NUMEROLOCALPARENT)
      references LOCAUX (NUMEROPAVILLON, NUMEROLOCAL)
      on delete restrict on update restrict;

alter table LOCAUX
   add constraint FK_LOCAUX_PAVILLION_PAVILLON foreign key (NUMEROPAVILLON)
      references PAVILLONS (NUMEROPAVILLON)
      on delete restrict on update restrict;

alter table LOGS
   add constraint FK_LOGS_LOCAUX_LO_LOCAUX foreign key (NUMEROPAVILLON, NUMEROLOCAL)
      references LOCAUX (NUMEROPAVILLON, NUMEROLOCAL)
      on delete restrict on update restrict;

alter table LOGS
   add constraint FK_LOGS_MEMBRES_L_MEMBRES foreign key (CIP)
      references MEMBRES (CIP)
      on delete restrict on update restrict;

alter table MEMBRES
   add constraint FK_MEMBRES_DEPARTEME_DEPARTEM foreign key (FACULTEID, DEPARTEMENTID)
      references DEPARTEMENTS (FACULTEID, DEPARTEMENTID)
      on delete restrict on update restrict;

alter table PAVILLONS
   add constraint FK_PAVILLON_CAMPUS_PA_CAMPUS foreign key (CAMPUSID)
      references CAMPUS (CAMPUSID)
      on delete restrict on update restrict;

alter table PRIVILEGESRESERVATION
   add constraint FK_PRIVILEG_PRIVILEGE_STATUS foreign key (STATUSID)
      references STATUS (STATUSID)
      on delete restrict on update restrict;

alter table PRIVILEGESRESERVATION
   add constraint FK_PRIVILEG_PRIVILEGE_CATEGORI foreign key (CATEGORIEID)
      references CATEGORIES (CATEGORIEID)
      on delete restrict on update restrict;

alter table RESERVATIONS
   add constraint FK_RESERVAT_EVENEMENT_EVENEMEN foreign key (EVENEMENTID)
      references EVENEMENTS (EVENEMENTID)
      on delete restrict on update restrict;

alter table RESERVATIONS
   add constraint FK_RESERVAT_LOCAUX_RE_LOCAUX foreign key (NUMEROPAVILLON, NUMEROLOCAL)
      references LOCAUX (NUMEROPAVILLON, NUMEROLOCAL)
      on delete restrict on update restrict;

alter table RESERVATIONS
   add constraint FK_RESERVAT_MEMBRE_RE_MEMBRES foreign key (CIP)
      references MEMBRES (CIP)
      on delete restrict on update restrict;

alter table STATUSMEMBRE
   add constraint FK_STATUSME_STATUSMEM_MEMBRES foreign key (CIP)
      references MEMBRES (CIP)
      on delete restrict on update restrict;

alter table STATUSMEMBRE
   add constraint FK_STATUSME_STATUSMEM_STATUS foreign key (STATUSID)
      references STATUS (STATUSID)
      on delete restrict on update restrict;

alter table TEMPSAVANTRESERVATION
   add constraint FK_TEMPSAVA_TEMPSAVAN_STATUS foreign key (STATUSID)
      references STATUS (STATUSID)
      on delete restrict on update restrict;

alter table TEMPSAVANTRESERVATION
   add constraint FK_TEMPSAVA_TEMPSAVAN_CATEGORI foreign key (CATEGORIEID)
      references CATEGORIES (CATEGORIEID)
      on delete restrict on update restrict;

alter table TEMPSAVANTRESERVATION
   add constraint FK_TEMPSAVA_TEMPSAVAN_DEPARTEM foreign key (FACULTEID, DEPARTEMENTID)
      references DEPARTEMENTS (FACULTEID, DEPARTEMENTID)
      on delete restrict on update restrict;

