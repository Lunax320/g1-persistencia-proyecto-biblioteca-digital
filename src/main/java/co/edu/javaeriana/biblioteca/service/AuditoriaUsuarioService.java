package co.edu.javaeriana.biblioteca.service;

import co.edu.javaeriana.biblioteca.model.AuditoriaUsuario;
import co.edu.javaeriana.biblioteca.repository.AuditoriaUsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class AuditoriaUsuarioService {

    private final AuditoriaUsuarioRepository auditoriaRepository;

    @Autowired
    public AuditoriaUsuarioService(AuditoriaUsuarioRepository auditoriaRepository) {
        this.auditoriaRepository = auditoriaRepository;
    }

    public List<AuditoriaUsuario> obtenerAuditorias() {
        return auditoriaRepository.findAll();
    }

    public Optional<AuditoriaUsuario> buscarPorId(Integer id) {
        return auditoriaRepository.findById(id);
    }

    public AuditoriaUsuario guardarAuditoria(AuditoriaUsuario auditoria) {
        return auditoriaRepository.save(auditoria);
    }

    public AuditoriaUsuario actualizarAuditoria(Integer id, AuditoriaUsuario auditoria) {
        AuditoriaUsuario existente = auditoriaRepository.findById(id).orElse(null);
        if (existente != null) {
            existente.setUsuarioAfectado(auditoria.getUsuarioAfectado());
            existente.setUsuarioAdmin(auditoria.getUsuarioAdmin());
            existente.setFechaEvento(auditoria.getFechaEvento());
            existente.setTipoAccion(auditoria.getTipoAccion());
            existente.setDescripcion(auditoria.getDescripcion());
            return auditoriaRepository.save(existente);
        }
        return null;
    }

    public void eliminarAuditoria(Integer id) {
        auditoriaRepository.deleteById(id);
    }
}
