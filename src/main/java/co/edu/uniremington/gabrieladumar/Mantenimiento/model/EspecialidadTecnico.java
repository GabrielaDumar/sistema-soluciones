package co.edu.uniremington.gabrieladumar.Mantenimiento.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;


@Entity
@Table(name = "especialidadtecnico")
public class EspecialidadTecnico {

      @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
     @Column(name = "id_EspTec")
    private Integer idEspTec;
    
    @Column(name = "desc_EspTec", length = 50)
    private String descEspTec;

    // Getters y Setters
    public Integer getIdEspTec() {
        return idEspTec;
    }

    public void setIdEspTec(Integer idEspTec) {
        this.idEspTec = idEspTec;
    }

    public String getDescEspTec() {
        return descEspTec;
    }

    public void setDescEspTec(String descEspTec) {
        this.descEspTec = descEspTec;
    }
}