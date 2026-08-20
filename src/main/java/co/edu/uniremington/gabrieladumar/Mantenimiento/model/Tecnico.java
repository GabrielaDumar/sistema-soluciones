package co.edu.uniremington.gabrieladumar.Mantenimiento.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
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
import java.util.List;

@Entity
@Table(name = "tecnico")
public class Tecnico {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_tec")
    private Integer idTec;
    
    @Column(name = "nom_tec", length = 50)
    private String nomTec;
    
    @Column(name = "ape_tec", length = 50)
    private String apeTec;
    
    @Column(name = "tel_tec", length = 15)
    private String telTec;
    
    @Column(name = "correo_tec", length = 80)
    private String correoTec;
    
    @ManyToOne
    @JoinColumn(name = "id_EspTec")
    private EspecialidadTecnico especialidad;
    
    @Column(name = "disp_Tec", length = 20)
    private String dispTec;

    // --- NUEVA RELACIÓN ---
    @OneToMany(mappedBy = "tecnico", cascade = CascadeType.ALL)
    @JsonIgnoreProperties("tecnico") // Evita recursión infinita al serializar a JSON
    private List<Servicio> servicios;

    // Getters y Setters existentes...

    public Integer getIdTec() {
        return idTec;
    }

    public void setIdTec(Integer idTec) {
        this.idTec = idTec;
    }

    public String getNomTec() {
        return nomTec;
    }

    public void setNomTec(String nomTec) {
        this.nomTec = nomTec;
    }

    public String getApeTec() {
        return apeTec;
    }

    public void setApeTec(String apeTec) {
        this.apeTec = apeTec;
    }

    public String getTelTec() {
        return telTec;
    }

    public void setTelTec(String telTec) {
        this.telTec = telTec;
    }

    public String getCorreoTec() {
        return correoTec;
    }

    public void setCorreoTec(String correoTec) {
        this.correoTec = correoTec;
    }

    public EspecialidadTecnico getEspecialidad() {
        return especialidad;
    }

    public void setEspecialidad(EspecialidadTecnico especialidad) {
        this.especialidad = especialidad;
    }

    public String getDispTec() {
        return dispTec;
    }

    public void setDispTec(String dispTec) {
        this.dispTec = dispTec;
    }

    // --- GETTER Y SETTER DE LA NUEVA LISTA ---
    public List<Servicio> getServicios() {
        return servicios;
    }

    public void setServicios(List<Servicio> servicios) {
        this.servicios = servicios;
    }
}