package co.edu.javaeriana.biblioteca.service;

import co.edu.javaeriana.biblioteca.model.UsuarioRespuesta;
import co.edu.javaeriana.biblioteca.repository.UsuarioRespuestaRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UsuarioRespuestaService {

    private final UsuarioRespuestaRepository usuarioRespuestaRepository;

    public UsuarioRespuestaService(UsuarioRespuestaRepository usuarioRespuestaRepository) {
        this.usuarioRespuestaRepository = usuarioRespuestaRepository;
    }

    public List<UsuarioRespuesta> obtenerRespuestas() {
        return usuarioRespuestaRepository.findAll();
    }

    public Optional<UsuarioRespuesta> buscarPorId(Integer id) {
        return usuarioRespuestaRepository.findById(id);
    }

    public UsuarioRespuesta guardarRespuesta(UsuarioRespuesta respuesta) {
        return usuarioRespuestaRepository.save(respuesta);
    }

    public UsuarioRespuesta actualizarRespuesta(Integer id, UsuarioRespuesta nuevaRespuesta) {
        UsuarioRespuesta existente = usuarioRespuestaRepository.findById(id).orElse(null);
        if (existente != null) {
            existente.setUsuario(nuevaRespuesta.getUsuario());
            existente.setPregunta(nuevaRespuesta.getPregunta());
            existente.setRespuesta(nuevaRespuesta.getRespuesta());
            return usuarioRespuestaRepository.save(existente);
        }
        return null;
    }

    public void eliminarRespuesta(Integer id) {
        usuarioRespuestaRepository.deleteById(id);
    }
}
