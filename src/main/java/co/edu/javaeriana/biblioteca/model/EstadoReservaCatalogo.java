package co.edu.javaeriana.biblioteca.model;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "estado_reserva_catalogo")
public class EstadoReservaCatalogo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_estado_reserva", nullable = false)
    private Integer idEstadoReserva;

    @Column(name = "nombre", nullable = false, unique = true, length = 50)
    private String nombre;
}
