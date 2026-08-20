package co.edu.uniremington.gabrieladumar.Mantenimiento.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import co.edu.uniremington.gabrieladumar.Mantenimiento.model.TipoServicio;
import co.edu.uniremington.gabrieladumar.Mantenimiento.services.TipoServicioService;


@RestController
@RequestMapping("/api/tipos-servicio")
public class TipoServicioController {

     @Autowired
    private TipoServicioService tipoServicioService;

    @PostMapping
    public ResponseEntity<TipoServicio> crearTipoServicio(@RequestBody TipoServicio tipoServicio) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(tipoServicioService.guardarTipoServicio(tipoServicio));
    }

    @GetMapping
    public ResponseEntity<List<TipoServicio>> listarTiposServicio() {
        return ResponseEntity.ok(tipoServicioService.obtenerTodosTiposServicio());
    }


}
