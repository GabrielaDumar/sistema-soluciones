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

import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Factura;
import co.edu.uniremington.gabrieladumar.Mantenimiento.services.FacturaService;

@RestController
@RequestMapping("/api/facturas")
public class FacturaController {

     @Autowired
    private FacturaService facturaService;

    @PostMapping
    public ResponseEntity<Factura> crearFactura(@RequestBody Factura factura) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(facturaService.guardarFactura(factura));
    }

    @GetMapping
    public ResponseEntity<List<Factura>> listarFacturas() {
        return ResponseEntity.ok(facturaService.obtenerTodasFacturas());
    }


}
