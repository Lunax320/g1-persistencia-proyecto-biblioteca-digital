package co.edu.javaeriana.biblioteca.model;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "estado_usuario_catalogo")
public class EstadoUsuarioCatalogo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_estado_usuario", nullable = false)
    private Integer idEstadoUsuario;

    @Column(name = "nombre", length = 50, nullable = false, unique = true)
    private String nombre;
}
