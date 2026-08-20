package co.edu.uniremington.gabrieladumar.Mantenimiento.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Cliente;
import co.edu.uniremington.gabrieladumar.Mantenimiento.services.ClienteService;

@RestController
@RequestMapping("/api/clientes")
public class ClienteController {

    @Autowired
    private ClienteService clienteService;

    // Guardar cliente
    @PostMapping
    public ResponseEntity<Cliente> crearCliente(
            @RequestBody Cliente cliente) {

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(clienteService.guardarCliente(cliente));
    }

    // Consultar todos los clientes
    @GetMapping
    public ResponseEntity<List<Cliente>> listarClientes() {

        return ResponseEntity.ok(
                clienteService.obtenerTodosClientes()
        );
    }

    // Buscar cliente por correo
    @GetMapping("/correo/{correo}")
    public ResponseEntity<Cliente> buscarPorCorreo(
            @PathVariable String correo) {

        Cliente cliente =
                clienteService.buscarPorCorreo(correo);

        if (cliente == null) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.ok(cliente);
    }
}