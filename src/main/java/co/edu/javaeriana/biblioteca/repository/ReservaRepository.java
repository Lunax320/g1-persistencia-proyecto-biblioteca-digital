package co.edu.javaeriana.biblioteca.repository;

import co.edu.javaeriana.biblioteca.model.Reserva;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ReservaRepository extends JpaRepository<Reserva, Integer> {

    //Spring Boot maneja las operaciones CRUD
}
