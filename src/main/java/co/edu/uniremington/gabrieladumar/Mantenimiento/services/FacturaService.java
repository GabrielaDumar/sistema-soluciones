package co.edu.uniremington.gabrieladumar.Mantenimiento.services;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Cliente;
import co.edu.uniremington.gabrieladumar.Mantenimiento.model.DetalleFactura;
import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Factura;
import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Servicio;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.ClienteRepository;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.DetalleFacturaRepository;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.FacturaRepository;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.ServicioRepository;


@Service
public class FacturaService {

     @Autowired
    private FacturaRepository facturaRepository;
    
    @Autowired
    private DetalleFacturaRepository detalleFacturaRepository;
    
    @Autowired
    private ClienteRepository clienteRepository;
    
    @Autowired
    private ServicioRepository servicioRepository;
    
    public List<Factura> obtenerTodasFacturas() {
        return facturaRepository.findAll();
    }
    
    public List<Servicio> obtenerTodosServicios() {
        return servicioRepository.findAll();
    }
    
    public Factura generarFactura(Integer idCliente, BigDecimal total, LocalDate fecha, 
                              List<Integer> serviciosIds, List<Integer> cantidades) {
    // Crear la factura
    Factura factura = new Factura();
    Cliente cliente = clienteRepository.findById(idCliente).orElse(null);
    factura.setCliente(cliente);
    factura.setTotalFac(total);
    factura.setFechaFac(fecha);
    
    // Guardar la factura primero
    factura = facturaRepository.save(factura);
    
    // Crear los detalles SOLO si hay servicios
    if (serviciosIds != null && !serviciosIds.isEmpty() && cantidades != null && !cantidades.isEmpty()) {
        List<DetalleFactura> detalles = new ArrayList<>();
        for (int i = 0; i < serviciosIds.size(); i++) {
            if (serviciosIds.get(i) != null && serviciosIds.get(i) > 0) {
                DetalleFactura detalle = new DetalleFactura();
                detalle.setFactura(factura);
                
                Servicio servicio = servicioRepository.findById(serviciosIds.get(i)).orElse(null);
                if (servicio != null) {
                    detalle.setServicio(servicio);
                    detalle.setCantidadDetFac(cantidades.get(i));
                    detalle.setValorServicio(servicio.getPrecioSer());
                    
                    detalles.add(detalle);
                }
            }
        }
        
        // Guardar los detalles
        if (!detalles.isEmpty()) {
            detalleFacturaRepository.saveAll(detalles);
        }
    }
    
    return factura;
}
    
    public Factura obtenerFacturaPorId(Integer id) {
        return facturaRepository.findById(id).orElse(null);
    }
    
    public List<DetalleFactura> obtenerDetallesFactura(Integer idFactura) {
        return detalleFacturaRepository.findByFactura_IdFac(idFactura);
    }

 public Factura guardarFactura(Factura factura) {

    // Guardar la factura primero
    Factura facturaGuardada = facturaRepository.save(factura);

    // Guardar los detalles si existen
    if (factura.getDetalles() != null && !factura.getDetalles().isEmpty()) {

        for (DetalleFactura detalle : factura.getDetalles()) {

            detalle.setFactura(facturaGuardada);

            // Si no envías valorServicio, tomar el precio del servicio
            if (detalle.getServicio() != null &&
                detalle.getValorServicio() == null) {

                Servicio servicio = servicioRepository
                        .findById(detalle.getServicio().getIdSer())
                        .orElse(null);

                if (servicio != null) {
                    detalle.setValorServicio(servicio.getPrecioSer());
                }
            }

            detalleFacturaRepository.save(detalle);
        }
    }

    return facturaGuardada;
}

}
