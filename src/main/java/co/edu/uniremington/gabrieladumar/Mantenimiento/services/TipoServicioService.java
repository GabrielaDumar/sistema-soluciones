package co.edu.uniremington.gabrieladumar.Mantenimiento.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.edu.uniremington.gabrieladumar.Mantenimiento.model.TipoServicio;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.TipoServicioRepository;

@Service
public class TipoServicioService {

    @Autowired
    private TipoServicioRepository tipoServicioRepository;

    public TipoServicio guardarTipoServicio(TipoServicio tipoServicio) {
        return tipoServicioRepository.save(tipoServicio);
    }

    public List<TipoServicio> obtenerTodosTiposServicio() {
        return tipoServicioRepository.findAll();
    }

}
