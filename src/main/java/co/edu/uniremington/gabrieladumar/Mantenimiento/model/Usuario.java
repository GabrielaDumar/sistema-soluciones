package co.edu.uniremington.gabrieladumar.Mantenimiento.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "usuario")
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_usu")
    private Integer idUsu;

    @Column(name = "nom_usu", length = 50, nullable = false)
    private String nomUsu;

    @Column(name = "ape_usu", length = 50, nullable = false)
    private String apeUsu;

    @Column(name = "correo_usu", length = 80)
    private String correoUsu;

    @Column(name = "cont_usu", length = 255, nullable = false)
    private String contUsu;

    // Relación con Perfil
    @ManyToOne
    @JoinColumn(name = "id_perfil")
    private Perfil perfil;

    // Relación con Cliente
    @ManyToOne
    @JoinColumn(name = "id_cliente")
    private Cliente cliente;

    // Relación con Técnico
    @ManyToOne
    @JoinColumn(name = "id_tec")
    private Tecnico tecnico;


    // =========================================================
    // GETTERS Y SETTERS
    // =========================================================

    public Integer getIdUsu() {
        return idUsu;
    }

    public void setIdUsu(Integer idUsu) {
        this.idUsu = idUsu;
    }

    public String getNomUsu() {
        return nomUsu;
    }

    public void setNomUsu(String nomUsu) {
        this.nomUsu = nomUsu;
    }

    public String getApeUsu() {
        return apeUsu;
    }

    public void setApeUsu(String apeUsu) {
        this.apeUsu = apeUsu;
    }

    public String getCorreoUsu() {
        return correoUsu;
    }

    public void setCorreoUsu(String correoUsu) {
        this.correoUsu = correoUsu;
    }

    public String getContUsu() {
        return contUsu;
    }

    public void setContUsu(String contUsu) {
        this.contUsu = contUsu;
    }

    public Perfil getPerfil() {
        return perfil;
    }

    public void setPerfil(Perfil perfil) {
        this.perfil = perfil;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public Tecnico getTecnico() {
        return tecnico;
    }

    public void setTecnico(Tecnico tecnico) {
        this.tecnico = tecnico;
    }
    
}