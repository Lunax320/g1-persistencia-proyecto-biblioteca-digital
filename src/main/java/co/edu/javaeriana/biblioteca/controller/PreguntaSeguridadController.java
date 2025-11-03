package co.edu.javaeriana.biblioteca.controller;

import co.edu.javaeriana.biblioteca.model.PreguntaSeguridad;
import co.edu.javaeriana.biblioteca.service.PreguntaSeguridadService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/preguntas-seguridad")
public class PreguntaSeguridadController {

    private final PreguntaSeguridadService preguntaSeguridadService;

    public PreguntaSeguridadController(PreguntaSeguridadService preguntaSeguridadService) {
        this.preguntaSeguridadService = preguntaSeguridadService;
    }

    @GetMapping
    public List<PreguntaSeguridad> obtenerTodas() {
        return preguntaSeguridadService.obtenerPreguntas();
    }

    @GetMapping("/{id}")
    public ResponseEntity<PreguntaSeguridad> buscarPorId(@PathVariable Integer id) {
        return preguntaSeguridadService.buscarPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<PreguntaSeguridad> crearPregunta(@RequestBody PreguntaSeguridad pregunta) {
        return ResponseEntity.ok(preguntaSeguridadService.guardarPregunta(pregunta));
    }

    @PutMapping("/{id}")
    public ResponseEntity<PreguntaSeguridad> actualizarPregunta(@PathVariable Integer id, @RequestBody PreguntaSeguridad nuevaPregunta) {
        PreguntaSeguridad actualizada = preguntaSeguridadService.actualizarPregunta(id, nuevaPregunta);
        return (actualizada != null)
                ? ResponseEntity.ok(actualizada)
                : ResponseEntity.notFound().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarPregunta(@PathVariable Integer id) {
        preguntaSeguridadService.eliminarPregunta(id);
        return ResponseEntity.noContent().build();
    }
}
