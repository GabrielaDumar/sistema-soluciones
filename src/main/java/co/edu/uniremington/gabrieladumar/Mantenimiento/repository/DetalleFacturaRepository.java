package co.edu.uniremington.gabrieladumar.Mantenimiento.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import co.edu.uniremington.gabrieladumar.Mantenimiento.model.DetalleFactura;

public interface DetalleFacturaRepository extends JpaRepository<DetalleFactura, Integer> {
    
    // Método para obtener detalles de una factura específica
    List<DetalleFactura> findByFactura_IdFac(Integer idFactura);
}

