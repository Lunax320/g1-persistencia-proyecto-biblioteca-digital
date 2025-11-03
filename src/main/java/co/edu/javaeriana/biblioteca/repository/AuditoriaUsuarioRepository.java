package co.edu.javaeriana.biblioteca.repository;

import co.edu.javaeriana.biblioteca.model.AuditoriaUsuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AuditoriaUsuarioRepository extends JpaRepository<AuditoriaUsuario, Integer> {


}
