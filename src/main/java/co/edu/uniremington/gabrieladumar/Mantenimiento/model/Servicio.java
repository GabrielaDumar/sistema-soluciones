package co.edu.uniremington.gabrieladumar.Mantenimiento.model;

import java.math.BigDecimal;
import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "servicio")
public class Servicio {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_Ser")
    private Integer idSer;


    @ManyToOne
    @JoinColumn(name = "id_TipoSer")
    private TipoServicio tipoServicio;


    @Column(name = "precio_Ser", precision = 10, scale = 2)
    private BigDecimal precioSer;


    @Column(name = "estado_Ser", length = 30)
    private String estadoSer;


    @Column(name = "fecha_Ser")
    private LocalDate fechaSer;


    @ManyToOne
    @JoinColumn(name = "id_Tec")
    private Tecnico tecnico;


    @ManyToOne
    @JoinColumn(name = "id_cliente")
    private Cliente cliente;


    @Column(name = "descripcion_Ser", length = 500)
    private String descripcionSer;


    public Integer getIdSer() {
        return idSer;
    }

    public void setIdSer(Integer idSer) {
        this.idSer = idSer;
    }


    public TipoServicio getTipoServicio() {
        return tipoServicio;
    }

    public void setTipoServicio(
            TipoServicio tipoServicio) {

        this.tipoServicio = tipoServicio;
    }


    public BigDecimal getPrecioSer() {
        return precioSer;
    }

    public void setPrecioSer(
            BigDecimal precioSer) {

        this.precioSer = precioSer;
    }


    public String getEstadoSer() {
        return estadoSer;
    }

    public void setEstadoSer(
            String estadoSer) {

        this.estadoSer = estadoSer;
    }


    public LocalDate getFechaSer() {
        return fechaSer;
    }

    public void setFechaSer(
            LocalDate fechaSer) {

        this.fechaSer = fechaSer;
    }


    public Tecnico getTecnico() {
        return tecnico;
    }

    public void setTecnico(
            Tecnico tecnico) {

        this.tecnico = tecnico;
    }


    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(
            Cliente cliente) {

        this.cliente = cliente;
    }


    public String getDescripcionSer() {
        return descripcionSer;
    }

    public void setDescripcionSer(
            String descripcionSer) {

        this.descripcionSer = descripcionSer;
    }
}