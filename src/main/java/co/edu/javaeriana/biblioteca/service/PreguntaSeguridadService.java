package co.edu.javaeriana.biblioteca.service;

import co.edu.javaeriana.biblioteca.model.PreguntaSeguridad;
import co.edu.javaeriana.biblioteca.repository.PreguntaSeguridadRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PreguntaSeguridadService {

    private final PreguntaSeguridadRepository preguntaSeguridadRepository;

    @Autowired
    public PreguntaSeguridadService(PreguntaSeguridadRepository preguntaSeguridadRepository) {
        this.preguntaSeguridadRepository = preguntaSeguridadRepository;
    }

    public List<PreguntaSeguridad> obtenerPreguntas() {
        return preguntaSeguridadRepository.findAll();
    }

    public Optional<PreguntaSeguridad> buscarPorId(Integer id) {
        return preguntaSeguridadRepository.findById(id);
    }

    public PreguntaSeguridad guardarPregunta(PreguntaSeguridad pregunta) {
        return preguntaSeguridadRepository.save(pregunta);
    }

    public PreguntaSeguridad actualizarPregunta(Integer id, PreguntaSeguridad nuevaPregunta) {
        PreguntaSeguridad existente = preguntaSeguridadRepository.findById(id).orElse(null);
        if (existente != null) {
            existente.setTextoPregunta(nuevaPregunta.getTextoPregunta());
            return preguntaSeguridadRepository.save(existente);
        }
        return null;
    }

    public void eliminarPregunta(Integer id) {
        preguntaSeguridadRepository.deleteById(id);
    }
}
