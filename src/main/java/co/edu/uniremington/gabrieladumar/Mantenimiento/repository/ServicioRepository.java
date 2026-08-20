package co.edu.uniremington.gabrieladumar.Mantenimiento.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Servicio;

public interface ServicioRepository
        extends JpaRepository<Servicio, Integer> {


    // =====================================================
    // SERVICIOS DE UN TÉCNICO
    // =====================================================

    List<Servicio> findByTecnico_IdTec(
            Integer idTec
    );


    // =====================================================
    // SERVICIOS ACEPTADOS DE UN TÉCNICO
    // =====================================================

    List<Servicio> findByTecnico_IdTecAndEstadoSer(
            Integer idTec,
            String estadoSer
    );
}