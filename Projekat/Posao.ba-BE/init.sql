-- MySQL Script generated by MySQL Workbench
-- Čet 11 Maj 2017 00:24:11
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema tim2
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `tim2` ;

-- -----------------------------------------------------
-- Schema tim2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tim2` DEFAULT CHARACTER SET utf8 ;
USE `tim2` ;

-- -----------------------------------------------------
-- Table `tim2`.`korisnici`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tim2`.`korisnici` ;

CREATE TABLE IF NOT EXISTS `tim2`.`korisnici` (
  `idKorisnika` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(30) NOT NULL,
  `password_hash` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idKorisnika`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tim2`.`nezaposleni`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tim2`.`nezaposleni` ;

CREATE TABLE IF NOT EXISTS `tim2`.`nezaposleni` (
  `idKorisnika` INT NOT NULL,
  `ime` VARCHAR(60) NOT NULL,
  `prezime` VARCHAR(60) NOT NULL,
  `cv` VARCHAR(1000) NULL,
  `privatanProfil` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idKorisnika`),
  CONSTRAINT `fk_Nezaposleni_Korisnici`
    FOREIGN KEY (`idKorisnika`)
    REFERENCES `tim2`.`korisnici` (`idKorisnika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tim2`.`poslodavci`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tim2`.`poslodavci` ;

CREATE TABLE IF NOT EXISTS `tim2`.`poslodavci` (
  `idKorisnika` INT NOT NULL,
  `ime` VARCHAR(60) NOT NULL,
  `prezime` VARCHAR(60) NOT NULL,
  `nazivFirme` VARCHAR(100) NOT NULL,
  `telefon` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idKorisnika`),
  CONSTRAINT `fk_Poslodavci_Korisnici1`
    FOREIGN KEY (`idKorisnika`)
    REFERENCES `tim2`.`korisnici` (`idKorisnika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tim2`.`admin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tim2`.`admin` ;

CREATE TABLE IF NOT EXISTS `tim2`.`admin` (
  `idKorisnika` INT NOT NULL,
  PRIMARY KEY (`idKorisnika`),
  CONSTRAINT `fk_Admin_Korisnici1`
    FOREIGN KEY (`idKorisnika`)
    REFERENCES `tim2`.`korisnici` (`idKorisnika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tim2`.`kantoni`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tim2`.`kantoni` ;

CREATE TABLE IF NOT EXISTS `tim2`.`kantoni` (
  `idKantona` INT NOT NULL AUTO_INCREMENT,
  `naziv` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idKantona`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tim2`.`lokacije`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tim2`.`lokacije` ;

CREATE TABLE IF NOT EXISTS `tim2`.`lokacije` (
  `idLokacije` INT NOT NULL AUTO_INCREMENT,
  `idKantona` INT NOT NULL,
  `naziv` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idLokacije`),
  INDEX `fk_Lokacije_Kantoni1_idx` (`idKantona` ASC),
  CONSTRAINT `fk_Lokacije_Kantoni1`
    FOREIGN KEY (`idKantona`)
    REFERENCES `tim2`.`kantoni` (`idKantona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tim2`.`kategorije`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tim2`.`kategorije` ;

CREATE TABLE IF NOT EXISTS `tim2`.`kategorije` (
  `idKategorije` INT NOT NULL AUTO_INCREMENT,
  `naziv` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idKategorije`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tim2`.`oglas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tim2`.`oglas` ;

CREATE TABLE IF NOT EXISTS `tim2`.`oglas` (
  `idOglasa` INT NOT NULL AUTO_INCREMENT,
  `idPoslodavca` INT NOT NULL,
  `idLokacije` INT NOT NULL,
  `idKategorije` INT NOT NULL,
  `datumObjave` DATETIME NOT NULL,
  `datumIsteka` DATETIME NOT NULL,
  `sakriven` TINYINT NOT NULL,
  `zatvoren` TINYINT NOT NULL DEFAULT 0,
  `uspjesan` TINYINT NULL,
  `prioritet` INT NOT NULL DEFAULT 5,
  PRIMARY KEY (`idOglasa`),
  INDEX `fk_Oglas_Poslodavci1_idx` (`idPoslodavca` ASC),
  INDEX `fk_Oglas_Lokacije1_idx` (`idLokacije` ASC),
  INDEX `fk_Oglas_Kategorije1_idx` (`idKategorije` ASC),
  CONSTRAINT `fk_Oglas_Poslodavci1`
    FOREIGN KEY (`idPoslodavca`)
    REFERENCES `tim2`.`poslodavci` (`idKorisnika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Oglas_Lokacije1`
    FOREIGN KEY (`idLokacije`)
    REFERENCES `tim2`.`lokacije` (`idLokacije`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Oglas_Kategorije1`
    FOREIGN KEY (`idKategorije`)
    REFERENCES `tim2`.`kategorije` (`idKategorije`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tim2`.`oglasprijave`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tim2`.`oglasprijave` ;

CREATE TABLE IF NOT EXISTS `tim2`.`oglasprijave` (
  `idPrijave` INT NOT NULL AUTO_INCREMENT,
  `idOglasa` INT NOT NULL,
  `idKorisnika` INT NOT NULL,
  `dodatneInformacije` VARCHAR(1000) NULL,
  `vrijemePrijave` DATETIME NOT NULL,
  PRIMARY KEY (`idPrijave`),
  INDEX `fk_OglasPrijave_Oglas1_idx` (`idOglasa` ASC),
  INDEX `fk_OglasPrijave_Nezaposleni1_idx` (`idKorisnika` ASC),
  CONSTRAINT `fk_OglasPrijave_Oglas1`
    FOREIGN KEY (`idOglasa`)
    REFERENCES `tim2`.`oglas` (`idOglasa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OglasPrijave_Nezaposleni1`
    FOREIGN KEY (`idKorisnika`)
    REFERENCES `tim2`.`nezaposleni` (`idKorisnika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tim2`.`template`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tim2`.`template` ;

CREATE TABLE IF NOT EXISTS `tim2`.`template` (
  `idTemplate` INT NOT NULL AUTO_INCREMENT,
  `naziv` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTemplate`, `naziv`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tim2`.`sakrivenipodaci`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tim2`.`sakrivenipodaci` ;

CREATE TABLE IF NOT EXISTS `tim2`.`sakrivenipodaci` (
  `idPoslodavca` INT NOT NULL,
  `privatnoIme` TINYINT NOT NULL DEFAULT 0,
  `privatnoPrezime` TINYINT NOT NULL DEFAULT 0,
  `privatnanTelefon` TINYINT NOT NULL DEFAULT 0,
  `privatanEmail` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idPoslodavca`),
  CONSTRAINT `fk_SakriveniPodaci_Poslodavci1`
    FOREIGN KEY (`idPoslodavca`)
    REFERENCES `tim2`.`poslodavci` (`idKorisnika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tim2`.`poljatemplatea`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tim2`.`poljatemplatea` ;

CREATE TABLE IF NOT EXISTS `tim2`.`poljatemplatea` (
  `idPolja` INT NOT NULL AUTO_INCREMENT,
  `idTemplate` INT NOT NULL,
  `nazivPolja` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPolja`),
  INDEX `fk_PoljaTemplatea_Template1_idx` (`idTemplate` ASC),
  CONSTRAINT `fk_PoljaTemplatea_Template1`
    FOREIGN KEY (`idTemplate`)
    REFERENCES `tim2`.`template` (`idTemplate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tim2`.`oglaspodaci`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tim2`.`oglaspodaci` ;

CREATE TABLE IF NOT EXISTS `tim2`.`oglaspodaci` (
  `idOglasa` INT NOT NULL,
  `idTemplate` INT NOT NULL,
  `idPolja` INT NOT NULL,
  `vrijednost` VARCHAR(1000) NOT NULL,
  INDEX `fk_OglasPodaci_Template1_idx` (`idTemplate` ASC),
  INDEX `fk_OglasPodaci_PoljaTemplatea1_idx` (`idPolja` ASC),
  INDEX `fk_OglasPodaci_Oglas1_idx` (`idOglasa` ASC),
  UNIQUE INDEX `idPolja_UNIQUE` (`idPolja` ASC),
  CONSTRAINT `fk_OglasPodaci_Oglas1`
    FOREIGN KEY (`idOglasa`)
    REFERENCES `tim2`.`oglas` (`idOglasa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OglasPodaci_Template1`
    FOREIGN KEY (`idTemplate`)
    REFERENCES `tim2`.`template` (`idTemplate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OglasPodaci_PoljaTemplatea1`
    FOREIGN KEY (`idPolja`)
    REFERENCES `tim2`.`poljatemplatea` (`idPolja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tim2`.`poruke`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tim2`.`poruke` ;

CREATE TABLE IF NOT EXISTS `tim2`.`poruke` (
  `idPoruke` INT NOT NULL AUTO_INCREMENT,
  `idNezaposlenog` INT NOT NULL,
  `idPoslodavca` INT NOT NULL,
  `tekst` VARCHAR(1000) NOT NULL,
  `vrijeme` DATETIME NOT NULL,
  `procitano` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idPoruke`),
  INDEX `fk_Poruke_Nezaposleni1_idx` (`idNezaposlenog` ASC),
  INDEX `fk_Poruke_Poslodavci1_idx` (`idPoslodavca` ASC),
  CONSTRAINT `fk_Poruke_Nezaposleni1`
    FOREIGN KEY (`idNezaposlenog`)
    REFERENCES `tim2`.`nezaposleni` (`idKorisnika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Poruke_Poslodavci1`
    FOREIGN KEY (`idPoslodavca`)
    REFERENCES `tim2`.`poslodavci` (`idKorisnika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tim2`.`notifikacija`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tim2`.`notifikacija` ;

CREATE TABLE IF NOT EXISTS `tim2`.`notifikacija` (
  `idNotifikacije` INT NOT NULL AUTO_INCREMENT,
  `idKorisnika` INT NOT NULL,
  `tekst` VARCHAR(255) NOT NULL,
  `pregledana` TINYINT NOT NULL DEFAULT 0,
  `vrijemeGenerisanja` DATETIME NOT NULL,
  PRIMARY KEY (`idNotifikacije`),
  INDEX `fk_Notifikacija_Korisnici1_idx` (`idKorisnika` ASC),
  CONSTRAINT `fk_Notifikacija_Korisnici1`
    FOREIGN KEY (`idKorisnika`)
    REFERENCES `tim2`.`korisnici` (`idKorisnika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tim2`.`pozivnice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tim2`.`pozivnice` ;

CREATE TABLE IF NOT EXISTS `tim2`.`pozivnice` (
  `idPozivnice` INT NOT NULL AUTO_INCREMENT,
  `idOglasa` INT NOT NULL,
  `idKorisnika` INT NOT NULL,
  PRIMARY KEY (`idPozivnice`),
  INDEX `fk_Pozivnice_Oglas1_idx` (`idOglasa` ASC),
  INDEX `fk_Pozivnice_Nezaposleni1_idx` (`idKorisnika` ASC),
  CONSTRAINT `fk_Pozivnice_Oglas1`
    FOREIGN KEY (`idOglasa`)
    REFERENCES `tim2`.`oglas` (`idOglasa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pozivnice_Nezaposleni1`
    FOREIGN KEY (`idKorisnika`)
    REFERENCES `tim2`.`nezaposleni` (`idKorisnika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tim2`.`notifikacijaprijava`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tim2`.`notifikacijaprijava` ;

CREATE TABLE IF NOT EXISTS `tim2`.`notifikacijaprijava` (
  `idNotifikacije` INT NOT NULL,
  `idPrijave` INT NOT NULL,
  `idPrijavljenog` INT NOT NULL,
  PRIMARY KEY (`idNotifikacije`),
  INDEX `fk_NotifikacijaPrijava_OglasPrijave1_idx` (`idPrijave` ASC),
  INDEX `fk_NotifikacijaPrijava_Nezaposleni1_idx` (`idPrijavljenog` ASC),
  CONSTRAINT `fk_NotifikacijaPrijava_Notifikacija1`
    FOREIGN KEY (`idNotifikacije`)
    REFERENCES `tim2`.`notifikacija` (`idNotifikacije`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_NotifikacijaPrijava_OglasPrijave1`
    FOREIGN KEY (`idPrijave`)
    REFERENCES `tim2`.`oglasprijave` (`idPrijave`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_NotifikacijaPrijava_Nezaposleni1`
    FOREIGN KEY (`idPrijavljenog`)
    REFERENCES `tim2`.`nezaposleni` (`idKorisnika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tim2`.`notifikacijapozivnica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tim2`.`notifikacijapozivnica` ;

CREATE TABLE IF NOT EXISTS `tim2`.`notifikacijapozivnica` (
  `idNotifikacije` INT NOT NULL,
  `idPozivnice` INT NOT NULL,
  PRIMARY KEY (`idNotifikacije`),
  INDEX `fk_NotifikacijaPozivnica_Pozivnice1_idx` (`idPozivnice` ASC),
  CONSTRAINT `fk_NotifikacijaPozivnica_Notifikacija1`
    FOREIGN KEY (`idNotifikacije`)
    REFERENCES `tim2`.`notifikacija` (`idNotifikacije`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_NotifikacijaPozivnica_Pozivnice1`
    FOREIGN KEY (`idPozivnice`)
    REFERENCES `tim2`.`pozivnice` (`idPozivnice`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `tim2`.`korisnici`
-- -----------------------------------------------------
START TRANSACTION;
USE `tim2`;
INSERT INTO `tim2`.`korisnici` (`idKorisnika`, `username`, `password_hash`, `email`) VALUES (1, 'admin', '098f6bcd4621d373cade4e832627b4f6', 'admin@posao.ba');
INSERT INTO `tim2`.`korisnici` (`idKorisnika`, `username`, `password_hash`, `email`) VALUES (2, 'firma1', '098f6bcd4621d373cade4e832627b4f6', 'firma1@firma1.com');
INSERT INTO `tim2`.`korisnici` (`idKorisnika`, `username`, `password_hash`, `email`) VALUES (3, 'firma2', '098f6bcd4621d373cade4e832627b4f6', 'forma2@firma2.com');
INSERT INTO `tim2`.`korisnici` (`idKorisnika`, `username`, `password_hash`, `email`) VALUES (4, 'korisnik1', '098f6bcd4621d373cade4e832627b4f6', 'korisnik1@domena.com');
INSERT INTO `tim2`.`korisnici` (`idKorisnika`, `username`, `password_hash`, `email`) VALUES (5, 'korisnik2', '098f6bcd4621d373cade4e832627b4f6', 'korisnik2@domena.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `tim2`.`nezaposleni`
-- -----------------------------------------------------
START TRANSACTION;
USE `tim2`;
INSERT INTO `tim2`.`nezaposleni` (`idKorisnika`, `ime`, `prezime`, `cv`, `privatanProfil`) VALUES (4, 'Prvi', 'Nezaposleni', 'CV Tekst 1', 0);
INSERT INTO `tim2`.`nezaposleni` (`idKorisnika`, `ime`, `prezime`, `cv`, `privatanProfil`) VALUES (5, 'Drugi', 'Nezaposleni', 'CV Tekst 2', 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `tim2`.`poslodavci`
-- -----------------------------------------------------
START TRANSACTION;
USE `tim2`;
INSERT INTO `tim2`.`poslodavci` (`idKorisnika`, `ime`, `prezime`, `nazivFirme`, `telefon`) VALUES (2, 'Vlasnik', 'Firme', 'Firma1', '123-456');
INSERT INTO `tim2`.`poslodavci` (`idKorisnika`, `ime`, `prezime`, `nazivFirme`, `telefon`) VALUES (3, 'Vlasnik 2', 'Firme', 'Firma2', '123-456');

COMMIT;


-- -----------------------------------------------------
-- Data for table `tim2`.`admin`
-- -----------------------------------------------------
START TRANSACTION;
USE `tim2`;
INSERT INTO `tim2`.`admin` (`idKorisnika`) VALUES (1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `tim2`.`kantoni`
-- -----------------------------------------------------
START TRANSACTION;
USE `tim2`;
INSERT INTO `tim2`.`kantoni` (`idKantona`, `naziv`) VALUES (1, 'Unsko-sanski kanton');
INSERT INTO `tim2`.`kantoni` (`idKantona`, `naziv`) VALUES (2, 'Posavski kanton');
INSERT INTO `tim2`.`kantoni` (`idKantona`, `naziv`) VALUES (3, 'Tuzlanski kanton');
INSERT INTO `tim2`.`kantoni` (`idKantona`, `naziv`) VALUES (4, 'Zeničko-dobojski kanton');
INSERT INTO `tim2`.`kantoni` (`idKantona`, `naziv`) VALUES (5, 'Bosansko-podrinjski kanton');
INSERT INTO `tim2`.`kantoni` (`idKantona`, `naziv`) VALUES (6, 'Srednjobosanski kanton');
INSERT INTO `tim2`.`kantoni` (`idKantona`, `naziv`) VALUES (7, 'Hercegovačko-neretvanski kanton');
INSERT INTO `tim2`.`kantoni` (`idKantona`, `naziv`) VALUES (8, 'Zapadnohercegovački kanton');
INSERT INTO `tim2`.`kantoni` (`idKantona`, `naziv`) VALUES (9, 'Kanton Sarajevo');
INSERT INTO `tim2`.`kantoni` (`idKantona`, `naziv`) VALUES (10, 'Kanton 10');

COMMIT;


-- -----------------------------------------------------
-- Data for table `tim2`.`lokacije`
-- -----------------------------------------------------
START TRANSACTION;
USE `tim2`;
INSERT INTO `tim2`.`lokacije` (`idLokacije`, `idKantona`, `naziv`) VALUES (1, 9, 'Sarajevo');
INSERT INTO `tim2`.`lokacije` (`idLokacije`, `idKantona`, `naziv`) VALUES (2, 4, 'Zenica');

COMMIT;


-- -----------------------------------------------------
-- Data for table `tim2`.`kategorije`
-- -----------------------------------------------------
START TRANSACTION;
USE `tim2`;
INSERT INTO `tim2`.`kategorije` (`idKategorije`, `naziv`) VALUES (1, 'IT');
INSERT INTO `tim2`.`kategorije` (`idKategorije`, `naziv`) VALUES (2, 'Ekonomija');
INSERT INTO `tim2`.`kategorije` (`idKategorije`, `naziv`) VALUES (3, 'Uslužne djelatnosti');

COMMIT;


-- -----------------------------------------------------
-- Data for table `tim2`.`oglas`
-- -----------------------------------------------------
START TRANSACTION;
USE `tim2`;
INSERT INTO `tim2`.`oglas` (`idOglasa`, `idPoslodavca`, `idLokacije`, `idKategorije`, `datumObjave`, `datumIsteka`, `sakriven`, `zatvoren`, `uspjesan`, `prioritet`) VALUES (1, 2, 1, 1, '2017-05-05 00:00:00', '2017-07-01 23:59:59', 0, 0, 0, 1);
INSERT INTO `tim2`.`oglas` (`idOglasa`, `idPoslodavca`, `idLokacije`, `idKategorije`, `datumObjave`, `datumIsteka`, `sakriven`, `zatvoren`, `uspjesan`, `prioritet`) VALUES (2, 2, 2, 2, '2017-05-10 00:00:00', '2017-06-01 23:59:59', 0, 0, 0, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `tim2`.`template`
-- -----------------------------------------------------
START TRANSACTION;
USE `tim2`;
INSERT INTO `tim2`.`template` (`idTemplate`, `naziv`) VALUES (1, 'IT Posao');
INSERT INTO `tim2`.`template` (`idTemplate`, `naziv`) VALUES (2, 'Trgovac');

COMMIT;


-- -----------------------------------------------------
-- Data for table `tim2`.`sakrivenipodaci`
-- -----------------------------------------------------
START TRANSACTION;
USE `tim2`;
INSERT INTO `tim2`.`sakrivenipodaci` (`idPoslodavca`, `privatnoIme`, `privatnoPrezime`, `privatnanTelefon`, `privatanEmail`) VALUES (2, 0, 0, 0, 0);
INSERT INTO `tim2`.`sakrivenipodaci` (`idPoslodavca`, `privatnoIme`, `privatnoPrezime`, `privatnanTelefon`, `privatanEmail`) VALUES (3, 1, 1, 0, 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `tim2`.`poljatemplatea`
-- -----------------------------------------------------
START TRANSACTION;
USE `tim2`;
INSERT INTO `tim2`.`poljatemplatea` (`idPolja`, `idTemplate`, `nazivPolja`) VALUES (1, 1, 'Naslov');
INSERT INTO `tim2`.`poljatemplatea` (`idPolja`, `idTemplate`, `nazivPolja`) VALUES (2, 1, 'Kratak opis');
INSERT INTO `tim2`.`poljatemplatea` (`idPolja`, `idTemplate`, `nazivPolja`) VALUES (3, 1, 'Opis');
INSERT INTO `tim2`.`poljatemplatea` (`idPolja`, `idTemplate`, `nazivPolja`) VALUES (4, 1, 'Vještine');
INSERT INTO `tim2`.`poljatemplatea` (`idPolja`, `idTemplate`, `nazivPolja`) VALUES (5, 1, 'Datum objave');
INSERT INTO `tim2`.`poljatemplatea` (`idPolja`, `idTemplate`, `nazivPolja`) VALUES (6, 1, 'Datum isteka');
INSERT INTO `tim2`.`poljatemplatea` (`idPolja`, `idTemplate`, `nazivPolja`) VALUES (7, 1, 'Lokacija');
INSERT INTO `tim2`.`poljatemplatea` (`idPolja`, `idTemplate`, `nazivPolja`) VALUES (8, 2, 'Naslov');
INSERT INTO `tim2`.`poljatemplatea` (`idPolja`, `idTemplate`, `nazivPolja`) VALUES (9, 2, 'Kratak opis');
INSERT INTO `tim2`.`poljatemplatea` (`idPolja`, `idTemplate`, `nazivPolja`) VALUES (10, 2, 'Opis');
INSERT INTO `tim2`.`poljatemplatea` (`idPolja`, `idTemplate`, `nazivPolja`) VALUES (11, 2, 'Stručna sprema');
INSERT INTO `tim2`.`poljatemplatea` (`idPolja`, `idTemplate`, `nazivPolja`) VALUES (12, 2, 'Datum objave');
INSERT INTO `tim2`.`poljatemplatea` (`idPolja`, `idTemplate`, `nazivPolja`) VALUES (13, 2, 'Datum isteka');
INSERT INTO `tim2`.`poljatemplatea` (`idPolja`, `idTemplate`, `nazivPolja`) VALUES (14, 2, 'Lokacija');
INSERT INTO `tim2`.`poljatemplatea` (`idPolja`, `idTemplate`, `nazivPolja`) VALUES (15, 2, 'Napomene');

COMMIT;


-- -----------------------------------------------------
-- Data for table `tim2`.`oglaspodaci`
-- -----------------------------------------------------
START TRANSACTION;
USE `tim2`;
INSERT INTO `tim2`.`oglaspodaci` (`idOglasa`, `idTemplate`, `idPolja`, `vrijednost`) VALUES (1, 1, 1, 'Junior developer');
INSERT INTO `tim2`.`oglaspodaci` (`idOglasa`, `idTemplate`, `idPolja`, `vrijednost`) VALUES (1, 1, 2, 'Tražimo junior developera');
INSERT INTO `tim2`.`oglaspodaci` (`idOglasa`, `idTemplate`, `idPolja`, `vrijednost`) VALUES (1, 1, 3, 'Junior developer sa dvogodišnjim iskustvom sa različitim tehnologijama, želja za učenjem, entuzijazam bla bla');
INSERT INTO `tim2`.`oglaspodaci` (`idOglasa`, `idTemplate`, `idPolja`, `vrijednost`) VALUES (1, 1, 4, 'Java, Spring, Ember, Angular js');
INSERT INTO `tim2`.`oglaspodaci` (`idOglasa`, `idTemplate`, `idPolja`, `vrijednost`) VALUES (1, 1, 5, '2017-05-05 00:00:00');
INSERT INTO `tim2`.`oglaspodaci` (`idOglasa`, `idTemplate`, `idPolja`, `vrijednost`) VALUES (1, 1, 6, '2017-07-01 23:59:59');
INSERT INTO `tim2`.`oglaspodaci` (`idOglasa`, `idTemplate`, `idPolja`, `vrijednost`) VALUES (1, 1, 7, 'Sarajevo');
INSERT INTO `tim2`.`oglaspodaci` (`idOglasa`, `idTemplate`, `idPolja`, `vrijednost`) VALUES (2, 2, 8, 'Trgovac');
INSERT INTO `tim2`.`oglaspodaci` (`idOglasa`, `idTemplate`, `idPolja`, `vrijednost`) VALUES (2, 2, 9, 'Kratak opis');
INSERT INTO `tim2`.`oglaspodaci` (`idOglasa`, `idTemplate`, `idPolja`, `vrijednost`) VALUES (2, 2, 10, 'Opis posla ....');
INSERT INTO `tim2`.`oglaspodaci` (`idOglasa`, `idTemplate`, `idPolja`, `vrijednost`) VALUES (2, 2, 11, 'SSS');
INSERT INTO `tim2`.`oglaspodaci` (`idOglasa`, `idTemplate`, `idPolja`, `vrijednost`) VALUES (2, 2, 12, '2017-05-10 00:00:00');
INSERT INTO `tim2`.`oglaspodaci` (`idOglasa`, `idTemplate`, `idPolja`, `vrijednost`) VALUES (2, 2, 13, '');
INSERT INTO `tim2`.`oglaspodaci` (`idOglasa`, `idTemplate`, `idPolja`, `vrijednost`) VALUES (2, 2, 14, 'Zenica');
INSERT INTO `tim2`.`oglaspodaci` (`idOglasa`, `idTemplate`, `idPolja`, `vrijednost`) VALUES (2, 2, 15, 'Napomena');

COMMIT;

