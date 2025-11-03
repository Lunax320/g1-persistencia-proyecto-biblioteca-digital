package co.edu.javaeriana.biblioteca.service;

import co.edu.javaeriana.biblioteca.model.Usuario;
import co.edu.javaeriana.biblioteca.repository.UsuarioRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UsuarioService {

    private final UsuarioRepository usuarioRepository;

    public UsuarioService(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    /** USADO POR UsuarioController: GET /api/usuario */
    public List<Usuario> getUsuarios() {
        return usuarioRepository.findAll();
    }

    /** USADO POR UsuarioController: POST /api/usuario */
    @Transactional
    public Usuario guardarUsuario(Usuario u) {
        return usuarioRepository.save(u);
    }

    /** USADO POR UsuarioController: PUT /api/usuario/{id} */
    @Transactional
    public Usuario actualizarUsuario(Integer id, Usuario cambios) {
        // Opción simple: setear id y guardar
        cambios.setIdUsuario(id);
        return usuarioRepository.save(cambios);

        // Merge detallado (si prefieres):
        // Usuario existente = usuarioRepository.findById(id)
        //     .orElseThrow(() -> new IllegalArgumentException("Usuario no encontrado: " + id));
        // existente.setUsername(cambios.getUsername());
        // existente.setNombre(cambios.getNombre());
        // existente.setContrasena(cambios.getContrasena());
        // existente.setEmail(cambios.getEmail());
        // existente.setTipoUsuario(cambios.getTipoUsuario());
        // existente.setEstadoUsuario(cambios.getEstadoUsuario());
        // ... (otros campos)
        // return usuarioRepository.save(existente);
    }

    /** USADO POR UsuarioController: DELETE /api/usuario/{id} */
    @Transactional
    public void eliminarUsuario(Integer id) {
        usuarioRepository.deleteById(id);
    }
}
