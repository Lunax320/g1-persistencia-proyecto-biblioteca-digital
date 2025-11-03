package co.edu.javaeriana.biblioteca.service;

import co.edu.javaeriana.biblioteca.model.Libro;
import co.edu.javaeriana.biblioteca.repository.custom.BookRepository; // <-- el custom
import co.edu.javaeriana.biblioteca.repository.custom.criteria.SearchCriteria;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class LibroService {

  private final BookRepository customBookRepo;

  // Inyección por constructor (Spring lo resuelve porque BookRepositoryImpl tiene @Repository)
  public LibroService(BookRepository customBookRepo) {
    this.customBookRepo = customBookRepo;
  }

  public List<Libro> listarPaginado(int page, int limit) {
    return customBookRepo.findAll(page, limit);
  }

  public List<Libro> buscar(SearchCriteria c) {
    return customBookRepo.search(c);
  }

  @Transactional
  public Libro crear(Libro b) {
    return customBookRepo.save(b);
  }

  @Transactional
  public Libro actualizar(Libro b) {
    return customBookRepo.update(b);
  }

  @Transactional
  public void ajustarDisponibilidad(Integer idLibro, int delta) {
    customBookRepo.updateAvailability(idLibro, delta);
  }
}
