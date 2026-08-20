package co.edu.uniremington.gabrieladumar.Mantenimiento.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Cliente;
import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Perfil;
import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Usuario;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.ClienteRepository;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.PerfilRepository;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.UsuarioRepository;

@Service
public class ClienteService {

    @Autowired
    private ClienteRepository clienteRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private PerfilRepository perfilRepository;


    // =========================================================
    // OBTENER TODOS LOS CLIENTES
    // =========================================================

    public List<Cliente> obtenerTodosClientes() {
        return clienteRepository.findAll();
    }


    // =========================================================
    // BUSCAR CLIENTE POR CORREO
    // =========================================================

    public Cliente buscarPorCorreo(String correo) {
        return clienteRepository.findByCorreoCli(correo)
                .orElse(null);
    }


    // =========================================================
    // GUARDAR CLIENTE Y CREAR USUARIO AUTOMÁTICAMENTE
    // =========================================================

    @Transactional
    public Cliente guardarCliente(Cliente cliente) {

        // -----------------------------------------------------
        // 1. VALIDAR CONTRASEÑA
        // -----------------------------------------------------

        if (cliente.getPassword() == null
                || cliente.getPassword().isBlank()) {

            throw new RuntimeException(
                    "La contraseña es obligatoria");
        }


        // -----------------------------------------------------
        // 2. VERIFICAR QUE EL CORREO NO ESTÉ REPETIDO
        // -----------------------------------------------------

        if (usuarioRepository
                .findByCorreoUsu(cliente.getCorreoCli())
                .isPresent()) {

            throw new RuntimeException(
                    "El correo ya está registrado");
        }


        // -----------------------------------------------------
        // 3. GUARDAR EL CLIENTE
        // -----------------------------------------------------

        Cliente clienteGuardado =
                clienteRepository.save(cliente);


        // -----------------------------------------------------
        // 4. CREAR EL USUARIO
        // -----------------------------------------------------

        Usuario usuario = new Usuario();


        // -----------------------------------------------------
        // 5. COPIAR DATOS DEL CLIENTE
        // -----------------------------------------------------

        usuario.setNomUsu(
                clienteGuardado.getNomCli());

        usuario.setApeUsu(
                clienteGuardado.getApeCli());

        usuario.setCorreoUsu(
                clienteGuardado.getCorreoCli());


        // -----------------------------------------------------
        // 6. USAR LA CONTRASEÑA QUE ESCRIBIÓ EL CLIENTE
        // -----------------------------------------------------

        usuario.setContUsu(
                cliente.getPassword());


        // -----------------------------------------------------
        // 7. BUSCAR PERFIL CLIENTE
        // ID 1 = CLIENTE
        // -----------------------------------------------------

        Perfil perfilCliente =
                perfilRepository.findById(1)
                        .orElseThrow(() ->
                                new RuntimeException(
                                        "El perfil de Cliente no existe"
                                )
                        );

        usuario.setPerfil(perfilCliente);


        // -----------------------------------------------------
        // 8. RELACIONAR USUARIO CON EL CLIENTE
        // -----------------------------------------------------

        usuario.setCliente(clienteGuardado);


        // -----------------------------------------------------
        // 9. GUARDAR USUARIO
        // -----------------------------------------------------

        usuarioRepository.save(usuario);


        // -----------------------------------------------------
        // 10. DEVOLVER CLIENTE
        // -----------------------------------------------------

        return clienteGuardado;
    }
}