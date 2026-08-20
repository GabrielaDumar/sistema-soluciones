package co.edu.uniremington.gabrieladumar.Mantenimiento.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Cliente;

public interface ClienteRepository extends JpaRepository<Cliente, Integer> {

    Optional<Cliente> findByCorreoCli(String correoCli);

}

