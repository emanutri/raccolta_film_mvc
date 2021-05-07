package it.prova.raccoltafilmspringmvc.repository.regista;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import it.prova.raccoltafilmspringmvc.model.Regista;

public interface RegistaRepository extends CrudRepository<Regista, Long>, CustomRegistaRepository {
	List<Regista> findByCognomeIgnoreCaseContainingOrNomeIgnoreCaseContainingOrderByNomeAsc(String cognome,
			String nome);

	@Query("from Regista s join fetch s.films where s.id = ?1")
	Regista findSingleRegistaEager(Long id);
}
