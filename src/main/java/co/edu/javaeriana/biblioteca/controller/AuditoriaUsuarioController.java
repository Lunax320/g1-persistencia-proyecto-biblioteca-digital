package co.edu.javaeriana.biblioteca.controller;

import co.edu.javaeriana.biblioteca.model.AuditoriaUsuario;
import co.edu.javaeriana.biblioteca.service.AuditoriaUsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/auditorias")
public class AuditoriaUsuarioController {

    private final AuditoriaUsuarioService auditoriaService;

    @Autowired
    public AuditoriaUsuarioController(AuditoriaUsuarioService auditoriaService) {
        this.auditoriaService = auditoriaService;
    }

    @GetMapping
    public List<AuditoriaUsuario> obtenerAuditorias() {
        return auditoriaService.obtenerAuditorias();
    }

    @GetMapping("/{id}")
    public ResponseEntity<AuditoriaUsuario> buscarPorId(@PathVariable Integer id) {
        return auditoriaService.buscarPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<AuditoriaUsuario> crearAuditoria(@RequestBody AuditoriaUsuario auditoria) {
        return ResponseEntity.ok(auditoriaService.guardarAuditoria(auditoria));
    }

    @PutMapping("/{id}")
    public ResponseEntity<AuditoriaUsuario> actualizarAuditoria(@PathVariable Integer id,
                                                                @RequestBody AuditoriaUsuario auditoria) {
        AuditoriaUsuario actualizado = auditoriaService.actualizarAuditoria(id, auditoria);
        return (actualizado != null)
                ? ResponseEntity.ok(actualizado)
                : ResponseEntity.notFound().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> eliminarAuditoria(@PathVariable Integer id) {
        auditoriaService.eliminarAuditoria(id);
        return ResponseEntity.ok("Auditoría eliminada exitosamente");
    }
}
