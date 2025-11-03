package co.edu.javaeriana.biblioteca.repository;

import co.edu.javaeriana.biblioteca.model.AuditoriaLibro;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AuditoriaLibroRepository extends JpaRepository<AuditoriaLibro, Integer> {
}
