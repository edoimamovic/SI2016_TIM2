package ba.posao.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import ba.posao.models.Oglas;

@Repository
public interface OglasRepository extends PagingAndSortingRepository<Oglas, Integer> {
	@Query("select o from Oglas o where idOglasa=?")
	public Oglas findById(Integer id);
	
	public List<Oglas> findAllByPoslodavacIdKorisnika(Integer idPoslodavca);
	
	public List<Oglas> findAll();
	
	public List<Oglas> findAllByKategorijeNaziv(String naziv);
	
	@Query("SELECT o FROM Oglas o, OglasPodaci op WHERE o.idOglasa=op.id AND vrijednost LIKE %:vrijednost%")
	public List<Oglas> findAllByOglasPodaciVrijednost(@Param("vrijednost")String vrijednost);
	
	@Query("SELECT COUNT(*)  FROM OglasPrijave")
	public Integer brojUspjesnihPrijava();
	
	public List<Oglas> findAllByLokacijaNaziv(String lokacija);
	
}
