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

import co.edu.uniremington.gabrieladumar.Mantenimiento.model.EspecialidadTecnico;
import co.edu.uniremington.gabrieladumar.Mantenimiento.services.EspecialidadTecnicoService;

@RestController
@RequestMapping("/api/especialidades")
public class EspecialidadTecnicoController {

    @Autowired
    private EspecialidadTecnicoService especialidadTecnicoService;

    @PostMapping
    public ResponseEntity<EspecialidadTecnico> crearEspecialidad(
            @RequestBody EspecialidadTecnico especialidad) {

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(especialidadTecnicoService.guardarEspecialidad(especialidad));
    }

    @GetMapping
    public ResponseEntity<List<EspecialidadTecnico>> listarEspecialidades() {
        return ResponseEntity.ok(
                especialidadTecnicoService.obtenerTodasEspecialidades());
    }

}
