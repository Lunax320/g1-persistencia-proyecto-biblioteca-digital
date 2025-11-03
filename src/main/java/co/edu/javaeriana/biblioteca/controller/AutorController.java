package co.edu.javaeriana.biblioteca.controller;

import co.edu.javaeriana.biblioteca.model.Autor;
import co.edu.javaeriana.biblioteca.service.AutorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(path = "api/autor")
public class AutorController {

  private final AutorService autorService;

  @Autowired
  public AutorController(AutorService autorService) {
    this.autorService = autorService;
  }

  @GetMapping
  public List<Autor> traerTodos() {
    return autorService.traerTodos();
  }

  @PostMapping
  public ResponseEntity<Autor> crearAutor(@RequestBody Autor autor) {
    return ResponseEntity.ok(autorService.crearAutor(autor));
  }

  @PutMapping("/{id}")
  public ResponseEntity<Autor> actualizarAutor(@PathVariable Integer  id,@RequestBody Autor autor) {
    return ResponseEntity.ok(autorService.actualizarAutor(id, autor));
  }

  @DeleteMapping("/{id}")
  public ResponseEntity<String>eliminarAutor(@PathVariable Integer  id) {
    autorService.eliminarAutor(id);
    return ResponseEntity.ok("Autor eliminado");
  }

}
