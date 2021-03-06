package ba.posao.services;

import java.util.Date;

import org.joda.time.DateTime;
import org.joda.time.LocalDate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import ba.posao.models.Nezaposleni;
import ba.posao.models.Oglas;
import ba.posao.models.OglasPrijave;
import ba.posao.models.Poruke;
import ba.posao.repositories.KorisnikRepository;
import ba.posao.repositories.NezaposleniRepository;
import ba.posao.repositories.OglasPrijaveRepository;
import ba.posao.repositories.OglasRepository;
import ba.posao.repositories.PorukeRepository;

@Service
public class OglasiPrijaveService {

	@Autowired
	OglasPrijaveRepository repository;
	
	@Autowired
	OglasRepository oglasRepository;
	
	@Autowired
	NezaposleniRepository nezaposleniRepository;
	
	@Autowired 
	KorisnikRepository korisnikRepository;
	
	@Autowired 
	PorukeRepository porukeRepository;
	
     public Boolean addPrijavu(int korisnik, int oglas) {
	    	
		 if (oglasRepository.findById(oglas)!=null &&
				 nezaposleniRepository.findById(korisnik)!=null){
			 
			 if (repository.findByPrijava(oglas, korisnik).size()==0)
			 {
				 Nezaposleni n = nezaposleniRepository.findById(korisnik);
				 
				 Oglas oglasObjekat = oglasRepository.findById(oglas);
				 Poruke poruka = new Poruke();
				 poruka.setPosiljalac(korisnikRepository.findByIdKorisnika(korisnik));
				 poruka.setPrimalac(korisnikRepository.findByIdKorisnika(oglasObjekat.getPoslodavac().getIdKorisnika()));
				 poruka.setVrijeme((Date) LocalDate.now().toDate());
				 poruka.setTekst("Korisnik "+n.getIme()+" "+n.getPrezime()+"se prijavio na oglas "+oglasObjekat.getNaziv());
				 poruka.setProcitano(false);
				 porukeRepository.save(poruka);
				 OglasPrijave prijava = new OglasPrijave();
				 prijava.setOglas(oglasRepository.findById(oglas));
				 prijava.setNezaposleni(nezaposleniRepository.findById(korisnik));
				 prijava.setVrijemePrijave((Date) LocalDate.now().toDate());
				 repository.save(prijava);
				 return true;
			 }
			 return false;
		 }
		 else 
	    	return false;
		}
     
     public int getCount()  {
    	 return repository.getCount();
     }
     
     public ResponseEntity imaPrijava(int korisnik, int oglas)  {
    	 
    	 if (nezaposleniRepository.findById(korisnik)==null)
    		 return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Ne postoji korisnik sa traženim id");
    	 else if (oglasRepository.findById(oglas)==null)
    		 return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Ne postoji oglas sa traženim id");
    	 else return ResponseEntity.status(HttpStatus.OK).body(repository.findByPrijava(oglas, korisnik).size()!=0);
     }

     
}
