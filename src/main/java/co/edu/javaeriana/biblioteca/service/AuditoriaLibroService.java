package co.edu.javaeriana.biblioteca.service;

import co.edu.javaeriana.biblioteca.model.AuditoriaLibro;
import co.edu.javaeriana.biblioteca.repository.AuditoriaLibroRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class AuditoriaLibroService {

    private final AuditoriaLibroRepository repository;

    @Autowired
    public AuditoriaLibroService(AuditoriaLibroRepository repository) {
        this.repository = repository;
    }

    public List<AuditoriaLibro> obtenerTodos() {
        return repository.findAll();
    }

    public Optional<AuditoriaLibro> buscarPorId(Integer id) {
        return repository.findById(id);
    }

    public AuditoriaLibro guardar(AuditoriaLibro auditoriaLibro) {
        return repository.save(auditoriaLibro);
    }

    public AuditoriaLibro actualizar(Integer id, AuditoriaLibro auditoriaLibro) {
        AuditoriaLibro existente = repository.findById(id).orElse(null);
        if (existente != null) {
            existente.setLibro(auditoriaLibro.getLibro());
            existente.setUsuarioAdmin(auditoriaLibro.getUsuarioAdmin());
            existente.setFechaEvento(auditoriaLibro.getFechaEvento());
            existente.setDescripcionCambio(auditoriaLibro.getDescripcionCambio());
            return repository.save(existente);
        }
        return null;
    }

    public void eliminar(Integer id) {
        repository.deleteById(id);
    }
}
