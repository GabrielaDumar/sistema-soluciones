package co.edu.uniremington.gabrieladumar.Mantenimiento.model;

import java.math.BigDecimal;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;


@Entity
@Table(name = "detallefactura")
public class DetalleFactura {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_DetFac")
    private Integer idDetFac;
    
    @ManyToOne
    @JoinColumn(name = "id_Fac")
    private Factura factura;
    
    @ManyToOne
    @JoinColumn(name = "id_Ser")
    private Servicio servicio;
    
    @Column(name = "cantidad_DetFac")
    private Integer cantidadDetFac;
    
    @Column(name = "valorServicio", precision = 10, scale = 2)
    private BigDecimal valorServicio;

    // Getters y Setters
    public Integer getIdDetFac() {
        return idDetFac;
    }

    public void setIdDetFac(Integer idDetFac) {
        this.idDetFac = idDetFac;
    }

    public Factura getFactura() {
        return factura;
    }

    public void setFactura(Factura factura) {
        this.factura = factura;
    }

    public Servicio getServicio() {
        return servicio;
    }

    public void setServicio(Servicio servicio) {
        this.servicio = servicio;
    }

    public Integer getCantidadDetFac() {
        return cantidadDetFac;
    }

    public void setCantidadDetFac(Integer cantidadDetFac) {
        this.cantidadDetFac = cantidadDetFac;
    }

    public BigDecimal getValorServicio() {
        return valorServicio;
    }

    public void setValorServicio(BigDecimal valorServicio) {
        this.valorServicio = valorServicio;
    }
}