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
@Table(name = "cotizacion")
public class Cotizacion {

     @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_Cot")
    private Integer idCot;
    
    @ManyToOne
    @JoinColumn(name = "id_cliente")
    private Cliente cliente;
    
    @Column(name = "total_Cot", precision = 10, scale = 2)
    private BigDecimal totalCot;
    
    @Column(name = "estado_Cot", length = 30)
    private String estadoCot;

    // Getters y Setters
    public Integer getIdCot() {
        return idCot;
    }

    public void setIdCot(Integer idCot) {
        this.idCot = idCot;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public BigDecimal getTotalCot() {
        return totalCot;
    }

    public void setTotalCot(BigDecimal totalCot) {
        this.totalCot = totalCot;
    }

    public String getEstadoCot() {
        return estadoCot;
    }

    public void setEstadoCot(String estadoCot) {
        this.estadoCot = estadoCot;
    }
}

