package co.edu.uniremington.gabrieladumar.Mantenimiento.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Tecnico;

public interface TecnicoRepository extends JpaRepository<Tecnico, Integer> {

    Optional<Tecnico> findByCorreoTec(String correoTec);

}