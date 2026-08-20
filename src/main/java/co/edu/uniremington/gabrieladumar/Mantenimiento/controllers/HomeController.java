package co.edu.uniremington.gabrieladumar.Mantenimiento.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HomeController {

    @GetMapping("/")
    public String inicio() {
        return "API Sistema de Mantenimiento funcionando correctamente";
    }

}
