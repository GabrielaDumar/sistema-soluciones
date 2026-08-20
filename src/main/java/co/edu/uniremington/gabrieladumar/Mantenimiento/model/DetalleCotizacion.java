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
@Table(name = "detallecotizacion")
public class DetalleCotizacion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_DetCot")
    private Integer idDetCot;
    
    @ManyToOne
    @JoinColumn(name = "id_Cot")
    private Cotizacion cotizacion;
    
    @ManyToOne
    @JoinColumn(name = "id_Ser")
    private Servicio servicio;
    
    @Column(name = "cantidad_DetCot")
    private Integer cantidadDetCot;
    
    @Column(name = "valorServicio", precision = 10, scale = 2)
    private BigDecimal valorServicio;

    // Getters y Setters
    public Integer getIdDetCot() {
        return idDetCot;
    }

    public void setIdDetCot(Integer idDetCot) {
        this.idDetCot = idDetCot;
    }

    public Cotizacion getCotizacion() {
        return cotizacion;
    }

    public void setCotizacion(Cotizacion cotizacion) {
        this.cotizacion = cotizacion;
    }

    public Servicio getServicio() {
        return servicio;
    }

    public void setServicio(Servicio servicio) {
        this.servicio = servicio;
    }

    public Integer getCantidadDetCot() {
        return cantidadDetCot;
    }

    public void setCantidadDetCot(Integer cantidadDetCot) {
        this.cantidadDetCot = cantidadDetCot;
    }

    public BigDecimal getValorServicio() {
        return valorServicio;
    }

    public void setValorServicio(BigDecimal valorServicio) {
        this.valorServicio = valorServicio;
    }
}

