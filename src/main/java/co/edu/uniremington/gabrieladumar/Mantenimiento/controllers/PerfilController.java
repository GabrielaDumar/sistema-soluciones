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

import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Perfil;
import co.edu.uniremington.gabrieladumar.Mantenimiento.services.PerfilService;

@RestController
@RequestMapping("/api/perfiles")
public class PerfilController {

    
     @Autowired
    private PerfilService perfilService;

    @PostMapping
    public ResponseEntity<Perfil> crearPerfil(@RequestBody Perfil perfil) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(perfilService.guardarPerfil(perfil));
    }

    @GetMapping
    public ResponseEntity<List<Perfil>> listarPerfiles() {
        return ResponseEntity.ok(perfilService.obtenerTodosPerfiles());
    }
}
