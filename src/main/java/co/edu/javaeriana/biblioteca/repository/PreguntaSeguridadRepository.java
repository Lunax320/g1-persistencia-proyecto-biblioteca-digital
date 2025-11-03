package co.edu.javaeriana.biblioteca.repository;

import co.edu.javaeriana.biblioteca.model.PreguntaSeguridad;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PreguntaSeguridadRepository extends JpaRepository<PreguntaSeguridad, Integer> {


}
