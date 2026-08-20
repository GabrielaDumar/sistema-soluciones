package co.edu.uniremington.gabrieladumar.Mantenimiento.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Perfil;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.PerfilRepository;

@Service
public class PerfilService {

     @Autowired
    private PerfilRepository perfilRepository;

    public Perfil guardarPerfil(Perfil perfil) {
        return perfilRepository.save(perfil);
    }

    public List<Perfil> obtenerTodosPerfiles() {
        return perfilRepository.findAll();
    }

}
