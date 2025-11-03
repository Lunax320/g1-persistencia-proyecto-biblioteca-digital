package co.edu.javaeriana.biblioteca.model;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "configuracion")
public class Configuracion {

    @Id
    @Column(name = "clave", nullable = false, length = 50)
    private String clave;

    @Column(name = "valor", nullable = false, length = 100)
    private String valor;
}
