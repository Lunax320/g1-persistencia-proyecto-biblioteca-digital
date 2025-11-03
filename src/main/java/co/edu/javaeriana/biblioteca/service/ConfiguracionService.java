package co.edu.javaeriana.biblioteca.service;

import co.edu.javaeriana.biblioteca.model.Configuracion;
import co.edu.javaeriana.biblioteca.repository.ConfiguracionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ConfiguracionService {

    private final ConfiguracionRepository repository;

    @Autowired
    public ConfiguracionService(ConfiguracionRepository repository) {
        this.repository = repository;
    }

    public List<Configuracion> obtenerTodos() {
        return repository.findAll();
    }

    public Optional<Configuracion> obtenerPorClave(String clave) {
        return repository.findById(clave);
    }

    public Configuracion guardar(Configuracion configuracion) {
        return repository.save(configuracion);
    }

    public Configuracion actualizar(String clave, Configuracion configuracion) {
        Optional<Configuracion> existenteOpt = repository.findById(clave);
        if (existenteOpt.isPresent()) {
            Configuracion existente = existenteOpt.get();
            existente.setValor(configuracion.getValor());
            return repository.save(existente);
        }
        return null;
    }

    public void eliminar(String clave) {
        repository.deleteById(clave);
    }
}
