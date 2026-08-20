package co.edu.uniremington.gabrieladumar.Mantenimiento.services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Cliente;
import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Usuario;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.ClienteRepository;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.UsuarioRepository;

@Service
public class LoginService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private ClienteRepository clienteRepository;


    // =========================================================
    // VALIDAR USUARIO
    // =========================================================

    public Usuario validarUsuario(String correo, String password) {

        Optional<Usuario> usuarioOpt =
                usuarioRepository.findByCorreoUsu(correo);

        // Si no existe el usuario
        if (usuarioOpt.isEmpty()) {
            return null;
        }

        Usuario usuario = usuarioOpt.get();


        // -----------------------------------------------------
        // VERIFICAR CONTRASEÑA
        // -----------------------------------------------------

        if (!usuario.getContUsu().equals(password)) {
            return null;
        }


        // -----------------------------------------------------
        // BUSCAR CLIENTE ASOCIADO
        // -----------------------------------------------------

        Optional<Cliente> clienteOpt =
                clienteRepository.findByCorreoCli(correo);

        if (clienteOpt.isPresent()) {

            Cliente cliente = clienteOpt.get();

            // Relacionar el usuario con el cliente
            usuario.setCliente(cliente);

        } else {

            // No existe un cliente asociado
            usuario.setCliente(null);
        }


        return usuario;
    }


    // =========================================================
    // REGISTRAR USUARIO
    // =========================================================

    public void registrarUsuario(
            String nombre,
            String apellido,
            String correo,
            String password) {

        Usuario usuario = new Usuario();

        usuario.setNomUsu(nombre);
        usuario.setApeUsu(apellido);
        usuario.setCorreoUsu(correo);
        usuario.setContUsu(password);

        usuarioRepository.save(usuario);
    }
}