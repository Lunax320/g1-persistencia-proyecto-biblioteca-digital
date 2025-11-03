package co.edu.javaeriana.biblioteca.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDate;  // Mejor usar LocalDate para año de publicación si solo es fecha

@Data
@Entity
@Table(name = "libro")
public class Libro {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "id_libro")
  private Integer idLibro;

  @Column(name = "isbn", length = 13, nullable = false, unique = true)
  private String isbn;

  @Column(name = "titulo", length = 60, nullable = false)
  private String titulo;

  // Cambiar a relación con Autor (en vez de String autor)
  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "id_autor", nullable = false)
  private Autor autor;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "id_categoria", nullable = false)
  private Categoria categoria;

  @Column(name = "editorial", length = 60)
  private String editorial;

  @Column(name = "ano_publicacion")
  private LocalDate anoPublicacion;

  @Column(name = "descripcion", columnDefinition = "TEXT")
  private String descripcion;

  @Column(name = "portada_url", length = 512)
  private String portadaUrl;

  @Column(name = "cantidad_total", nullable = false)
  private Integer cantidadTotal;

  @Column(name = "cantidad_disponible", nullable = false)
  private Integer cantidadDisponible;
}
