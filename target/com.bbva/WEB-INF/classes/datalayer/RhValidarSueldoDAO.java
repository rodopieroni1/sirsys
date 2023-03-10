// 
// Decompiled by Procyon v0.5.36
// 

package validacionSueldo.datalayer;

import java.util.Date;
import java.util.Iterator;
import java.util.List;
import ar.com.itrsa.GeneralException;
import org.apache.commons.beanutils.DynaBean;
import java.util.ArrayList;
import ar.com.itrsa.sam.factory.SAMReference;
import java.util.HashMap;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.logging.Log;
import gral.SAMConnection;

public class RhValidarSueldoDAO extends SAMConnection
{
    private static final Log log;
    
    static {
        log = LogFactory.getLog((Class)RhValidarSueldoDAO.class);
    }
    
    public String reportes(final String usuarioCorpo) {
        String jsonResp = "[";
        final HashMap parameters = new HashMap();
        parameters.put("P_USUARIO_CORPO", usuarioCorpo);
        try {
            parameters.put("P_USUARIO_CORPO", usuarioCorpo);
            (RhValidarSueldoDAO.sam = SAMReference.getSAM()).execute("TM_RRHH_imp_cruces.sirpr_supervisados", getSamContext(), (Object)parameters);
            final List rs = parameters.get("O_DATOSCUR");
            for (final DynaBean obj : rs) {
                jsonResp = String.valueOf(jsonResp) + "\"" + obj.get("EMPLEADO") + "\",";
            }
            if (jsonResp.length() > 0) {
                jsonResp = jsonResp.substring(0, jsonResp.length() - 1);
            }
            jsonResp = String.valueOf(jsonResp) + "]";
        }
        catch (GeneralException e) {
            e.printStackTrace();
        }
        return jsonResp;
    }
    
    public String motivosAjuste() {
        String jsonResp = "[";
        final HashMap parameters = new HashMap();
        try {
            (RhValidarSueldoDAO.sam = SAMReference.getSAM()).execute("TM_RRHH_imp_cruces.sirpr_motivos_ajustes", getSamContext(), (Object)parameters);
            final List rs = parameters.get("O_DATOSCUR");
            for (final DynaBean obj : rs) {
                jsonResp = String.valueOf(jsonResp) + "\"" + (String)obj.get("MOTIVO") + "\",";
            }
            if (jsonResp.length() > 0) {
                jsonResp = jsonResp.substring(0, jsonResp.length() - 1);
            }
            jsonResp = String.valueOf(jsonResp) + "]";
        }
        catch (GeneralException e) {
            e.printStackTrace();
        }
        return jsonResp;
    }
    
    public String datosEmple(final String pusuario) {
        String jsonResp = "{";
        final HashMap parameters = new HashMap();
        parameters.put("P_USUARIO", pusuario);
        try {
            (RhValidarSueldoDAO.sam = SAMReference.getSAM()).execute("TM_RRHH_imp_cruces.sirpr_datos_emplesup", getSamContext(), (Object)parameters);
            jsonResp = String.valueOf(jsonResp) + "\"usuario\":" + "\"" + parameters.get("USUARIO") + "\",";
            jsonResp = String.valueOf(jsonResp) + "\"nombre_apellido\":" + "\"" + parameters.get("NOMBRE_APELLIDO") + "\",";
            jsonResp = String.valueOf(jsonResp) + "\"puesto\":" + "\"" + parameters.get("PUESTO") + "\",";
            jsonResp = String.valueOf(jsonResp) + "\"unidad\":" + "\"" + parameters.get("UNIDAD") + "\",";
            jsonResp = String.valueOf(jsonResp) + "\"empresa\":" + "\"" + parameters.get("EMPRESA") + "\",";
            jsonResp = String.valueOf(jsonResp) + "\"rtm\":" + "\"" + parameters.get("RTM") + "\",";
            jsonResp = String.valueOf(jsonResp) + "\"adic_falla\":" + "\"" + parameters.get("ADIC_FALLA") + "\",";
            jsonResp = String.valueOf(jsonResp) + "\"conf\":" + "\"" + parameters.get("CONF") + "\",";
            jsonResp = String.valueOf(jsonResp) + "\"comp_pos\":" + "\"" + parameters.get("COMP_POS") + "\",";
            jsonResp = String.valueOf(jsonResp) + "\"bt\":" + "\"" + parameters.get("BT") + "\",";
            jsonResp = String.valueOf(jsonResp) + "\"bono_a\":" + "\"" + parameters.get("BONOA") + "\",";
            jsonResp = String.valueOf(jsonResp) + "\"bono_b\":" + "\"" + parameters.get("BONOB") + "\",";
            jsonResp = String.valueOf(jsonResp) + "\"bono_c\":" + "\"" + parameters.get("BONOC") + "\",";
            jsonResp = String.valueOf(jsonResp) + "\"posicion\":" + "\"" + parameters.get("POSICION") + "\",";
            jsonResp = String.valueOf(jsonResp) + "\"bono_sugerido\":" + "\"" + parameters.get("BONO_SUGERIDO") + "\",";
            jsonResp = String.valueOf(jsonResp) + "\"id_mapa_talento\":" + "\"" + parameters.get("PO_ID_MAPA_TALENTO") + "\",";
            jsonResp = String.valueOf(jsonResp) + "\"id_potencial\":" + "\"" + parameters.get("PO_ID_POTENCIAL") + "\",";
            jsonResp = String.valueOf(jsonResp) + "\"id_performance\":" + "\"" + parameters.get("PO_ID_PERFORMANCE") + "\"";
            jsonResp = String.valueOf(jsonResp) + "}";
        }
        catch (GeneralException e) {
            e.printStackTrace();
        }
        return jsonResp;
    }
    
    public String validar(final String pusuario, final String motivo) {
        String jsonResp = "[";
        final HashMap parameters = new HashMap();
        parameters.put("P_USUARIO_CORPO", pusuario);
        parameters.put("P_MOTIVO_AJUSTE", motivo);
        try {
            (RhValidarSueldoDAO.sam = SAMReference.getSAM()).execute("TM_RRHH_imp_cruces.sirpr_valida_antes_aumento", getSamContext(), (Object)parameters);
            final List rs = parameters.get("O_DATOSCUR");
            final Iterator it = rs.iterator();
            while (it.hasNext()) {
                jsonResp = String.valueOf(jsonResp) + "{";
                final DynaBean obj = it.next();
                jsonResp = String.valueOf(jsonResp) + "\"descripcion\":" + "\"" + (String)obj.get("N_DESCRIPCION") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"resultado\":" + "\"" + (String)obj.get("CK_RESULTADO") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"bloqueante\":" + "\"" + (String)obj.get("CK_BLOQUEANTE") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"id_solicitud\":" + "\"" + (String)obj.get("ID_SOLICITUD") + "\"";
                jsonResp = String.valueOf(jsonResp) + "},";
            }
            if (jsonResp.length() > 0) {
                jsonResp = jsonResp.substring(0, jsonResp.length() - 1);
            }
            jsonResp = String.valueOf(jsonResp) + "]";
        }
        catch (GeneralException e) {
            e.printStackTrace();
        }
        return jsonResp;
    }
    
    public String jp(final String pusuario) {
        String jsonResp = "[";
        final HashMap parameters = new HashMap();
        parameters.put("P_USUARIO_CORPO", pusuario);
        try {
            (RhValidarSueldoDAO.sam = SAMReference.getSAM()).execute("TM_RRHH_imp_cruces.sirpr_jp", getSamContext(), (Object)parameters);
            final List rs = parameters.get("O_DATOSCUR");
            for (final DynaBean obj : rs) {
                jsonResp = String.valueOf(jsonResp) + "\"" + (String)obj.get("PUESTO") + "\",";
            }
            if (jsonResp.length() > 0) {
                jsonResp = jsonResp.substring(0, jsonResp.length() - 1);
            }
            jsonResp = String.valueOf(jsonResp) + "]";
        }
        catch (GeneralException e) {
            e.printStackTrace();
        }
        return jsonResp;
    }
    
    public String supervisory() {
        String jsonResp = "[";
        final HashMap parameters = new HashMap();
        try {
            (RhValidarSueldoDAO.sam = SAMReference.getSAM()).execute("TM_RRHH_imp_cruces.sirpr_supervisory", getSamContext(), (Object)parameters);
            final List rs = parameters.get("O_DATOSCUR");
            for (final DynaBean obj : rs) {
                jsonResp = String.valueOf(jsonResp) + "\"" + (String)obj.get("UNIDAD") + "\",";
            }
            if (jsonResp.length() > 0) {
                jsonResp = jsonResp.substring(0, jsonResp.length() - 1);
            }
            jsonResp = String.valueOf(jsonResp) + "]";
        }
        catch (GeneralException e) {
            e.printStackTrace();
        }
        return jsonResp;
    }
    
    public String empresa() {
        String jsonResp = "[";
        final HashMap parameters = new HashMap();
        try {
            (RhValidarSueldoDAO.sam = SAMReference.getSAM()).execute("TM_RRHH_imp_cruces.sirpr_empresa", getSamContext(), (Object)parameters);
            final List rs = parameters.get("O_DATOSCUR");
            for (final DynaBean obj : rs) {
                jsonResp = String.valueOf(jsonResp) + "\"" + (String)obj.get("EMPRESA") + "\",";
            }
            if (jsonResp.length() > 0) {
                jsonResp = jsonResp.substring(0, jsonResp.length() - 1);
            }
            jsonResp = String.valueOf(jsonResp) + "]";
        }
        catch (GeneralException e) {
            e.printStackTrace();
        }
        return jsonResp;
    }
    
    public String posicionaNuevo(final String pusuario, final String nuevoJP, final String nuevoSueldo) {
        String jsonResp = "{";
        final HashMap parameters = new HashMap();
        parameters.put("P_USUARIO", pusuario);
        parameters.put("P_NUEVO_JP", nuevoJP);
        parameters.put("P_SUELDO_NUEVO", nuevoSueldo);
        try {
            (RhValidarSueldoDAO.sam = SAMReference.getSAM()).execute("TM_RRHH_imp_cruces.sirpr_posiciona_nuevo", getSamContext(), (Object)parameters);
            jsonResp = String.valueOf(jsonResp) + "\"nueva_pos\":" + "\"" + parameters.get("P_NUEVA_POS") + "\"";
            jsonResp = String.valueOf(jsonResp) + "}";
        }
        catch (GeneralException e) {
            e.printStackTrace();
        }
        return jsonResp;
    }
    
    public void registrarSolicitud(final String idSolicitud, final String usuarioCorpoSuper, final String usuarioCorpoEmpleado, final String idMotivoAjuste, final Date fecSimulacion, final String idJobProfile, final String idSupervisory, final String idEmpresa, final String zonaDesfavorable, final String rtm, final String conformado, final String complemento, final String adicionalFalla, final String remuneracionTot, final String bt, final String idMapaTalento, final String performance, final String potencial, final String idJobProfileNuevo, final String idSupervisoryNueva, final String idEmpresaNueva, final String importeAjustar, final String porcentajeAjustar, final String remuneracionTotalNueva, final String btPropuesto, final String observaciones, final String posicionamiento, final String bonoSugerido) {
        final HashMap parameters = new HashMap();
        parameters.put("P_ID_SOLICITUD", idSolicitud);
        parameters.put("P_USUARIO_CORPO_SUPER", Super);
        parameters.put("P_USUARIO_CORPO_EMPLEADO", Empleado);
        parameters.put("P_ID_MOTIVO_AJUSTE", idMotivoAjuste);
        parameters.put("P_FEC_SIMULACION", fecSimulacion);
        parameters.put("P_ID_JOB_PROFILE", idJobProfile);
        parameters.put("P_ID_SUPERVISORY", idSupervisory);
        parameters.put("P_ID_EMPRESA", idEmpresa);
        parameters.put("P_ZONA_DESFAVORABLE", zonaDesfavorable);
        parameters.put("P_RTM", rtm);
        parameters.put("P_CONFORMADO", conformado);
        parameters.put("P_COMPLEMENTO", complemento);
        parameters.put("P_ADIC_FALLA_CONV", adicionalFalla);
        parameters.put("P_REMUNERACION_TOT", remuneracionTot);
        parameters.put("P_BT", bt);
        parameters.put("P_ID_MAPA_TALENTO", idMapaTalento);
        parameters.put("P_PERFORMANCE", performance);
        parameters.put("P_POTENCIAL", potencial);
        parameters.put("P_ID_JOB_PROFILE_NUEVO", idJobProfileNuevo);
        parameters.put("P_ID_SUPERVISORY_NUEVA", idSupervisoryNueva);
        parameters.put("P_ID_EMPRESA_NUEVA", idEmpresaNueva);
        parameters.put("P_IMPORTE_AJUSTAR", importeAjustar);
        parameters.put("P_PORCENTAJE_AJUSTAR", porcentajeAjustar);
        parameters.put("p_REMUNERACION_TOT_NUEVA", remuneracionTotalNueva);
        parameters.put("P_BT_PROPUESTO", btPropuesto);
        parameters.put("P_OBSERVACIONES", observaciones);
        parameters.put("P_POSICIONAMIENTO", posicionamiento);
        parameters.put("P_BONO_SUGERIDO", bonoSugerido);
        try {
            (RhValidarSueldoDAO.sam = SAMReference.getSAM()).execute("TM_RRHH_imp_cruces.sirpr_ins_solicitud_aumentos", getSamContext(), (Object)parameters);
        }
        catch (GeneralException e) {
            e.printStackTrace();
        }
    }
    
    public String validarPost(final String idSolicitud, final String pusuario, final String nuevoJP, final String importe, final String porcentaje, final String motivoAjuste) {
        String jsonResp = "[";
        final HashMap parameters = new HashMap();
        parameters.put("P_ID_SOLICITUD", idSolicitud);
        parameters.put("P_USUARIO", pusuario);
        parameters.put("P_NUEVO_JP", nuevoJP);
        parameters.put("P_IMPORTE", importe);
        parameters.put("P_PORCENTAJE", porcentaje);
        parameters.put("P_ID_MOTIVO", motivoAjuste);
        try {
            (RhValidarSueldoDAO.sam = SAMReference.getSAM()).execute("TM_RRHH_imp_cruces.sirpr_valida_post_aumento", getSamContext(), (Object)parameters);
            final List rs = parameters.get("O_DATOSCUR");
            final Iterator it = rs.iterator();
            while (it.hasNext()) {
                jsonResp = String.valueOf(jsonResp) + "{";
                final DynaBean obj = it.next();
                jsonResp = String.valueOf(jsonResp) + "\"mensaje\":" + "\"" + (String)obj.get("X_MENSAJE") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"resultado\":" + "\"" + (String)obj.get("CK_RESULTADO") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"bloqueante\":" + "\"" + (String)obj.get("CK_BLOQUEANTE") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"id_solicitud\":" + "\"" + (String)obj.get("ID_SOLICITUD") + "\"";
                jsonResp = String.valueOf(jsonResp) + "},";
            }
            if (jsonResp.length() > 0) {
                jsonResp = jsonResp.substring(0, jsonResp.length() - 1);
            }
            jsonResp = String.valueOf(jsonResp) + "]";
        }
        catch (GeneralException e) {
            RhValidarSueldoDAO.log.error((Object)("VALIDAR_POST: Error: " + e));
        }
        return jsonResp;
    }
    
    public String historico(final String pusuario, final Date fechaDesde, final Date fechaHasta) {
        String jsonResp = "[";
        final HashMap parameters = new HashMap();
        RhValidarSueldoDAO.log.info((Object)("HISTORICA: Estoy en el DAO, vamos a meter los datos: " + pusuario + " " + fechaDesde + " " + fechaHasta));
        parameters.put("P_USUARIO_CORPO_SUPER", pusuario);
        parameters.put("P_FEC_SIMULACION_DESDE", fechaDesde);
        parameters.put("P_FEC_SIMULACION_HASTA", fechaHasta);
        try {
            RhValidarSueldoDAO.sam = SAMReference.getSAM();
            RhValidarSueldoDAO.log.info((Object)"HISTARICA: Antes del execute");
            RhValidarSueldoDAO.sam.execute("TM_RRHH_imp_cruces.sirpr_hist_sol_aumentos", getSamContext(), (Object)parameters);
            RhValidarSueldoDAO.log.info((Object)"HISTARICA: Despues del execute");
            final List rs = parameters.get("O_DATOSCUR");
            final Iterator it = rs.iterator();
            while (it.hasNext()) {
                jsonResp = String.valueOf(jsonResp) + "{";
                final DynaBean obj = it.next();
                jsonResp = String.valueOf(jsonResp) + "\"id_solicitud\":" + "\"" + (String)obj.get("ID_SOLICITUD") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"usuario_corpo_super\":" + "\"" + (String)obj.get("USUARIO_CORPO_SUPER") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"apellido_nombre_super\":" + "\"" + (String)obj.get("AP_NOM_SUP") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"usuario_corpo_empleado\":" + "\"" + (String)obj.get("USUARIO_CORPO_EMPLEADO") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"apellido_nombre_empleado\":" + "\"" + (String)obj.get("AP_NOM_EMPLEADO") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"id_motivo_ajuste\":" + "\"" + (String)obj.get("ID_MOTIVO_AJUSTE") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"descripcion_motivo\":" + "\"" + (String)obj.get("N_DESCRIPCION") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"fec_simulacion\":" + "\"" + (String)obj.get("FEC_SIMULACION") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"id_job_profile\":" + "\"" + (String)obj.get("ID_JOB_PROFILE") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"descripcion_puesto\":" + "\"" + (String)obj.get("N_PUESTO") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"id_supervisory\":" + "\"" + (String)obj.get("ID_SUPERVISORY") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"descripcion_unidad\":" + "\"" + (String)obj.get("N_UNIDAD") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"id_empresa\":" + "\"" + (String)obj.get("ID_EMPRESA") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"descripcion_empresa\":" + "\"" + (String)obj.get("N_EMPRESA") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"ck_zona_desfavorable\":" + "\"" + (String)obj.get("CK_ZONA_DESFAVORABLE") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"rtm\":" + "\"" + (String)obj.get("RTM") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"conformado\":" + "\"" + (String)obj.get("CONFORMADO") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"complemento\":" + "\"" + (String)obj.get("COMPLEMENTO") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"adic_falla\":" + "\"" + (String)obj.get("ADIC_FALLA_CONV") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"bt\":" + "\"" + (String)obj.get("BT") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"id_mapa_talento\":" + "\"" + (String)obj.get("ID_MAPA_TALENTO") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"performance\":" + "\"" + (String)obj.get("PERFORMANCE") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"potencial\":" + "\"" + (String)obj.get("POTENCIAL") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"id_job_profile_nuevo\":" + "\"" + (String)obj.get("ID_JOB_PROFILE_NUEVO") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"descripcion_puesto_nuevo\":" + "\"" + (String)obj.get("N_PUESTO") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"id_supervisory_nueva\":" + "\"" + (String)obj.get("ID_SUPERVISORY_NUEVA") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"descripcion_unidad_nueva\":" + "\"" + (String)obj.get("N_UNIDAD") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"id_empresa_nueva\":" + "\"" + (String)obj.get("ID_EMPRESA_NUEVA") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"descripcion_empresa_nueva\":" + "\"" + (String)obj.get("N_EMPRESA") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"remuneracion_tot\":" + "\"" + (String)obj.get("REMUNERACION_TOT") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"importe_ajustar\":" + "\"" + (String)obj.get("IMPORTE_AJUSTAR") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"porcentaje_ajustar\":" + "\"" + (String)obj.get("PORCENTAJE_AJUSTAR") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"remuneracion_total_nueva\":" + "\"" + (String)obj.get("REMUNERACION_TOT_NUEVA") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"bt_propuesto\":" + "\"" + (String)obj.get("BT_PROPUESTO") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"observaciones\":" + "\"" + (String)obj.get("OBSERVACIONES") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"posicionamiento\":" + "\"" + (String)obj.get("POSICIONAMIENTO") + "\",";
                jsonResp = String.valueOf(jsonResp) + "\"bono_sugerido\":" + "\"" + (String)obj.get("BONO_SUGERIDO") + "\"";
                jsonResp = String.valueOf(jsonResp) + "},";
            }
            if (jsonResp.length() > 0) {
                jsonResp = jsonResp.substring(0, jsonResp.length() - 1);
            }
            jsonResp = String.valueOf(jsonResp) + "]";
        }
        catch (GeneralException e) {
            e.printStackTrace();
            RhValidarSueldoDAO.log.error((Object)("sirpr_hist_sol_aumentos ERROR: " + e));
        }
        return jsonResp;
    }
}
