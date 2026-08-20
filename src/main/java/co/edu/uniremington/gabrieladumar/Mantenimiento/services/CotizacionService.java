package co.edu.uniremington.gabrieladumar.Mantenimiento.services;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Cliente;
import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Cotizacion;
import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Servicio;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.ClienteRepository;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.CotizacionRepository;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.ServicioRepository;

@Service
public class CotizacionService {

    @Autowired
    private CotizacionRepository cotizacionRepository;
    
    @Autowired
    private ClienteRepository clienteRepository;

     @Autowired
    private ServicioRepository servicioRepository;
    
    public List<Cotizacion> obtenerTodasCotizaciones() {
        return cotizacionRepository.findAll();
    }

    public List<Servicio> obtenerTodosServicios() {
    return servicioRepository.findAll();
}
    
    public Cotizacion crearCotizacion(Integer idCliente, BigDecimal total, String estado) {
        Cotizacion cotizacion = new Cotizacion();
        
        Cliente cliente = clienteRepository.findById(idCliente).orElse(null);
        cotizacion.setCliente(cliente);
        cotizacion.setTotalCot(total);
        cotizacion.setEstadoCot(estado);
        
        return cotizacionRepository.save(cotizacion);
    }

 public Cotizacion guardarCotizacion(Cotizacion cotizacion) {
    return cotizacionRepository.save(cotizacion);
}


}
