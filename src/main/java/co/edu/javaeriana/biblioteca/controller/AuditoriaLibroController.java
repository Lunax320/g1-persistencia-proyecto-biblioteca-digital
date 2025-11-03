package co.edu.javaeriana.biblioteca.controller;

import co.edu.javaeriana.biblioteca.model.AuditoriaLibro;
import co.edu.javaeriana.biblioteca.service.AuditoriaLibroService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/auditoria-libro")
public class AuditoriaLibroController {

    private final AuditoriaLibroService service;

    @Autowired
    public AuditoriaLibroController(AuditoriaLibroService service) {
        this.service = service;
    }

    @GetMapping
    public List<AuditoriaLibro> obtenerTodos() {
        return service.obtenerTodos();
    }

    @GetMapping("/{id}")
    public ResponseEntity<AuditoriaLibro> buscarPorId(@PathVariable Integer id) {
        return service.buscarPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<AuditoriaLibro> crear(@RequestBody AuditoriaLibro auditoriaLibro) {
        return ResponseEntity.ok(service.guardar(auditoriaLibro));
    }

    @PutMapping("/{id}")
    public ResponseEntity<AuditoriaLibro> actualizar(@PathVariable Integer id, @RequestBody AuditoriaLibro auditoriaLibro) {
        AuditoriaLibro actualizado = service.actualizar(id, auditoriaLibro);
        return (actualizado != null)
                ? ResponseEntity.ok(actualizado)
                : ResponseEntity.notFound().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Integer id) {
        service.eliminar(id);
        return ResponseEntity.noContent().build();
    }
}
