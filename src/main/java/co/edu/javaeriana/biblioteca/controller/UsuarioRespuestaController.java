package co.edu.javaeriana.biblioteca.controller;

import co.edu.javaeriana.biblioteca.model.UsuarioRespuesta;
import co.edu.javaeriana.biblioteca.service.UsuarioRespuestaService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/usuario_respuestas")
public class UsuarioRespuestaController {

    private final UsuarioRespuestaService usuarioRespuestaService;

    public UsuarioRespuestaController(UsuarioRespuestaService usuarioRespuestaService) {
        this.usuarioRespuestaService = usuarioRespuestaService;
    }

    @GetMapping
    public List<UsuarioRespuesta> obtenerRespuestas() {
        return usuarioRespuestaService.obtenerRespuestas();
    }

    @GetMapping("/{id}")
    public ResponseEntity<UsuarioRespuesta> buscarPorId(@PathVariable Integer id) {
        return usuarioRespuestaService.buscarPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<UsuarioRespuesta> crearRespuesta(@RequestBody UsuarioRespuesta respuesta) {
        return ResponseEntity.ok(usuarioRespuestaService.guardarRespuesta(respuesta));
    }

    @PutMapping("/{id}")
    public ResponseEntity<UsuarioRespuesta> actualizarRespuesta(@PathVariable Integer id,
                                                                @RequestBody UsuarioRespuesta respuesta) {
        UsuarioRespuesta actualizada = usuarioRespuestaService.actualizarRespuesta(id, respuesta);
        return (actualizada != null)
                ? ResponseEntity.ok(actualizada)
                : ResponseEntity.notFound().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarRespuesta(@PathVariable Integer id) {
        usuarioRespuestaService.eliminarRespuesta(id);
        return ResponseEntity.noContent().build();
    }
}
