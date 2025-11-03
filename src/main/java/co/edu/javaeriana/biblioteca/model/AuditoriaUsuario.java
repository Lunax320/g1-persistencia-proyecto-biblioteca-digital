package co.edu.javaeriana.biblioteca.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "auditoria_usuario")
public class AuditoriaUsuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_auditoria_usuario")
    private Integer idAuditoriaUsuario;

    @ManyToOne
    @JoinColumn(name = "id_usuario_afectado", nullable = false)
    private Usuario usuarioAfectado;

    @ManyToOne
    @JoinColumn(name = "id_usuario_admin", nullable = false)
    private Usuario usuarioAdmin;

    @Column(name = "fecha_evento", nullable = false)
    private LocalDateTime fechaEvento;

    @Column(name = "tipo_accion", nullable = false)
    private String tipoAccion;

    @Column(name = "descripcion")
    private String descripcion;
}
