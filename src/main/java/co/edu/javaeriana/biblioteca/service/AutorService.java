package co.edu.javaeriana.biblioteca.service;

import co.edu.javaeriana.biblioteca.model.Autor;
import co.edu.javaeriana.biblioteca.repository.AutorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class AutorService {

  private final AutorRepository autorRepository;

  @Autowired
  public AutorService(AutorRepository autorRepository) {
    this.autorRepository = autorRepository;
  }

  public List<Autor> traerTodos() {
    return autorRepository.findAll();
  }

  @Transactional
  public Autor crearAutor(Autor autor) {
    return autorRepository.save(autor);
  }

  public Autor actualizarAutor(Integer id, Autor autor) {
    Autor autorExistente = autorRepository.findById(id).orElse(null);
    if (autorExistente != null) {
      autorExistente.setNombre(autor.getNombre());
      autorExistente.setNacionalidad(autor.getNacionalidad());
      autorExistente.setFecNacimiento(autor.getFecNacimiento());
      return autorRepository.save(autorExistente);
    }
    return null;
  }

  public void eliminarAutor(Integer  id) {
    autorRepository.deleteById(id);
  }

}
