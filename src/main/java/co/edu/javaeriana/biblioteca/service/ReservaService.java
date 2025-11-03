package co.edu.javaeriana.biblioteca.service;

import co.edu.javaeriana.biblioteca.model.Reserva;
import co.edu.javaeriana.biblioteca.repository.ReservaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ReservaService {

    private final ReservaRepository reservaRepository;

    @Autowired
    public ReservaService(ReservaRepository reservaRepository) {
        this.reservaRepository = reservaRepository;
    }

    public List<Reserva> obtenerReservas() {
        return reservaRepository.findAll();
    }

    public Optional<Reserva> buscarPorId(Integer id) {
        return reservaRepository.findById(id);
    }

    public Reserva guardarReserva(Reserva reserva) {
        return reservaRepository.save(reserva);
    }

    public Reserva actualizarReserva(Integer id, Reserva reserva) {
        Reserva existente = reservaRepository.findById(id).orElse(null);
        if (existente != null) {
            existente.setUsuario(reserva.getUsuario());
            existente.setLibro(reserva.getLibro());
            existente.setEstadoReserva(reserva.getEstadoReserva());
            existente.setFechaReserva(reserva.getFechaReserva());
            return reservaRepository.save(existente);
        }
        return null;
    }

    public void eliminarReserva(Integer id) {
        reservaRepository.deleteById(id);
    }


}
