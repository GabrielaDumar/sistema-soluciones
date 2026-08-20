package co.edu.uniremington.gabrieladumar.Mantenimiento.controllers;

import java.util.List;

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

import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Servicio;
import co.edu.uniremington.gabrieladumar.Mantenimiento.services.ServicioService;

@RestController
@RequestMapping("/api/servicios")
public class ServicioController {


    @Autowired
    private ServicioService servicioService;


    // =====================================================
    // CREAR SERVICIO
    // =====================================================

    @PostMapping
    public ResponseEntity<Servicio> crearServicio(
            @RequestBody Servicio servicio) {

        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(
                        servicioService.guardarServicio(servicio)
                );
    }


    // =====================================================
    // LISTAR TODOS LOS SERVICIOS
    // =====================================================

    @GetMapping
    public ResponseEntity<List<Servicio>> listarServicios() {

        return ResponseEntity.ok(
                servicioService.obtenerTodosServicios()
        );
    }


    // =====================================================
    // LISTAR SERVICIOS DE UN TÉCNICO
    // =====================================================

    @GetMapping("/tecnico/{idTec}")
    public ResponseEntity<List<Servicio>>
            listarServiciosPorTecnico(
                    @PathVariable Integer idTec) {

        return ResponseEntity.ok(
                servicioService
                        .obtenerServiciosPorTecnico(idTec)
        );
    }


    // =====================================================
    // LISTAR SERVICIOS ACEPTADOS DE UN TÉCNICO
    // =====================================================

    @GetMapping("/tecnico/{idTec}/aceptados")
    public ResponseEntity<List<Servicio>>
            listarServiciosAceptadosPorTecnico(
                    @PathVariable Integer idTec) {

        return ResponseEntity.ok(
                servicioService
                        .obtenerServiciosAceptadosPorTecnico(
                                idTec
                        )
        );
    }


    // =====================================================
    // ACEPTAR SERVICIO
    // =====================================================

    @PutMapping("/{idSer}/aceptar")
    public ResponseEntity<Servicio>
            aceptarServicio(
                    @PathVariable Integer idSer) {

        return ResponseEntity.ok(
                servicioService
                        .aceptarServicio(idSer)
        );
    }


    // =====================================================
    // RECHAZAR SERVICIO
    // =====================================================

    @PutMapping("/{idSer}/rechazar")
    public ResponseEntity<Servicio>
            rechazarServicio(
                    @PathVariable Integer idSer) {

        return ResponseEntity.ok(
                servicioService
                        .rechazarServicio(idSer)
        );
    }


    // =====================================================
    // ACTUALIZAR ESTADO
    // =====================================================

    @PutMapping("/{idSer}/estado/{estado}")
    public ResponseEntity<Servicio>
            actualizarEstadoServicio(
                    @PathVariable Integer idSer,
                    @PathVariable String estado) {

        return ResponseEntity.ok(
                servicioService
                        .actualizarEstadoServicio(
                                idSer,
                                estado
                        )
        );
    }
}