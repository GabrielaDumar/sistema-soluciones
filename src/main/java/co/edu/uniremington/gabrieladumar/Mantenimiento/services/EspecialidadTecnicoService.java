package co.edu.uniremington.gabrieladumar.Mantenimiento.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.edu.uniremington.gabrieladumar.Mantenimiento.model.EspecialidadTecnico;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.EspecialidadTecnicoRepository;

@Service
public class EspecialidadTecnicoService {
     @Autowired
    private EspecialidadTecnicoRepository especialidadTecnicoRepository;

    public EspecialidadTecnico guardarEspecialidad(
            EspecialidadTecnico especialidad) {

        return especialidadTecnicoRepository.save(especialidad);
    }

    public List<EspecialidadTecnico> obtenerTodasEspecialidades() {
        return especialidadTecnicoRepository.findAll();
    }


}
