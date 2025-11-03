package co.edu.javaeriana.biblioteca.service;

import co.edu.javaeriana.biblioteca.model.Prestamo;
import co.edu.javaeriana.biblioteca.repository.PrestamoRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PrestamoService {

    private final PrestamoRepository prestamoRepository;

    public PrestamoService(PrestamoRepository prestamoRepository) {
        this.prestamoRepository = prestamoRepository;
    }

    /** USADO POR PrestamoController: GET /api/prestamo/{id} */
    public Prestamo buscarPorId(Integer id) {
        return prestamoRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Préstamo no encontrado: " + id));
    }

    /** USADO POR PrestamoController: GET /api/prestamo */
    public List<Prestamo> obtenerPrestamos() {
        return prestamoRepository.findAll();
    }

    /** USADO POR PrestamoController: POST /api/prestamo */
    @Transactional
    public Prestamo guardarPrestamo(Prestamo prestamo) {
        return prestamoRepository.save(prestamo);
    }

    /** USADO POR PrestamoController: PUT /api/prestamo/{id} */
    @Transactional
    public Prestamo actualizarPrestamo(Integer id, Prestamo cambios) {
        // Opción simple y segura: setear el id y guardar la entidad que vino en el body
        cambios.setIdPrestamo(id);
        return prestamoRepository.save(cambios);

        // Si prefieres merge campo a campo:
        // Prestamo existente = prestamoRepository.findById(id)
        //     .orElseThrow(() -> new IllegalArgumentException("Préstamo no encontrado: " + id));
        // existente.setUsuario(cambios.getUsuario());
        // existente.setLibro(cambios.getLibro());
        // existente.setFechaInicio(cambios.getFechaInicio());
        // existente.setFechaVencimiento(cambios.getFechaVencimiento());
        // existente.setFechaDevolucion(cambios.getFechaDevolucion());
        // ... (otros campos que tenga tu entidad)
        // return prestamoRepository.save(existente);
    }

    /** USADO POR PrestamoController: DELETE /api/prestamo/{id} */
    @Transactional
    public void eliminarPrestamo(Integer id) {
        prestamoRepository.deleteById(id);
    }
}
