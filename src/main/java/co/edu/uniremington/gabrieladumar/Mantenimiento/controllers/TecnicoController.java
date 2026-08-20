package co.edu.uniremington.gabrieladumar.Mantenimiento.controllers;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Tecnico;
import co.edu.uniremington.gabrieladumar.Mantenimiento.services.TecnicoService;

@RestController
@RequestMapping("/api/tecnicos")
public class TecnicoController {

    @Autowired
    private TecnicoService tecnicoService;


    // =========================================================
    // CREAR TÉCNICO
    // =========================================================

    @PostMapping
    public ResponseEntity<?> crearTecnico(
            @RequestBody Map<String, Object> datos) {

        try {

            String nombre =
                    (String) datos.get("nomTec");

            String apellido =
                    (String) datos.get("apeTec");

            String telefono =
                    (String) datos.get("telTec");

            String correo =
                    (String) datos.get("correoTec");

            String password =
                    (String) datos.get("password");

            String disponibilidad =
                    (String) datos.get("dispTec");


            // =================================================
            // OBTENER ESPECIALIDAD
            // =================================================

            Integer idEspecialidad = null;

            if (datos.get("especialidad") != null) {

                Map<String, Object> especialidad =
                        (Map<String, Object>)
                                datos.get("especialidad");

                Object id =
                        especialidad.get("idEspTec");

                if (id != null) {

                    idEspecialidad =
                            Integer.valueOf(
                                    id.toString()
                            );
                }
            }


            // =================================================
            // CREAR TÉCNICO + USUARIO
            // =================================================

            Tecnico tecnico =
                    tecnicoService.registrarTecnico(
                            nombre,
                            apellido,
                            telefono,
                            correo,
                            idEspecialidad,
                            disponibilidad,
                            password
                    );


            return ResponseEntity
                    .status(HttpStatus.CREATED)
                    .body(tecnico);

        } catch (Exception e) {

            return ResponseEntity
                    .badRequest()
                    .body(
                            Map.of(
                                    "error",
                                    e.getMessage()
                            )
                    );
        }
    }


    // =========================================================
    // LISTAR TÉCNICOS
    // =========================================================

    @GetMapping
    public ResponseEntity<List<Tecnico>>
            listarTecnicos() {

        return ResponseEntity.ok(
                tecnicoService.obtenerTodosTecnicos()
        );
    }


    // =========================================================
    // ASIGNAR ESPECIALIDAD
    // =========================================================

    @PutMapping(
            "/{idTec}/especialidad/{idEspecialidad}"
    )
    public ResponseEntity<Tecnico>
            asignarEspecialidad(
                    @PathVariable Integer idTec,
                    @PathVariable Integer idEspecialidad) {

        return ResponseEntity.ok(
                tecnicoService.asignarEspecialidad(
                        idTec,
                        idEspecialidad
                )
        );
    }


    // =========================================================
    // BUSCAR TÉCNICO POR CORREO
    // =========================================================

    @GetMapping("/correo/{correo}")
    public ResponseEntity<Tecnico>
            obtenerTecnicoPorCorreo(
                    @PathVariable String correo) {

        Tecnico tecnico =
                tecnicoService
                        .obtenerTecnicoPorCorreo(correo);

        if (tecnico == null) {

            return ResponseEntity
                    .notFound()
                    .build();
        }

        return ResponseEntity.ok(tecnico);
    }
}