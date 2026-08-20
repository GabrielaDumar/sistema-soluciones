package co.edu.uniremington.gabrieladumar.Mantenimiento.model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;


@Entity
@Table(name = "factura")
public class Factura {

     @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_Fac")
    private Integer idFac;
    
    @ManyToOne
    @JoinColumn(name = "id_cliente")
    private Cliente cliente;
    
    @Column(name = "fecha_Fac")
    private LocalDate fechaFac;
    
    @Column(name = "total_Fac", precision = 10, scale = 2)
    private BigDecimal totalFac;

    @OneToMany(mappedBy = "factura", cascade = CascadeType.ALL)
    private List<DetalleFactura> detalles;

    // Getters y Setters

    public List<DetalleFactura> getDetalles() {
    return detalles;
    }

    public void setDetalles(List<DetalleFactura> detalles) {
    this.detalles = detalles;
    }
    
    public Integer getIdFac() {
        return idFac;
    }

    public void setIdFac(Integer idFac) {
        this.idFac = idFac;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public LocalDate getFechaFac() {
        return fechaFac;
    }

    public void setFechaFac(LocalDate fechaFac) {
        this.fechaFac = fechaFac;
    }

    public BigDecimal getTotalFac() {
        return totalFac;
    }

    public void setTotalFac(BigDecimal totalFac) {
        this.totalFac = totalFac;
    }
}
