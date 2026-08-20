package co.edu.uniremington.gabrieladumar.Mantenimiento.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Usuario;

public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {
    
    // Método para buscar usuario por correo (para el login)
    Optional<Usuario> findByCorreoUsu(String correoUsu);

    boolean existsByPerfil_IdPerfil(Integer idPerfil);
    
}