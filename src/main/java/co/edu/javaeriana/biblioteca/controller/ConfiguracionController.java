package co.edu.javaeriana.biblioteca.controller;

import co.edu.javaeriana.biblioteca.model.Configuracion;
import co.edu.javaeriana.biblioteca.service.ConfiguracionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/configuracion")
public class ConfiguracionController {

    private final ConfiguracionService service;

    @Autowired
    public ConfiguracionController(ConfiguracionService service) {
        this.service = service;
    }

    @GetMapping
    public List<Configuracion> obtenerTodos() {
        return service.obtenerTodos();
    }

    @GetMapping("/{clave}")
    public ResponseEntity<Configuracion> obtenerPorClave(@PathVariable String clave) {
        return service.obtenerPorClave(clave)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Configuracion> crear(@RequestBody Configuracion configuracion) {
        return ResponseEntity.ok(service.guardar(configuracion));
    }

    @PutMapping("/{clave}")
    public ResponseEntity<Configuracion> actualizar(@PathVariable String clave, @RequestBody Configuracion configuracion) {
        Configuracion actualizado = service.actualizar(clave, configuracion);
        return (actualizado != null)
                ? ResponseEntity.ok(actualizado)
                : ResponseEntity.notFound().build();
    }

    @DeleteMapping("/{clave}")
    public ResponseEntity<Void> eliminar(@PathVariable String clave) {
        service.eliminar(clave);
        return ResponseEntity.noContent().build();
    }
}
