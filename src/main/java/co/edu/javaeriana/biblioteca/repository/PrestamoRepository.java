package co.edu.javaeriana.biblioteca.repository;

import co.edu.javaeriana.biblioteca.model.Prestamo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PrestamoRepository extends JpaRepository<Prestamo, Integer> {

    //Spring Boot maneja las operaciones CRUD
}
