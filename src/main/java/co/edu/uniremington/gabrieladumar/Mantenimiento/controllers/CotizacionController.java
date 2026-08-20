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

import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Cotizacion;
import co.edu.uniremington.gabrieladumar.Mantenimiento.services.CotizacionService;

@RestController
@RequestMapping("/api/cotizaciones")
public class CotizacionController {

     @Autowired
    private CotizacionService cotizacionService;

    @PostMapping
    public ResponseEntity<Cotizacion> crearCotizacion(@RequestBody Cotizacion cotizacion) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(cotizacionService.guardarCotizacion(cotizacion));
    }

    @GetMapping
    public ResponseEntity<List<Cotizacion>> listarCotizaciones() {
        return ResponseEntity.ok(cotizacionService.obtenerTodasCotizaciones());
    }

}
