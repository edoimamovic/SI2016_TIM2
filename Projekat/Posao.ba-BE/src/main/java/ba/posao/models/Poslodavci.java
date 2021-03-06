package ba.posao.models;

import java.io.Serializable;


import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="poslodavci")
public class Poslodavci implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(generator="SharedPrimaryKeyGenerator")
	@GenericGenerator(name="SharedPrimaryKeyGenerator",strategy="foreign",parameters =  @Parameter(name="property", value="korisnici"))
	@Column(name = "idkorisnika", unique = true, nullable = false)
	private Integer idKorisnika;
	
	@PrimaryKeyJoinColumn
	@JsonIgnore
    @OneToOne
	private Korisnik korisnici;

	 public Korisnik getKorisnici() {
		  	return korisnici;
		 }
		    
		 public void setKorisnici(Korisnik korisnici) {
			 this.korisnici = korisnici;
		 }
	
	 
	private String ime;
	private String prezime;
	
	@Column(name="nazivfirme")
	private String nazivFirme;
	private String telefon;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idkorisnika")
    private SakriveniPodaci sakriveniPodaci;

	public SakriveniPodaci getSakriveniPodaci() {
		return sakriveniPodaci;
	}


	public void setSakriveniPodaci(SakriveniPodaci sakriveniPodaci) {
		this.sakriveniPodaci = sakriveniPodaci;
	}

	public Integer getIdKorisnika() {
		return idKorisnika;
	}

	public void setIdKorisnika(Integer idKorisnika) {
		this.idKorisnika = idKorisnika;
	}


	public String getIme() {
		return ime;
	}
	
	public void setIme(String ime) {
		this.ime = ime;
	}
	
	public String getPrezime() {
		return prezime;
	}
	
	public void setPrezime(String prezime) {
		this.prezime = prezime;
	}
	
	public String getNazivFirme() {
		return nazivFirme;
	}
	
	public void setNazivFirme(String nazivFirme) {
		this.nazivFirme = nazivFirme;
	}
	
	public String getTelefon() {
		return telefon;
	}
	
	public void setTelefon(String telefon) {
		this.telefon = telefon;
	}
	
}
