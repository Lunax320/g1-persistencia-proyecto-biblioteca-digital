package co.edu.javaeriana.biblioteca.model;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "tipo_usuario_catalogo")
public class TipoUsuarioCatalogo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_tipo_usuario", nullable = false)
    private Integer idTipoUsuario;

    @Column(name = "nombre", length = 50, nullable = false, unique = true)
    private String nombre;
}
