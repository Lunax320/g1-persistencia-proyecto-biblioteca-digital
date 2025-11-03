package co.edu.javaeriana.biblioteca.model;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "pregunta_seguridad")
public class PreguntaSeguridad {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_pregunta", nullable = false)
    private Integer idPregunta;

    @Column(name = "texto_pregunta", nullable = false, unique = true, length = 255)
    private String textoPregunta;
}
