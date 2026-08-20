package co.edu.uniremington.gabrieladumar.Mantenimiento.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.edu.uniremington.gabrieladumar.Mantenimiento.model.EspecialidadTecnico;
import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Perfil;
import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Tecnico;
import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Usuario;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.EspecialidadTecnicoRepository;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.PerfilRepository;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.TecnicoRepository;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.UsuarioRepository;

@Service
public class TecnicoService {

    @Autowired
    private TecnicoRepository tecnicoRepository;

    @Autowired
    private EspecialidadTecnicoRepository especialidadRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private PerfilRepository perfilRepository;


    // =========================================================
    // OBTENER TODOS LOS TÉCNICOS
    // =========================================================

    public List<Tecnico> obtenerTodosTecnicos() {

        return tecnicoRepository.findAll();
    }


    // =========================================================
    // OBTENER TODAS LAS ESPECIALIDADES
    // =========================================================

    public List<EspecialidadTecnico> obtenerTodasEspecialidades() {

        return especialidadRepository.findAll();
    }


    // =========================================================
    // CREAR TÉCNICO + USUARIO
    // =========================================================

    public Tecnico registrarTecnico(
            String nombre,
            String apellido,
            String telefono,
            String correo,
            Integer idEspecialidad,
            String disponibilidad,
            String password) {


        // =====================================================
        // VALIDAR CORREO
        // =====================================================

        if (correo == null || correo.trim().isEmpty()) {

            throw new RuntimeException(
                    "El correo del técnico es obligatorio."
            );
        }


        // =====================================================
        // VALIDAR CONTRASEÑA
        // =====================================================

        if (password == null || password.trim().isEmpty()) {

            throw new RuntimeException(
                    "La contraseña del técnico es obligatoria."
            );
        }


        // =====================================================
        // VERIFICAR QUE EL CORREO NO EXISTA
        // =====================================================

        if (usuarioRepository
                .findByCorreoUsu(correo)
                .isPresent()) {

            throw new RuntimeException(
                    "El correo ya está registrado como usuario."
            );
        }


        if (tecnicoRepository
                .findByCorreoTec(correo)
                .isPresent()) {

            throw new RuntimeException(
                    "El correo ya está registrado como técnico."
            );
        }


        // =====================================================
        // CREAR TÉCNICO
        // =====================================================

        Tecnico tecnico = new Tecnico();

        tecnico.setNomTec(nombre);
        tecnico.setApeTec(apellido);
        tecnico.setTelTec(telefono);
        tecnico.setCorreoTec(correo);
        tecnico.setDispTec(disponibilidad);


        // =====================================================
        // ASIGNAR ESPECIALIDAD
        // =====================================================

        if (idEspecialidad != null) {

            EspecialidadTecnico especialidad =
                    especialidadRepository
                            .findById(idEspecialidad)
                            .orElseThrow(() ->
                                new RuntimeException(
                                    "La especialidad con ID "
                                    + idEspecialidad
                                    + " no existe."
                                )
                            );

            tecnico.setEspecialidad(especialidad);
        }


        // =====================================================
        // GUARDAR TÉCNICO
        // =====================================================

        Tecnico tecnicoGuardado =
                tecnicoRepository.save(tecnico);


        // =====================================================
        // BUSCAR PERFIL TÉCNICO
        // =====================================================

        /*
         * IMPORTANTE:
         * Aquí estamos usando ID 3 para Técnico.
         *
         * Si en tu tabla perfil el Técnico tiene otro ID,
         * solamente cambiamos este número.
         */

        Perfil perfilTecnico =
                perfilRepository
                        .findById(3)
                        .orElseThrow(() ->
                            new RuntimeException(
                                "El perfil Técnico no existe."
                            )
                        );


        // =====================================================
        // CREAR USUARIO AUTOMÁTICAMENTE
        // =====================================================

        Usuario usuario = new Usuario();

        usuario.setNomUsu(nombre);

        usuario.setApeUsu(apellido);

        usuario.setCorreoUsu(correo);

        // ESTA ES LA CONTRASEÑA QUE VIENE DE POSTMAN
        usuario.setContUsu(password);

        // PERFIL TÉCNICO
        usuario.setPerfil(perfilTecnico);

        // RELACIONAR USUARIO CON EL TÉCNICO
        usuario.setTecnico(tecnicoGuardado);


        // =====================================================
        // GUARDAR USUARIO
        // =====================================================

        usuarioRepository.save(usuario);


        // =====================================================
        // DEVOLVER TÉCNICO
        // =====================================================

        return tecnicoGuardado;
    }


    // =========================================================
    // GUARDAR TÉCNICO
    // =========================================================

    /*
     * Este método lo dejamos porque tu proyecto ya lo utiliza
     * desde otras partes.
     *
     * Para crear un técnico nuevo desde Postman se utiliza
     * registrarTecnico(), que también crea el usuario.
     */

    public Tecnico guardarTecnico(Tecnico tecnico) {

        return tecnicoRepository.save(tecnico);
    }


    // =========================================================
    // BUSCAR POR CORREO
    // =========================================================

    public Tecnico buscarPorCorreo(String correo) {

        return tecnicoRepository
                .findByCorreoTec(correo)
                .orElse(null);
    }


    // =========================================================
    // ASIGNAR ESPECIALIDAD
    // =========================================================

    public Tecnico asignarEspecialidad(
            Integer idTec,
            Integer idEspecialidad) {

        Tecnico tecnico =
                tecnicoRepository
                        .findById(idTec)
                        .orElseThrow(() ->
                            new RuntimeException(
                                "Técnico no encontrado"
                            )
                        );


        EspecialidadTecnico especialidad =
                especialidadRepository
                        .findById(idEspecialidad)
                        .orElseThrow(() ->
                            new RuntimeException(
                                "Especialidad no encontrada"
                            )
                        );


        tecnico.setEspecialidad(especialidad);


        return tecnicoRepository.save(tecnico);
    }


    // =========================================================
    // OBTENER TÉCNICO POR CORREO
    // =========================================================

    public Tecnico obtenerTecnicoPorCorreo(String correo) {

        return tecnicoRepository
                .findByCorreoTec(correo)
                .orElse(null);
    }
}