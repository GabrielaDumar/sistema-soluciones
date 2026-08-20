package co.edu.uniremington.gabrieladumar.Mantenimiento.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Usuario;
import co.edu.uniremington.gabrieladumar.Mantenimiento.services.LoginService;

@RestController
@RequestMapping("/api")
public class LoginController {

    @Autowired
    private LoginService loginService;

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Usuario usuario) {

        Usuario usuarioValido =
                loginService.validarUsuario(
                        usuario.getCorreoUsu(),
                        usuario.getContUsu());

        if(usuarioValido != null){
            return ResponseEntity.ok(usuarioValido);
        }

        return ResponseEntity.badRequest()
                .body("Correo o contraseña incorrectos");
    }


}
