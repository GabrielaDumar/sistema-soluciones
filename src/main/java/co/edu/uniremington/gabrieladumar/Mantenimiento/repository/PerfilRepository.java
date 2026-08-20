package co.edu.uniremington.gabrieladumar.Mantenimiento.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Perfil;

public interface PerfilRepository extends JpaRepository<Perfil, Integer> {
    
}