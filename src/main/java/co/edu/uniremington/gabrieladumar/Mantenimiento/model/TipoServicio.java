package co.edu.uniremington.gabrieladumar.Mantenimiento.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;


@Entity
@Table(name = "tiposervicio")
public class TipoServicio {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_TipoSer")
    private Integer idTipoSer;
    
    @Column(name = "desc_TipoSer", length = 50)
    private String descTipoSer;

    // Getters y Setters
    public Integer getIdTipoSer() {
        return idTipoSer;
    }

    public void setIdTipoSer(Integer idTipoSer) {
        this.idTipoSer = idTipoSer;
    }

    public String getDescTipoSer() {
        return descTipoSer;
    }

    public void setDescTipoSer(String descTipoSer) {
        this.descTipoSer = descTipoSer;
    }
}
