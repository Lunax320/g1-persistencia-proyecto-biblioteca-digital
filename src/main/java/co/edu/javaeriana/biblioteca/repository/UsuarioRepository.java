package co.edu.javaeriana.biblioteca.repository;

import co.edu.javaeriana.biblioteca.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {

    //se pueden agregar métodos personalizados
    //esto le da a Spring loos métodos básicos findAll(),FindByID(), Save()


    //Buscar por username
    Optional<Usuario> findByUsername(String username);

    //buscar por email
    Optional<Usuario> findByEmail(String email);
}
