package co.edu.uniremington.gabrieladumar.Mantenimiento.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Perfil;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.PerfilRepository;

@Configuration
public class DataInitializer {

    @Bean
    CommandLineRunner initializeProfiles(PerfilRepository perfilRepository) {
        return args -> {
            createProfileIfMissing(perfilRepository, "Cliente", "Usuario cliente");
            createProfileIfMissing(perfilRepository, "Administrador", "Administrador del sistema");
            createProfileIfMissing(perfilRepository, "Tecnico", "Tecnico de servicios");
        };
    }

    private void createProfileIfMissing(
            PerfilRepository perfilRepository,
            String name,
            String description) {
        boolean profileExists = perfilRepository.findAll().stream()
                .anyMatch(perfil -> name.equals(perfil.getNombrePerfil()));

        if (profileExists) {
            return;
        }

        Perfil perfil = new Perfil();
        perfil.setNombrePerfil(name);
        perfil.setDescripcion(description);
        perfilRepository.save(perfil);
    }
}package co.edu.uniremington.gabrieladumar.Mantenimiento.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Perfil;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.PerfilRepository;

@Configuration
public class DataInitializer {

    @Bean
    CommandLineRunner initializeProfiles(PerfilRepository perfilRepository) {
        return args -> {
            createProfileIfMissing(perfilRepository, "Cliente", "Usuario cliente");
            createProfileIfMissing(perfilRepository, "Administrador", "Administrador del sistema");
            createProfileIfMissing(perfilRepository, "Tecnico", "Tecnico de servicios");
        };
    }

    private void createProfileIfMissing(
            PerfilRepository perfilRepository,
            String name,
            String description) {
        boolean profileExists = perfilRepository.findAll().stream()
                .anyMatch(perfil -> name.equals(perfil.getNombrePerfil()));

        if (profileExists) {
            return;
        }

        Perfil perfil = new Perfil();
        perfil.setNombrePerfil(name);
        perfil.setDescripcion(description);
        perfilRepository.save(perfil);
    }
}