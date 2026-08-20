package co.edu.uniremington.gabrieladumar.Mantenimiento.services;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Servicio;
import co.edu.uniremington.gabrieladumar.Mantenimiento.model.Tecnico;
import co.edu.uniremington.gabrieladumar.Mantenimiento.model.TipoServicio;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.ServicioRepository;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.TecnicoRepository;
import co.edu.uniremington.gabrieladumar.Mantenimiento.repository.TipoServicioRepository;

@Service
public class ServicioService {

    @Autowired
    private ServicioRepository servicioRepository;

    @Autowired
    private TipoServicioRepository tipoServicioRepository;

    @Autowired
    private TecnicoRepository tecnicoRepository;


    // =====================================================
    // OBTENER TODOS LOS SERVICIOS
    // =====================================================

    public List<Servicio> obtenerTodosServicios() {

        return servicioRepository.findAll();
    }


    // =====================================================
    // OBTENER TIPOS DE SERVICIO
    // =====================================================

    public List<TipoServicio> obtenerTodosTiposServicio() {

        return tipoServicioRepository.findAll();
    }


    // =====================================================
    // OBTENER SERVICIOS DE UN TÉCNICO
    // =====================================================

    public List<Servicio> obtenerServiciosPorTecnico(
            Integer idTec) {

        return servicioRepository
                .findByTecnico_IdTec(idTec);
    }


    // =====================================================
    // OBTENER SERVICIOS ACEPTADOS DE UN TÉCNICO
    // =====================================================

    public List<Servicio> obtenerServiciosAceptadosPorTecnico(
            Integer idTec) {

        return servicioRepository
                .findByTecnico_IdTecAndEstadoSer(
                        idTec,
                        "Aceptado"
                );
    }


    // =====================================================
    // REGISTRAR SERVICIO
    // =====================================================

    public Servicio registrarServicio(
            Integer idTipoServicio,
            Integer idTecnico,
            BigDecimal precio,
            String estado,
            LocalDate fecha,
            String descripcion) {

        Servicio servicio = new Servicio();

        TipoServicio tipo =
                tipoServicioRepository
                        .findById(idTipoServicio)
                        .orElseThrow(() ->
                                new RuntimeException(
                                        "No se encontró el tipo de servicio"
                                )
                        );

        Tecnico tecnico =
                tecnicoRepository
                        .findById(idTecnico)
                        .orElseThrow(() ->
                                new RuntimeException(
                                        "No se encontró el técnico"
                                )
                        );

        servicio.setTipoServicio(tipo);
        servicio.setTecnico(tecnico);
        servicio.setPrecioSer(precio);
        servicio.setEstadoSer(estado);
        servicio.setFechaSer(fecha);
        servicio.setDescripcionSer(descripcion);

        return servicioRepository.save(servicio);
    }


    // =====================================================
    // GUARDAR SERVICIO
    // =====================================================

    public Servicio guardarServicio(
            Servicio servicio) {

        return servicioRepository.save(servicio);
    }


    // =====================================================
    // ACEPTAR SERVICIO
    // =====================================================

    public Servicio aceptarServicio(
            Integer idSer) {

        Servicio servicio =
                servicioRepository
                        .findById(idSer)
                        .orElseThrow(() ->
                                new RuntimeException(
                                        "No se encontró el servicio con ID: "
                                                + idSer
                                )
                        );

        servicio.setEstadoSer("Aceptado");

        return servicioRepository.save(servicio);
    }


    // =====================================================
    // RECHAZAR SERVICIO
    // =====================================================

    public Servicio rechazarServicio(
            Integer idSer) {

        Servicio servicio =
                servicioRepository
                        .findById(idSer)
                        .orElseThrow(() ->
                                new RuntimeException(
                                        "No se encontró el servicio con ID: "
                                                + idSer
                                )
                        );

        servicio.setEstadoSer("Rechazado");

        return servicioRepository.save(servicio);
    }


    // =====================================================
    // ACTUALIZAR ESTADO DEL SERVICIO
    // =====================================================

    public Servicio actualizarEstadoServicio(
            Integer idSer,
            String estado) {

        Servicio servicio =
                servicioRepository
                        .findById(idSer)
                        .orElseThrow(() ->
                                new RuntimeException(
                                        "Servicio no encontrado con ID: "
                                                + idSer
                                )
                        );

        if (!estado.equalsIgnoreCase("Pendiente")
                && !estado.equalsIgnoreCase("Aceptado")
                && !estado.equalsIgnoreCase("Rechazado")) {

            throw new RuntimeException(
                    "Estado no válido. Use: Pendiente, Aceptado o Rechazado"
            );
        }

        if (estado.equalsIgnoreCase("Pendiente")) {
            servicio.setEstadoSer("Pendiente");
        }

        if (estado.equalsIgnoreCase("Aceptado")) {
            servicio.setEstadoSer("Aceptado");
        }

        if (estado.equalsIgnoreCase("Rechazado")) {
            servicio.setEstadoSer("Rechazado");
        }

        return servicioRepository.save(servicio);
    }
}