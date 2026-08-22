package co.edu.uniremington.gabrieladumar.Mantenimiento.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Perfil;
import co.edu.uniremington.gabrieladumar.Mantenimiento.model.EspecialidadTecnico;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.EspecialidadTecnicoRepository;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.PerfilRepository;

@Configuration
public class DataInitializer {

    @Bean
    CommandLineRunner initializeProfiles(
            PerfilRepository perfilRepository,
            EspecialidadTecnicoRepository especialidadRepository) {
        return args -> {
            createProfileIfMissing(perfilRepository, "Cliente", "Usuario cliente");
            createProfileIfMissing(perfilRepository, "Administrador", "Administrador del sistema");
            createProfileIfMissing(perfilRepository, "Tecnico", "Tecnico de servicios");
            createSpecialtyIfMissing(especialidadRepository, "Electricidad");
            createSpecialtyIfMissing(especialidadRepository, "Plomería");
            createSpecialtyIfMissing(especialidadRepository, "Pintura");
            createSpecialtyIfMissing(especialidadRepository, "Carpintería");
            createSpecialtyIfMissing(especialidadRepository, "Sistemas");
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

    private void createSpecialtyIfMissing(
            EspecialidadTecnicoRepository especialidadRepository,
            String name) {
        boolean specialtyExists = especialidadRepository.findAll().stream()
                .anyMatch(especialidad -> name.equals(especialidad.getDescEspTec()));

        if (specialtyExists) {
            return;
        }

        EspecialidadTecnico especialidad = new EspecialidadTecnico();
        especialidad.setDescEspTec(name);
        especialidadRepository.save(especialidad);
    }
}