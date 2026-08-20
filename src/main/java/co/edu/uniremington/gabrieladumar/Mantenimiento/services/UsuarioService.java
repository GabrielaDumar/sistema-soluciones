package co.edu.uniremington.gabrieladumar.Mantenimiento.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Cliente;
import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Perfil;
import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Usuario;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.ClienteRepository;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.PerfilRepository;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.UsuarioRepository;

@Service
public class UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private PerfilRepository perfilRepository;

    @Autowired
    private ClienteRepository clienteRepository;


    // =========================================================
    // REGISTRAR USUARIO DESDE EL FORMULARIO
    // =========================================================

    public Usuario registrarUsuario(
            String nombre,
            String apellido,
            String correo,
            String password) {

        if (usuarioRepository.findByCorreoUsu(correo).isPresent()) {
            throw new RuntimeException(
                    "El correo ya está registrado");
        }

        Usuario nuevoUsuario = new Usuario();

        nuevoUsuario.setNomUsu(nombre);
        nuevoUsuario.setApeUsu(apellido);
        nuevoUsuario.setCorreoUsu(correo);
        nuevoUsuario.setContUsu(password);


        // -----------------------------------------------------
        // PERFIL CLIENTE = ID 1
        // -----------------------------------------------------

        Perfil perfilCliente = perfilRepository.findById(1)
                .orElseThrow(() ->
                        new RuntimeException(
                                "El perfil Cliente no existe"));

        nuevoUsuario.setPerfil(perfilCliente);


        return usuarioRepository.save(nuevoUsuario);
    }


    // =========================================================
    // VERIFICAR SI EXISTE UN CORREO
    // =========================================================

    public boolean correoExiste(String correo) {

        return usuarioRepository
                .findByCorreoUsu(correo)
                .isPresent();
    }


    // =========================================================
    // OBTENER USUARIO POR ID
    // =========================================================

    public Usuario obtenerUsuarioPorId(Integer id) {

        return usuarioRepository
                .findById(id)
                .orElse(null);
    }


    // =========================================================
    // ACTUALIZAR PERFIL DEL USUARIO
    // =========================================================

    public void actualizarPerfil(
            Integer id,
            String nombre,
            String apellido,
            String telefono,
            String correo,
            String password) {

        Usuario usuario =
                usuarioRepository.findById(id).orElse(null);

        if (usuario != null) {

            usuario.setNomUsu(nombre);
            usuario.setApeUsu(apellido);
            usuario.setCorreoUsu(correo);

            // Solo actualizar contraseña si se proporcionó
            if (password != null && !password.isEmpty()) {

                usuario.setContUsu(password);
            }

            usuarioRepository.save(usuario);
        }
    }


    // =========================================================
    // GUARDAR USUARIO DESDE POSTMAN
    // =========================================================

    public Usuario guardarUsuario(Usuario usuario) {

        // -----------------------------------------------------
        // VERIFICAR QUE EL CORREO NO ESTÉ REPETIDO
        // -----------------------------------------------------

        if (usuario.getCorreoUsu() != null
                && usuarioRepository
                        .findByCorreoUsu(usuario.getCorreoUsu())
                        .isPresent()) {

            throw new RuntimeException(
                    "El correo ya está registrado");
        }


        // -----------------------------------------------------
        // VERIFICAR QUE EL USUARIO TENGA UN PERFIL
        // -----------------------------------------------------

        if (usuario.getPerfil() == null
                || usuario.getPerfil().getIdPerfil() == null) {

            throw new RuntimeException(
                    "Debe seleccionar un perfil para el usuario");
        }


        // -----------------------------------------------------
        // OBTENER ID DEL PERFIL
        // -----------------------------------------------------

        Integer idPerfil =
                usuario.getPerfil().getIdPerfil();


        // -----------------------------------------------------
        // REGLA DE NEGOCIO:
        // SOLO PUEDE EXISTIR UN ADMINISTRADOR
        //
        // ID 2 = Administrador
        // -----------------------------------------------------

        if (idPerfil == 2
                && usuarioRepository
                        .existsByPerfil_IdPerfil(2)) {

            throw new RuntimeException(
                    "No se puede crear el usuario. "
                    + "Ya existe un Administrador en el sistema.");
        }


        // -----------------------------------------------------
        // OBTENER PERFIL COMPLETO
        // -----------------------------------------------------

        Perfil perfilCompleto =
                perfilRepository.findById(idPerfil)
                        .orElseThrow(() ->
                                new RuntimeException(
                                        "El perfil con ID "
                                        + idPerfil
                                        + " no existe"));

        usuario.setPerfil(perfilCompleto);


        // -----------------------------------------------------
        // SI VIENE UN CLIENTE, BUSCARLO Y RELACIONARLO
        // -----------------------------------------------------

        if (usuario.getCliente() != null
                && usuario.getCliente().getIdCliente() != null) {

            Integer idCliente =
                    usuario.getCliente().getIdCliente();

            Cliente cliente =
                    clienteRepository.findById(idCliente)
                            .orElseThrow(() ->
                                    new RuntimeException(
                                            "El cliente con ID "
                                            + idCliente
                                            + " no existe"));

            usuario.setCliente(cliente);
        }


        // -----------------------------------------------------
        // GUARDAR USUARIO
        // -----------------------------------------------------

        Usuario guardado =
                usuarioRepository.save(usuario);


        // -----------------------------------------------------
        // CARGAR NUEVAMENTE EL PERFIL
        // -----------------------------------------------------

        if (guardado.getPerfil() != null
                && guardado.getPerfil().getIdPerfil() != null) {

            Integer idPerfilGuardado =
                    guardado.getPerfil().getIdPerfil();

            Perfil perfilCompletoGuardado =
                    perfilRepository
                            .findById(idPerfilGuardado)
                            .orElse(null);

            guardado.setPerfil(
                    perfilCompletoGuardado);
        }


        return guardado;
    }


    // =========================================================
    // OBTENER TODOS LOS USUARIOS
    // =========================================================

    public List<Usuario> obtenerTodosUsuarios() {

        return usuarioRepository.findAll();
    }


    // =========================================================
    // COMPLETAR CLIENTE DEL USUARIO
    // =========================================================

    public Usuario completarIdCliente(Usuario usuario) {

        if (usuario == null) {
            return null;
        }

        if (usuario.getCorreoUsu() == null) {
            return usuario;
        }


        clienteRepository
                .findByCorreoCli(usuario.getCorreoUsu())
                .ifPresent(cliente ->
                        usuario.setCliente(cliente)
                );


        return usuario;
    }
}