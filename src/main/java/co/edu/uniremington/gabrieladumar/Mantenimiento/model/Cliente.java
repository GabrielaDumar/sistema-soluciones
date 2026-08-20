package co.edu.uniremington.gabrieladumar.Mantenimiento.model;

import com.fasterxml.jackson.annotation.JsonProperty;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

@Entity
@Table(name = "cliente")
public class Cliente {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_cliente")
    private Integer idCliente;

    @Column(name = "nom_cli", length = 50)
    private String nomCli;

    @Column(name = "ape_cli", length = 50)
    private String apeCli;

    @Column(name = "tel_cli", length = 15)
    private String telCli;

    @Column(name = "correo_cli", length = 80)
    private String correoCli;

    @Column(name = "dir_cli", length = 100)
    private String dirCli;

    // =========================================================
    // CONTRASEÑA
    // No se guarda en la tabla cliente
    // Solo se recibe para crear el usuario
    // =========================================================

    @Transient
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private String password;


    // =========================================================
    // GETTERS Y SETTERS
    // =========================================================

    public Integer getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(Integer idCliente) {
        this.idCliente = idCliente;
    }

    public String getNomCli() {
        return nomCli;
    }

    public void setNomCli(String nomCli) {
        this.nomCli = nomCli;
    }

    public String getApeCli() {
        return apeCli;
    }

    public void setApeCli(String apeCli) {
        this.apeCli = apeCli;
    }

    public String getTelCli() {
        return telCli;
    }

    public void setTelCli(String telCli) {
        this.telCli = telCli;
    }

    public String getCorreoCli() {
        return correoCli;
    }

    public void setCorreoCli(String correoCli) {
        this.correoCli = correoCli;
    }

    public String getDirCli() {
        return dirCli;
    }

    public void setDirCli(String dirCli) {
        this.dirCli = dirCli;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}