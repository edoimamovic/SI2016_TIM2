package ba.posao.models;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;



@Entity
@Table(name="korisnici")
public class Korisnik implements Serializable {
	private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name="idkorisnika")
    private Integer idKorisnika;
    
    private String username;
    
    @Column(name="password_hash")
    private String password;
    private String email;
    
    //@OneToOne(cascade = CascadeType.ALL)
    //@JoinColumn(name = "idkorisnika")
    @OneToOne(fetch = FetchType.LAZY, mappedBy = "korisnici", cascade = CascadeType.ALL)
    private Nezaposleni nezaposleni;
    
    //@OneToOne(cascade = CascadeType.ALL)
    //@JoinColumn(name = "idkorisnika")
    @OneToOne(fetch = FetchType.LAZY, mappedBy = "korisnici", cascade = CascadeType.ALL)
    private Admin admin;
    
    //@OneToOne(cascade = CascadeType.ALL)
    //@JoinColumn(name = "idkorisnika")
    @OneToOne(fetch = FetchType.LAZY, mappedBy = "korisnici", cascade = CascadeType.ALL)
    private Poslodavci poslodavac;
   
	public Korisnik() {
    	
    }
    
	public void setIdKorisnika(Integer idKorisnika) {
		this.idKorisnika = idKorisnika;
	}

	
	public Nezaposleni getNezaposleni() {
		return nezaposleni;
	}
	
	public void setNezaposleni(Nezaposleni nezaposleni) {
		this.nezaposleni = nezaposleni;
	}
    
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	public Integer getIdKorisnika() {
		return idKorisnika;
	}

//	public void setNezaposleni(Nezaposleni nezaposleni) {
//		this.nezaposleni = nezaposleni;
//	}

	public Admin getAdmin() {
		return admin;
	}

//	public void setAdmin(Admin admin) {
//		this.admin = admin;
//	}

	public Poslodavci getPoslodavac() {
		return poslodavac;
	}

//	public void setPoslodavac(Poslodavci poslodavac) {
//		this.poslodavac = poslodavac;
//	}
	
	@Override
    public String toString() {
        return String.format("Korisnik[id=%d, username='%s', email='%s']", idKorisnika, username, email);
    }
	
	
}
