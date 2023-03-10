// 
// Decompiled by Procyon v0.5.36
// 

package precargaliq.bizlayer;

import adelantoSueldo.datalayer.AdelantoSueldoDAO;
import precargaliq.datalayer.RhCargarDelegacion;
import precargaliq.datalayer.RhDatosAusentismo;
import java.text.SimpleDateFormat;
import precargaliq.datalayer.RhCrucesPresentismo;
import beneficios.datalayer.BeneficiosDAO;
import liquidacion.datalayer.RhCuentaCorrienteDAO;
import ar.com.itrsa.GeneralException;
import java.text.ParseException;
import gym.administrador.datalayer.ClasesDAO;
import validacionSueldo.datalayer.RhValidarSueldoDAO;
import java.util.Iterator;
import java.util.List;
import java.io.PrintWriter;
import java.util.Date;
import java.io.BufferedReader;
import gral.MsgException;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import java.io.File;
import rhgral.valueobj.RhGralLegajo;
import rhgral.bizlayer.RhGralSessAdmLegajos;
import rhgral.present.RhGralAppSessionContext;
import org.json.JSONException;
import org.json.JSONObject;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.logging.Log;
import javax.servlet.http.HttpServlet;

public class RhCrucesPresentismoServlet extends HttpServlet
{
    private static final long serialVersionUID = 1L;
    private static final Log log;
    private static final String UPLOAD_DIRECTORY = "prepFile";
    private static final String UPLOAD_DIRECTORY_GESTOR_CONTENIDO = "gestFile";
    private static final int MEMORY_THRESHOLD = 3145728;
    private static final int MAX_FILE_SIZE = 41943040;
    private static final int MAX_REQUEST_SIZE = 52428800;
    private static final String Encoding = "UTF-8";
    private static final String CotentType = "application/json";
    private static final String REPORTES_ACTION = "reportes";
    private static final String MOTIVOS_ACTION = "motivos";
    private static final String DATOSEMPLE_ACTION = "datosemple";
    private static final String VALIDAR_ACTION = "validar";
    private static final String JP_ACTION = "jp";
    private static final String SUPERVISORY_ACTION = "supervisory";
    private static final String EMPRESA_ACTION = "empresa";
    private static final String POSICIONA_ACTION = "posiciona";
    private static final String VALIDARPOST_ACTION = "validarpost";
    private static final String REGISTRAR_ACTION = "registrar";
    private static final String HISTORICO_ACTION = "historico";
    
    static {
        log = LogFactory.getLog((Class)RhCrucesPresentismoServlet.class);
    }
    
    public void doPost(final HttpServletRequest req, final HttpServletResponse resp) throws ServletException, IOException {
        this.doExecute(req, resp);
    }
    
    public void doGet(final HttpServletRequest req, final HttpServletResponse resp) throws ServletException, IOException {
        this.doExecute(req, resp);
    }
    
    private void doExecute(final HttpServletRequest req, final HttpServletResponse resp) throws ServletException, IOException {
        String json = "";
        final String action = req.getParameter("action");
        if ("reportes".equals(action)) {
            resp.setContentType("application/json");
            resp.setCharacterEncoding("ISO-8859-1");
            final BufferedReader br = req.getReader();
            final char[] buff = new char[30];
            br.read(buff);
            String body = "";
            char[] array;
            for (int length = (array = buff).length, i = 0; i < length; ++i) {
                final char ch = array[i];
                if (ch != '\0') {
                    body = String.valueOf(body) + ch;
                }
            }
            try {
                final JSONObject object = new JSONObject(body);
                final String usuarioCorpo = object.getString("usuarioCorpo");
                json = this.getReportes(usuarioCorpo);
                resp.getOutputStream().print(json);
            }
            catch (JSONException e) {
                e.printStackTrace();
            }
        }
        if ("motivos".equals(action)) {
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            json = this.getMotivos();
            resp.getOutputStream().print(json);
        }
        if ("datosemple".equals(action)) {
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            final BufferedReader br = req.getReader();
            final char[] buff = new char[30];
            br.read(buff);
            String body = "";
            char[] array2;
            for (int length2 = (array2 = buff).length, j = 0; j < length2; ++j) {
                final char ch = array2[j];
                if (ch != '\0') {
                    body = String.valueOf(body) + ch;
                }
            }
            try {
                final JSONObject object = new JSONObject(body);
                final String usuarioCorpo = object.getString("usuarioCorpo");
                json = this.getDatosEmple(usuarioCorpo);
                resp.getOutputStream().print(json);
            }
            catch (JSONException e) {
                e.printStackTrace();
            }
        }
        if ("validar".equals(action)) {
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            final BufferedReader br = req.getReader();
            final char[] buff = new char[40];
            br.read(buff);
            String body = "";
            char[] array3;
            for (int length3 = (array3 = buff).length, k = 0; k < length3; ++k) {
                final char ch = array3[k];
                if (ch != '\0') {
                    body = String.valueOf(body) + ch;
                }
            }
            try {
                final JSONObject object = new JSONObject(body);
                final String pusuario = object.getString("pusuario");
                final String motivo = object.getString("motivo");
                json = this.getValidacion(pusuario, motivo);
                resp.getOutputStream().print(json);
            }
            catch (JSONException e) {
                e.printStackTrace();
            }
        }
        if ("jp".equals(action)) {
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            final BufferedReader br = req.getReader();
            final char[] buff = new char[30];
            br.read(buff);
            String body = "";
            char[] array4;
            for (int length4 = (array4 = buff).length, l = 0; l < length4; ++l) {
                final char ch = array4[l];
                if (ch != '\0') {
                    body = String.valueOf(body) + ch;
                }
            }
            try {
                final JSONObject object = new JSONObject(body);
                final String pusuario = object.getString("pusuario");
                json = this.getJP(pusuario);
                resp.getOutputStream().print(json);
            }
            catch (JSONException e) {
                e.printStackTrace();
            }
        }
        if ("supervisory".equals(action)) {
            resp.setContentType("application/json");
            json = this.getSupervisory();
            resp.setCharacterEncoding("ISO-8859-1");
            resp.getOutputStream().print(json);
        }
        if ("empresa".equals(action)) {
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            json = this.getEmpresa();
            resp.getOutputStream().print(json);
        }
        if ("posiciona".equals(action)) {
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            final BufferedReader br = req.getReader();
            final char[] buff = new char[70];
            br.read(buff);
            String body = "";
            char[] array5;
            for (int length5 = (array5 = buff).length, n = 0; n < length5; ++n) {
                final char ch = array5[n];
                if (ch != '\0') {
                    body = String.valueOf(body) + ch;
                }
            }
            try {
                final JSONObject object = new JSONObject(body);
                final String pusuario = object.getString("pusuario");
                final String nuevoJP = object.getString("nuevoJP");
                final String nuevoSueldo = object.getString("nuevoSueldo");
                json = this.getPosicionamientoNuevo(pusuario, nuevoJP, nuevoSueldo);
                resp.getOutputStream().print(json);
            }
            catch (JSONException e) {
                e.printStackTrace();
            }
        }
        if ("registrar".equals(action)) {
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            final BufferedReader br = req.getReader();
            final char[] buff = new char[700];
            br.read(buff);
            String body = "";
            char[] array6;
            for (int length6 = (array6 = buff).length, n2 = 0; n2 < length6; ++n2) {
                final char ch = array6[n2];
                if (ch != '\0') {
                    body = String.valueOf(body) + ch;
                }
            }
            try {
                final JSONObject object = new JSONObject(body);
                final String idSolicitud = object.getString("idSolicitud");
                final String usuarioCorpoSuper = object.getString("usuarioCorpoSuper");
                final String usuarioCorpoEmpleado = object.getString("usuarioCorpoEmpleado");
                final String idMotivoAjuste = object.getString("idMotivoAjuste");
                final Date fecSimulacion = this.fechaStrADate(object.getString("fecSimulacion"));
                final String idJobProfile = object.getString("idJobProfile");
                final String idSupervisory = object.getString("idSupervisory");
                final String idEmpresa = object.getString("idEmpresa");
                final String zonaDesfavorable = null;
                final String rtm = object.getString("rtm");
                final String conformado = object.getString("conformado");
                final String complemento = object.getString("complemento");
                final String adicionalFalla = object.getString("adicFalla");
                final String remuneracionTot = object.getString("remuneracionTot");
                final String bt = object.getString("bt");
                final String idMapaTalento = object.getString("idMapaTalento");
                final String performance = object.getString("performance");
                final String potencial = object.getString("potencial");
                final String idJobProfileNuevo = object.getString("idJobProfileNuevo");
                final String idSupervisoryNueva = object.getString("idSupervisoryNueva");
                final String idEmpresaNueva = object.getString("idEmpresaNueva");
                final String importeAjustar = object.getString("importe");
                final String porcentajeAjustar = object.getString("porcentaje");
                final String remuneracionTotNueva = object.getString("remuneracionTotalNueva");
                final String btPropuesto = object.getString("btPropuesto");
                final String observaciones = null;
                final String posicionamiento = object.getString("posicionamiento");
                final String bonoSugerido = object.getString("bonoSugerido");
                this.registrarSolicitud(idSolicitud, usuarioCorpoSuper, usuarioCorpoEmpleado, idMotivoAjuste, fecSimulacion, idJobProfile, idSupervisory, idEmpresa, zonaDesfavorable, rtm, conformado, complemento, adicionalFalla, remuneracionTot, bt, idMapaTalento, performance, potencial, idJobProfileNuevo, idSupervisoryNueva, idEmpresaNueva, importeAjustar, porcentajeAjustar, remuneracionTotNueva, btPropuesto, observaciones, posicionamiento, bonoSugerido);
            }
            catch (JSONException e) {
                e.printStackTrace();
            }
        }
        if ("validarpost".equals(action)) {
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            final BufferedReader br = req.getReader();
            final char[] buff = new char[200];
            br.read(buff);
            String body = "";
            char[] array7;
            for (int length7 = (array7 = buff).length, n3 = 0; n3 < length7; ++n3) {
                final char ch = array7[n3];
                if (ch != '\0') {
                    body = String.valueOf(body) + ch;
                }
            }
            try {
                final JSONObject object = new JSONObject(body);
                final String idSolicitud = object.getString("idSolicitud");
                final String pusuario2 = object.getString("pusuario");
                final String nuevojp = object.getString("nuevojp");
                final String importe = object.getString("importe");
                final String porcentaje = object.getString("porcentaje");
                final String motivoAjuste = object.getString("motivoAjuste");
                json = this.getValidacionPost(idSolicitud, pusuario2, nuevojp, importe, porcentaje, motivoAjuste);
                resp.getOutputStream().print(json);
            }
            catch (JSONException e) {
                RhCrucesPresentismoServlet.log.info((Object)("VALIDARPOST: " + e.getMessage()));
                e.printStackTrace();
            }
        }
        if ("historico".equals(action)) {
            resp.setContentType("application/json");
            resp.setCharacterEncoding("ISO-8859-1");
            final String pusuario3 = req.getParameter("pusuario");
            final Date fechaDesde = this.fechaStrADate(req.getParameter("fec_simulacion_desde"));
            final Date fechaHasta = this.fechaStrADate(req.getParameter("fec_simulacion_hasta"));
            RhCrucesPresentismoServlet.log.info((Object)("HISTARICA: recibo los datos: " + pusuario3 + " " + fechaDesde + " " + fechaHasta));
            json = this.getHistorico(pusuario3, fechaDesde, fechaHasta);
            resp.getOutputStream().print(json);
        }
        RhGralLegajo legajo = null;
        final RhGralAppSessionContext asc = new RhGralAppSessionContext();
        try {
            legajo = asc.getLegajo(req.getSession());
            String out = "";
            final String idLegajo = legajo.getNumeroLegajo();
            String idSociedad = legajo.getSociedad();
            if (idSociedad == null) {
                idSociedad = this.pr_legajo_de_un_usuario(legajo.getUsrId());
            }
            if ("consultaReporteCruces".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.consultaCruces(req, resp);
            }
            else if ("justificaAusentismo".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.justificaAusentismo(req, resp);
            }
            else if ("unidadesOrg".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.consultaAreasSupervisadas(req, resp);
            }
            else if ("empleados".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.consultaEmpleados(req, resp);
            }
            else if ("supervisores".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.consultaSupervisores(req, resp);
            }
            else if ("empleadosSupervisados".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.consultaEmpleadosSupervisados(req, resp);
            }
            else if ("consultaInicialCrucesJustificar".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.consultaInicialCrucesJustificar(req, resp);
            }
            else if ("consultaFiltradoCrucesJustificar".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.consultaCrucesJustificar(req, resp);
            }
            else if ("consultaSelectJustificar".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.consultaSelectJustificar(req, resp);
            }
            else if ("consultaSelectJustificacionesCruces".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.consultaSelectJustificacionesCruces(req, resp);
            }
            else if ("consultaSelectJustificacionesCrucesMasivo".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.consultaSelectJustificacionesCrucesMasivo(req, resp);
            }
            else if ("autorizaCruces".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = "1";
            }
            else if ("supervisoresAsociados".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.cargaSupervisoresPorArea(req, resp);
            }
            else if ("empeladosAsociados".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.cargaEmpleadosPorSupervisor(req, resp);
            }
            else if ("empeladosPorArea".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.cargarEmpleadosPorArea(req, resp);
            }
            else if ("grabarHorasComboJust".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.graboEmpleadosComboJust(req, legajo.getUsrId());
            }
            else if ("empleadosDelegados_miras_miv".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.consultaEmpleadosDelegados_miras_miv(req, resp, legajo);
            }
            else if ("empleadosDelegados".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.consultaEmpleadosDelegados(req, resp, legajo);
            }
            else if ("cargarDelegacion".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.cargarDelegacion(req, resp, legajo);
            }
            else if ("consultaInicialDelegaciones_miras_miv".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.consultaInicialDelegaciones_miras_miv(req, resp, legajo);
            }
            else if ("consultaInicialDelegaciones".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.consultaInicialDelegaciones(req, resp, legajo);
            }
            else if ("eliminarDelegacion".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.eliminarDelegacion(req, resp, legajo);
            }
            else if ("datosCuentaCorriente".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.datosCuentaCorriente(req, resp, legajo);
            }
            else if ("archivosEstAdmin".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.getArchivosEstAdmin(req, resp, legajo);
            }
            else if ("archivosGestCont".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.getGrillaArchivosGestorContenidos(req, resp, legajo);
            }
            else if ("archivosPrepagas".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.getArchivosPrepagas(req, resp, legajo);
            }
            else if ("datosCuentaCorrienteDetalle".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.datosCuentaCorrienteDetalle(req, resp, legajo);
            }
            else if ("datosFamiliares".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.datosFamiliares(req, resp, legajo);
            }
            else if ("contactoPrepagas".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.contactoPrepagas(req, resp, legajo);
            }
            else if ("datosSanatorios".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.datosSanatorios(req, resp, legajo);
            }
            else if ("getGrillaPDFPlanes".equals(action)) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                out = this.getGrillaPDFPlanes(req, resp, legajo);
            }
            else if ("consultarBenefFamilia".equals(action)) {
                resp.setContentType("application/xml");
                resp.setCharacterEncoding("UTF-8");
                out = this.consultarBenefFamilia(idLegajo, idSociedad, "DN");
            }
            else if ("consultarBenefFamiliaKE".equals(action)) {
                resp.setContentType("application/xml");
                resp.setCharacterEncoding("UTF-8");
                out = this.consultarBenefFamiliaKE(idLegajo, idSociedad, "KE");
            }
            else if ("datosEmpleado".equals(action)) {
                resp.setContentType("application/xml");
                resp.setCharacterEncoding("UTF-8");
                legajo = asc.getLegajo(req.getSession());
                out = this.consultarDatosEmpleado(idLegajo, idSociedad, legajo);
            }
            else if ("datosEnvio".equals(action)) {
                resp.setContentType("application/xml");
                resp.setCharacterEncoding("UTF-8");
                legajo = asc.getLegajo(req.getSession());
                final String beneficio = req.getParameter("benef");
                if (beneficio != null) {
                    if (beneficio.equalsIgnoreCase("KE")) {
                        out = this.consultarDatosEnvio(idLegajo, idSociedad, legajo, beneficio);
                    }
                }
                else {
                    out = this.consultarDatosEnvio(idLegajo, idSociedad, legajo, "DN");
                }
            }
            else if ("envioMailDireccion".equals(action)) {
                resp.setContentType("application/xml");
                resp.setCharacterEncoding("UTF-8");
                legajo = asc.getLegajo(req.getSession());
                final String asuntoMail = req.getParameter("asuntoMail");
                final String textoMail = req.getParameter("textoMail");
                out = this.envioMailDireccion(asuntoMail, textoMail, idLegajo, idSociedad);
            }
            else if ("consultaRRHHBeneficios".equals(action)) {
                resp.setContentType("application/xml");
                resp.setCharacterEncoding("UTF-8");
                final String txtLegajo = req.getParameter("txtLegajo").trim();
                final String tipoConsulta = req.getParameter("tipoConsulta");
                idSociedad = this.pr_legajo_de_un_usuario(txtLegajo);
                final RhGralSessAdmLegajos al = new RhGralSessAdmLegajos();
                final RhGralLegajo legajoConsulta = new RhGralLegajo();
                final String numeroLegajo = this.pr_nro_legajo_de_un_usuario(txtLegajo);
                legajoConsulta.setUsrId(txtLegajo.toUpperCase());
                legajoConsulta.setNumeroLegajo(numeroLegajo);
                al.obtenerLegajo(legajoConsulta);
                if ("consultarBenefFamiliaAdm".equals(tipoConsulta)) {
                    out = this.consultarBenefFamiliaAdm(numeroLegajo, idSociedad, "DN");
                }
                else if ("datosEmpleado".equals(tipoConsulta)) {
                    out = this.consultarDatosEmpleado(numeroLegajo, idSociedad, legajoConsulta);
                }
                else if ("datosEnvio".equals(tipoConsulta)) {
                    out = this.consultarDatosEnvio(numeroLegajo, idSociedad, legajoConsulta, "DN");
                }
            }
            else if ("tiposAnticipo".equals(action)) {
                out = this.consultarTiposAnticipo(req, idLegajo, idSociedad);
            }
            else if ("altaSolicitud".equals(action)) {
                legajo = asc.getLegajo(req.getSession());
                out = this.altaSolicitud(req, idLegajo, idSociedad, legajo);
            }
            else if ("listaAnticipos".equals(action)) {
                legajo = asc.getLegajo(req.getSession());
                out = this.listaAnticipos(req, idLegajo, idSociedad);
            }
            else if ("eliminarSolicitud".equals(action)) {
                legajo = asc.getLegajo(req.getSession());
                out = this.eliminarSolicitud(req, idLegajo, idSociedad);
            }
            else if ("updateSolicitud".equals(action)) {
                legajo = asc.getLegajo(req.getSession());
                out = this.updateSolicitud(req, idLegajo, idSociedad, legajo);
            }
            else if ("gymAction".equals(action)) {
                resp.setContentType("application/xml");
                resp.setCharacterEncoding("UTF-8");
                final String tipoConsulta2 = req.getParameter("tipoConsulta");
                if ("altaClase".equals(tipoConsulta2)) {
                    final String selectDisciplina = req.getParameter("selectDisciplina").trim();
                    final String selectDia = req.getParameter("selectDia").trim();
                    final String timepickerDesde = req.getParameter("timepickerDesde").trim();
                    final String timepickerHasta = req.getParameter("timepickerHasta").trim();
                    final String fechaDesde2 = req.getParameter("fechaDesde").trim();
                    final String fechaHasta2 = req.getParameter("fechaHasta").trim();
                    final String textAreaDescripcion = req.getParameter("textAreaDescripcion").trim();
                    final String inputCupo = req.getParameter("inputCupo").trim();
                    final String selectProfesor = req.getParameter("selectProfesor").trim();
                    final String idTipo = req.getParameter("idTipo").trim();
                    out = this.altaClase(selectDisciplina, idTipo, selectDia, timepickerDesde, timepickerHasta, fechaDesde2, fechaHasta2, textAreaDescripcion, inputCupo, selectProfesor);
                }
                else if ("updateClase".equals(tipoConsulta2)) {
                    final String selectDisciplina = req.getParameter("selectDisciplina").trim();
                    final String selectDia = req.getParameter("selectDia").trim();
                    final String clase = req.getParameter("clase").trim();
                    final String timepickerDesde2 = req.getParameter("timepickerDesde").trim();
                    final String timepickerHasta2 = req.getParameter("timepickerHasta").trim();
                    final String fechaDesde3 = req.getParameter("fechaDesde").trim();
                    final String fechaHasta3 = req.getParameter("fechaHasta").trim();
                    final String textAreaDescripcion2 = req.getParameter("textAreaDescripcion").trim();
                    final String inputCupo2 = req.getParameter("inputCupo").trim();
                    final String selectProfesor2 = req.getParameter("selectProfesor").trim();
                    final String idTipo2 = req.getParameter("idTipo").trim();
                    final String ckBorrado = req.getParameter("ckBorrado").trim();
                    out = this.updateClase(selectDisciplina, clase, selectDia, timepickerDesde2, timepickerHasta2, fechaDesde3, fechaHasta3, textAreaDescripcion2, inputCupo2, selectProfesor2, idTipo2, ckBorrado);
                }
                else if ("altaDisciplina".equals(tipoConsulta2)) {
                    final String inputNombreDis = req.getParameter("inputNombreDis").trim();
                    out = this.altaDisciplina(inputNombreDis);
                }
                else if ("consultaLegajo".equals(tipoConsulta2)) {
                    final String inputLegajoConsulta = req.getParameter("inputLegajoConsulta").trim();
                    out = this.consultarLegajo(inputLegajoConsulta);
                }
                else if ("consultaLegajoEM".equals(tipoConsulta2)) {
                    resp.setContentType("application/xml");
                    resp.setCharacterEncoding("UTF-8");
                    legajo = asc.getLegajo(req.getSession());
                    final String inputLegajoConsulta = legajo.getUsrId();
                    System.out.println("inputLegajoConsulta: " + inputLegajoConsulta);
                    System.out.println("inputLegajoConsulta: " + inputLegajoConsulta);
                    System.out.println("inputLegajoConsulta: " + inputLegajoConsulta);
                    System.out.println("inputLegajoConsulta: " + inputLegajoConsulta);
                    out = this.consultarLegajo(inputLegajoConsulta);
                }
                else if ("consultaDatosCargadosEmpleado".equals(tipoConsulta2)) {
                    final String inputLegajoConsulta = req.getParameter("inputLegajoConsulta").trim();
                    out = this.consultaDatosCargadosEmpleado(inputLegajoConsulta);
                }
                else if ("altaEmpleado".equals(tipoConsulta2)) {
                    final String sociedad = req.getParameter("sociedad").trim();
                    final String inputLegajoConsulta2 = req.getParameter("inputLegajoConsulta").trim();
                    final String fechaAltaEmpleado = req.getParameter("fechaAltaEmpleado").trim();
                    final String telefonoEmergencia = req.getParameter("telefonoEmergencia").trim();
                    final String aptoFisico = req.getParameter("aptoFisico").trim();
                    final String inputNombreMed = req.getParameter("inputNombreMed").trim();
                    final String inputMatriculaMed = req.getParameter("inputMatriculaMed").trim();
                    final String datepickerDia = req.getParameter("datepickerDia").trim();
                    final String inputDeportePref = req.getParameter("inputDeportePref").trim();
                    final String selectActFisica = req.getParameter("selectActFisica").trim();
                    final String selectFumador = req.getParameter("selectFumador").trim();
                    final String inputLesionFis = req.getParameter("inputLesionFis").trim();
                    final String inputPerentesco = req.getParameter("inputPerentesco").trim();
                    final String checkCA = req.getParameter("checkCA").trim();
                    out = this.altaEmpleado(sociedad, inputLegajoConsulta2, fechaAltaEmpleado, telefonoEmergencia, inputDeportePref, selectActFisica, selectFumador, inputLesionFis, aptoFisico, inputNombreMed, datepickerDia, inputMatriculaMed, inputPerentesco, checkCA);
                }
                else if ("bajaEmpleado".equals(tipoConsulta2)) {
                    final String sociedad = req.getParameter("sociedad").trim();
                    final String inputLegajoConsulta2 = req.getParameter("inputLegajoConsulta").trim();
                    final String fechaAltaEmpleado = req.getParameter("fechaAltaEmpleado").trim();
                    out = this.bajaEmpleado(sociedad, inputLegajoConsulta2, fechaAltaEmpleado);
                }
                else if ("borraProfesor".equals(tipoConsulta2)) {
                    final String P_ID_PROFESOR = req.getParameter("idProfesor").trim();
                    out = this.borraProfesor(P_ID_PROFESOR);
                }
                else if ("altaProfesor".equals(tipoConsulta2)) {
                    final String nombreApellido = req.getParameter("NOMBRE_APELLIDO").trim();
                    final String inputDNI = req.getParameter("NUM_DOCUMENTO").trim();
                    final String inputDireccion = req.getParameter("DIRECCION").trim();
                    final String inputTelefono = req.getParameter("TELEFONO").trim();
                    out = this.altaProfesor(inputDNI, nombreApellido, inputDireccion, inputTelefono);
                }
                else if ("comboProfesor".equals(tipoConsulta2)) {
                    out = this.comboProfesor();
                    if (out.length() == 1) {
                        out = "[{}]";
                    }
                }
                else if ("comboTipoclase".equals(tipoConsulta2)) {
                    out = this.comboTipoClase();
                    System.out.println(out);
                    if (out.length() == 1) {
                        out = "[{}]";
                    }
                }
                else if ("comboDisciplina".equals(tipoConsulta2)) {
                    out = this.comboDisciplina();
                    if (out.length() == 1) {
                        out = "[{}]";
                    }
                }
                else if ("comboActFisica".equals(tipoConsulta2)) {
                    out = this.comboActFisica();
                    if (out.length() == 1) {
                        out = "[{}]";
                    }
                }
                else if ("consultaClase".equals(tipoConsulta2)) {
                    out = this.consultaClases(req);
                    System.out.println(out);
                }
                else if ("consultaProfesores".equals(tipoConsulta2)) {
                    out = this.consultaProfesores(req);
                    System.out.println(out);
                }
                else if ("updateProfesor".equals(tipoConsulta2)) {
                    final String P_ID_PROFESOR = req.getParameter("ID_PROFESOR").trim();
                    final String P_NUM_DOCUMENTO = req.getParameter("NUM_DOCUMENTO").trim();
                    final String P_NOMBRE_APELLIDO = req.getParameter("NOMBRE_APELLIDO").trim();
                    final String P_DIRECCION = req.getParameter("DIRECCION").trim();
                    final String P_TELEFONO = req.getParameter("TELEFONO").trim();
                    out = this.updateProfesor(P_ID_PROFESOR, P_NUM_DOCUMENTO, P_NOMBRE_APELLIDO, P_DIRECCION, P_TELEFONO);
                    System.out.println(out);
                }
                else if ("inscripcionClase".equals(tipoConsulta2)) {
                    final String sociedad = req.getParameter("sociedad").trim();
                    final String inputLegajoConsulta2 = req.getParameter("inputLegajoConsulta").trim();
                    final String fechaAltaEmpleado = req.getParameter("fechaAltaEmpleado").trim();
                    final String dateDesde = req.getParameter("dateDesde").trim();
                    final String dateHasta = req.getParameter("dateHasta").trim();
                    final String idDis = req.getParameter("idDis").trim();
                    final String idClas = req.getParameter("idClas").trim();
                    final String idTipoClase = req.getParameter("idTipoClase").trim();
                    out = this.inscripcionClase(sociedad, inputLegajoConsulta2, fechaAltaEmpleado, dateDesde, dateHasta, idDis, idClas, idTipoClase);
                }
                else if ("clasesReservadas".equals(tipoConsulta2)) {
                    out = this.clasesReservadas(req);
                }
                else if ("borraReserva".equals(tipoConsulta2)) {
                    final String sociedad = req.getParameter("sociedad").trim();
                    final String inputLegajoConsulta2 = req.getParameter("inputLegajoConsulta").trim();
                    final String fechaAltaEmpleado = req.getParameter("fechaAltaEmpleado").trim();
                    final String fechaInicio = req.getParameter("fechaInicio").trim();
                    final String idDisciplina = req.getParameter("idDisciplina").trim();
                    final String idClase = req.getParameter("idClase").trim();
                    out = this.borraReserva(sociedad, inputLegajoConsulta2, fechaAltaEmpleado, fechaInicio, idDisciplina, idClase);
                }
                else if ("datosInscriptos".equals(tipoConsulta2)) {
                    final String clase2 = req.getParameter("clase");
                    final String disciplina = req.getParameter("disciplina");
                    System.out.println("clase: " + clase2);
                    System.out.println("disciplina: " + disciplina);
                    out = this.datosInscriptos(req);
                }
                else if ("consultaAusencias".equals(tipoConsulta2)) {
                    final String clase2 = req.getParameter("clase");
                    final String disciplina = req.getParameter("disciplina");
                    final String fechaAusencia = req.getParameter("fechaAusencia");
                    System.out.println("clase: " + clase2);
                    System.out.println("disciplina: " + disciplina);
                    out = this.consultaAusencia(req);
                }
                else if ("insertaAusentismo".equals(tipoConsulta2)) {
                    final String sociedad = req.getParameter("sociedad").trim();
                    final String empleado = req.getParameter("empleado").trim();
                    final String fechaAltaEmpleado = req.getParameter("fechaAltaEmpleado").trim();
                    final String disciplina2 = req.getParameter("disciplina").trim();
                    final String clase3 = req.getParameter("clase").trim();
                    final String fechaAusencia2 = req.getParameter("fechaAusencia").trim();
                    out = this.insertaAusencia(sociedad, empleado, fechaAltaEmpleado, disciplina2, clase3, fechaAusencia2);
                }
                else if ("deleteAusentismo".equals(tipoConsulta2)) {
                    final String sociedad = req.getParameter("sociedad").trim();
                    final String empleado = req.getParameter("empleado").trim();
                    final String fechaAltaEmpleado = req.getParameter("fechaAltaEmpleado").trim();
                    final String disciplina2 = req.getParameter("disciplina").trim();
                    final String clase3 = req.getParameter("clase").trim();
                    final String fechaAusencia2 = req.getParameter("fechaAusencia").trim();
                    out = this.deleteAusencia(sociedad, empleado, fechaAltaEmpleado, disciplina2, clase3, fechaAusencia2);
                }
                else if ("updateTipoClase".equals(tipoConsulta2)) {
                    final String id_tipo = req.getParameter("id_tipo").trim();
                    final String x_descripcion = req.getParameter("x_descripcion").trim();
                    final String cant_clases = req.getParameter("cant_clases").trim();
                    out = this.actualizaTipo(id_tipo, x_descripcion, cant_clases);
                }
                else if ("altaTipoClase".equals(tipoConsulta2)) {
                    final String x_descripcion2 = req.getParameter("x_descripcion").trim();
                    final String cant_clases2 = req.getParameter("cant_clases").trim();
                    out = this.insertaTipo(x_descripcion2, cant_clases2);
                }
            }
            else if ("comboPrepaga".equals(action)) {
                out = this.comboPrepaga();
                if (out.length() == 1) {
                    out = "[{}]";
                }
            }
            else if ("comboPrepagasEmp".equals(action)) {
                final String pIdMedicinaPrepaga = req.getParameter("idMed").trim();
                out = this.comboPrepagasEmp(pIdMedicinaPrepaga);
                if (out.length() == 1) {
                    out = "[{}]";
                }
            }
            else if ("cargaCajas".equals(action)) {
                out = this.cargaCajas();
                if (out.length() == 1) {
                    out = "[{}]";
                }
            }
            else if ("datosPrepaga".equals(action)) {
                out = this.datosPrepaga(legajo.getUsrId());
                if (out.length() == 1) {
                    out = "[{}]";
                }
            }
            else if ("updateArchivosEstaticos".equals(action)) {
                final String p_id_archivos = req.getParameter("P_ID_ARCHIVOS").trim();
                out = this.updateArchivosEstaticos(p_id_archivos);
                if (out.length() == 1) {
                    out = "[{}]";
                }
            }
            else if ("updatePrepaga".equals(action)) {
                final String pIdMedicinaPrepaga = req.getParameter("pIdMedicinaPrepaga").trim();
                final String pXplan = req.getParameter("pXplan").trim();
                final String pXarchivo = req.getParameter("pXarchivo").trim();
                out = this.updatePrepaga(pIdMedicinaPrepaga, pXplan, pXarchivo);
                if (out.length() == 1) {
                    out = "[{}]";
                }
            }
            else if ("insPrepaga".equals(action)) {
                final String pIdMedicinaPrepaga = req.getParameter("pIdMedicinaPrepaga").trim();
                final String pXplan = req.getParameter("pXplan").trim();
                final String pXarchivo = req.getParameter("pXarchivo").trim();
                final String calificacion = req.getParameter("calificacion").trim();
                out = this.insertPrepaga(pIdMedicinaPrepaga, pXplan, pXarchivo, Integer.valueOf(calificacion));
                if (out.length() == 1) {
                    out = "[{}]";
                }
            }
            else if ("delPrepaga".equals(action)) {
                final String pIdMedicinaPrepaga = req.getParameter("pIdMedicinaPrepaga").trim();
                String pXplan = req.getParameter("pXplan").trim();
                final String pXarchivo = req.getParameter("pXarchivo").trim();
                pXplan = pXplan.substring(pXplan.indexOf(">") + 1, pXplan.length());
                pXplan = pXplan.substring(0, pXplan.indexOf("<"));
                out = this.deletePrepaga(pIdMedicinaPrepaga, pXplan, pXarchivo);
                if (out.length() == 1) {
                    out = "[{}]";
                }
            }
            else if ("insertArchivo".equals(action)) {
                final String pIdAGArchivos = req.getParameter("pIdMedicinaPrepaga").trim();
                final String pXdescripcion = req.getParameter("pXdescripcion").trim();
                final String pXnombreArchivo = req.getParameter("pXnombreArchivo").trim();
                out = this.insertArchivo("/cfg/gestCont/" + pXnombreArchivo, pXnombreArchivo, pXdescripcion, pIdAGArchivos);
                if (out.length() == 1) {
                    out = "[{}]";
                }
            }
            else if ("deleteArchivo".equals(action)) {
                final String id_archivos = req.getParameter("id_archivos").trim();
                out = this.deleteArchivo(id_archivos);
                if (out.length() == 1) {
                    out = "[{}]";
                }
            }
            else if ("uploadFileStatic".equals(action)) {
                resp.setContentType("text/html;charset=UTF-8");
                final String x_nombre_archivo = req.getParameter("x_nombre_archivo").trim();
                final File nombreArchivo = new File(x_nombre_archivo);
                if (!ServletFileUpload.isMultipartContent(req)) {
                    final PrintWriter writer = resp.getWriter();
                    writer.println("Error: Form must has enctype=multipart/form-data.");
                    writer.flush();
                    return;
                }
                final DiskFileItemFactory factory = new DiskFileItemFactory();
                factory.setSizeThreshold(3145728);
                final File rutaTemp = new File(String.valueOf(asc.getPathApplication()) + "../cfg" + File.separator + "tempFile" + File.separator);
                factory.setRepository(rutaTemp.getCanonicalFile());
                final ServletFileUpload upload = new ServletFileUpload((FileItemFactory)factory);
                upload.setSizeMax(52428800L);
                final File upFile = new File(String.valueOf(asc.getPathApplication()) + "../cfg" + File.separator + "prepFile");
                final String uploadPath = String.valueOf(upFile.getCanonicalPath()) + "/";
                final File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }
                try {
                    final List<FileItem> formItems = (List<FileItem>)upload.parseRequest(req);
                    if (formItems != null && formItems.size() > 0) {
                        for (final FileItem item : formItems) {
                            if (!item.isFormField()) {
                                nombreArchivo.getName();
                                final String fileName = nombreArchivo.getName();
                                final String filePath = String.valueOf(uploadPath) + fileName;
                                final File storeFile = new File(filePath);
                                item.write(storeFile);
                                req.setAttribute("message", (Object)"Upload has been done successfully!");
                            }
                        }
                    }
                }
                catch (Exception ex) {
                    req.setAttribute("message", (Object)("There was an error: " + ex.getMessage()));
                }
                if (out.length() == 1) {
                    out = "[{}]";
                }
            }
            else if ("uploadFilePrep".equals(action)) {
                resp.setContentType("text/html;charset=UTF-8");
                if (!ServletFileUpload.isMultipartContent(req)) {
                    final PrintWriter writer2 = resp.getWriter();
                    writer2.println("Error: Form must has enctype=multipart/form-data.");
                    writer2.flush();
                    return;
                }
                final DiskFileItemFactory factory2 = new DiskFileItemFactory();
                factory2.setSizeThreshold(3145728);
                final File rutaTemp2 = new File(String.valueOf(asc.getPathApplication()) + "../cfg" + File.separator + "tempFile" + File.separator);
                factory2.setRepository(rutaTemp2.getCanonicalFile());
                final ServletFileUpload upload2 = new ServletFileUpload((FileItemFactory)factory2);
                upload2.setSizeMax(52428800L);
                final File upFile2 = new File(String.valueOf(asc.getPathApplication()) + "../cfg" + File.separator + "prepFile");
                final String uploadPath2 = String.valueOf(upFile2.getCanonicalPath()) + "/";
                final File uploadDir2 = new File(uploadPath2);
                if (!uploadDir2.exists()) {
                    uploadDir2.mkdir();
                }
                try {
                    final List<FileItem> formItems2 = (List<FileItem>)upload2.parseRequest(req);
                    if (formItems2 != null && formItems2.size() > 0) {
                        for (final FileItem item2 : formItems2) {
                            if (!item2.isFormField()) {
                                final String fileName2 = new File(item2.getName()).getName();
                                final String filePath2 = String.valueOf(uploadPath2) + fileName2;
                                final File storeFile2 = new File(filePath2);
                                item2.write(storeFile2);
                                req.setAttribute("message", (Object)"Upload has been done successfully!");
                            }
                        }
                    }
                }
                catch (Exception ex2) {
                    req.setAttribute("message", (Object)("There was an error: " + ex2.getMessage()));
                }
                if (out.length() == 1) {
                    out = "[{}]";
                }
            }
            else if ("deleteFilePrep".equals(action)) {
                final String nombreArchivo2 = req.getParameter("pXarchivo").trim();
                resp.setContentType("text/html;charset=UTF-8");
                if (!nombreArchivo2.equalsIgnoreCase("")) {
                    final File upFile3 = new File(String.valueOf(asc.getPathApplication()) + "../cfg" + File.separator + "prepFile" + "/" + nombreArchivo2);
                    upFile3.delete();
                }
                if (out.length() == 1) {
                    out = "[{}]";
                }
            }
            else if ("deleteFileGestCont".equals(action)) {
                final String nombreArchivo2 = req.getParameter("x_nombre_archivo").trim();
                resp.setContentType("text/html;charset=UTF-8");
                if (!nombreArchivo2.equalsIgnoreCase("")) {
                    final File upFile3 = new File(String.valueOf(asc.getPathApplication()) + "../cfg" + File.separator + "gestFile" + "/" + nombreArchivo2);
                    upFile3.delete();
                }
                if (out.length() == 1) {
                    out = "[{}]";
                }
            }
            else if ("uploadFilePrep_GestCont".equals(action)) {
                resp.setContentType("text/html;charset=UTF-8");
                final String pathUrlDest = req.getParameter("destination");
                if (!ServletFileUpload.isMultipartContent(req)) {
                    final PrintWriter writer3 = resp.getWriter();
                    writer3.println("Error: Form must has enctype=multipart/form-data.");
                    writer3.flush();
                    return;
                }
                final DiskFileItemFactory factory3 = new DiskFileItemFactory();
                factory3.setSizeThreshold(3145728);
                final File rutaTemp3 = new File(String.valueOf(asc.getPathApplication()) + "../cfg" + File.separator + "tempFile" + File.separator);
                factory3.setRepository(rutaTemp3.getCanonicalFile());
                final ServletFileUpload upload3 = new ServletFileUpload((FileItemFactory)factory3);
                upload3.setSizeMax(52428800L);
                final File upFile4 = new File(String.valueOf(asc.getPathApplication()) + "../cfg" + File.separator + pathUrlDest);
                final String uploadPath3 = String.valueOf(upFile4.getCanonicalPath()) + "/";
                final File uploadDir3 = new File(uploadPath3);
                if (!uploadDir3.exists()) {
                    uploadDir3.mkdir();
                }
                try {
                    final List<FileItem> formItems3 = (List<FileItem>)upload3.parseRequest(req);
                    if (formItems3 != null && formItems3.size() > 0) {
                        for (final FileItem item3 : formItems3) {
                            if (!item3.isFormField()) {
                                final String fileName3 = new File(item3.getName()).getName();
                                final String filePath3 = String.valueOf(uploadPath3) + fileName3;
                                final File storeFile3 = new File(filePath3);
                                item3.write(storeFile3);
                                req.setAttribute("message", (Object)"Upload has been done successfully!");
                            }
                        }
                    }
                }
                catch (Exception ex3) {
                    req.setAttribute("message", (Object)("There was an error: " + ex3.getMessage()));
                }
                if (out.length() == 1) {
                    out = "[{}]";
                }
            }
            resp.getOutputStream().print(out);
        }
        catch (MsgException e2) {
            resp.getOutputStream().print(e2.getMessage());
        }
        catch (Exception e3) {
            resp.getOutputStream().print(e3.getMessage());
            e3.printStackTrace();
        }
    }
    
    private String getReportes(final String usuarioCorpo) {
        final RhValidarSueldoDAO dao = new RhValidarSueldoDAO();
        return dao.reportes(usuarioCorpo);
    }
    
    private String getMotivos() {
        final RhValidarSueldoDAO dao = new RhValidarSueldoDAO();
        return dao.motivosAjuste();
    }
    
    private String getDatosEmple(final String pusuario) {
        final RhValidarSueldoDAO dao = new RhValidarSueldoDAO();
        return dao.datosEmple(pusuario);
    }
    
    private String getValidacion(final String pusuario, final String motivo) {
        final RhValidarSueldoDAO dao = new RhValidarSueldoDAO();
        return dao.validar(pusuario, motivo);
    }
    
    private String getJP(final String pusuario) {
        final RhValidarSueldoDAO dao = new RhValidarSueldoDAO();
        return dao.jp(pusuario);
    }
    
    private String getSupervisory() {
        final RhValidarSueldoDAO dao = new RhValidarSueldoDAO();
        return dao.supervisory();
    }
    
    private String getEmpresa() {
        final RhValidarSueldoDAO dao = new RhValidarSueldoDAO();
        return dao.empresa();
    }
    
    private String getPosicionamientoNuevo(final String pusuario, final String nuevoJP, final String nuevoSueldo) {
        final RhValidarSueldoDAO dao = new RhValidarSueldoDAO();
        return dao.posicionaNuevo(pusuario, nuevoJP, nuevoSueldo);
    }
    
    private void registrarSolicitud(final String idSolicitud, final String usuarioCorpoSuper, final String usuarioCorpoEmpleado, final String idMotivoAjuste, final Date fecSimulacion, final String idJobProfile, final String idSupervisory, final String idEmpresa, final String zonaDesfavorable, final String rtm, final String conformado, final String complemento, final String adicionalFalla, final String remuneracionTot, final String bt, final String idMapaTalento, final String performance, final String potencial, final String idJobProfileNuevo, final String idSupervisoryNueva, final String idEmpresaNueva, final String importeAjustar, final String porcentajeAjustar, final String remuneracionTotalNueva, final String btPropuesto, final String observaciones, final String posicionamiento, final String bonoSugerido) {
        final RhValidarSueldoDAO dao = new RhValidarSueldoDAO();
        dao.registrarSolicitud(idSolicitud, usuarioCorpoSuper, usuarioCorpoEmpleado, idMotivoAjuste, fecSimulacion, idJobProfile, idSupervisory, idEmpresa, zonaDesfavorable, rtm, conformado, complemento, adicionalFalla, remuneracionTot, bt, idMapaTalento, performance, potencial, idJobProfileNuevo, idSupervisoryNueva, idEmpresaNueva, importeAjustar, porcentajeAjustar, remuneracionTotalNueva, btPropuesto, observaciones, posicionamiento, bonoSugerido);
    }
    
    private String getValidacionPost(final String idSolicitud, final String pusuario, final String nuevoJP, final String importe, final String porcentaje, final String motivoAjuste) {
        final RhValidarSueldoDAO dao = new RhValidarSueldoDAO();
        return dao.validarPost(idSolicitud, pusuario, nuevoJP, importe, porcentaje, motivoAjuste);
    }
    
    private String getHistorico(final String pusuario, final Date fechaDesde, final Date fechaHasta) {
        final RhValidarSueldoDAO dao = new RhValidarSueldoDAO();
        RhCrucesPresentismoServlet.log.info((Object)("HISTARICA: Por entrar al DAO con datos: " + pusuario + " " + fechaDesde + " " + fechaHasta));
        return dao.historico(pusuario, fechaDesde, fechaHasta);
    }
    
    private String altaClase(final String P_ID_DISCIPLINA, final String P_ID_TIPO, final String P_DIA, final String P_HORARIO_DESDE, final String P_HORARIO_HASTA, final String P_FECHA_DESDE, final String P_FECHA_HASTA, final String P_DESCRIPCION, final String P_CUPO, final String P_ID_PROFESOR) throws MsgException, ParseException {
        String retData = "";
        final ClasesDAO clasesDAO = new ClasesDAO();
        retData = clasesDAO.altaClase(P_ID_DISCIPLINA, P_ID_TIPO, P_DIA, P_HORARIO_DESDE, P_HORARIO_HASTA, P_FECHA_DESDE, P_FECHA_HASTA, P_DESCRIPCION, P_CUPO, P_ID_PROFESOR);
        return retData;
    }
    
    private String updateClase(final String P_ID_DISCIPLINA, final String P_CLASE, final String P_DIA, final String P_HORARIO_DESDE, final String P_HORARIO_HASTA, final String P_FECHA_DESDE, final String P_FECHA_HASTA, final String P_DESCRIPCION, final String P_CUPO, final String P_ID_PROFESOR, final String P_ID_TIPO, final String CK_BORRADO) throws MsgException, ParseException {
        String retData = "";
        final ClasesDAO clasesDAO = new ClasesDAO();
        retData = clasesDAO.updateClase(P_ID_DISCIPLINA, P_CLASE, P_DIA, P_HORARIO_DESDE, P_HORARIO_HASTA, P_FECHA_DESDE, P_FECHA_HASTA, P_DESCRIPCION, P_CUPO, P_ID_PROFESOR, P_ID_TIPO, CK_BORRADO);
        return retData;
    }
    
    private String altaDisciplina(final String P_N_CHECK) throws MsgException, ParseException {
        String retData = "";
        final ClasesDAO clasesDAO = new ClasesDAO();
        retData = clasesDAO.altaDisciplina(P_N_CHECK);
        return retData;
    }
    
    private String borraReserva(final String P_ID_SOCIEDAD, final String P_ID_EMPLEADO, final String P_FECHA_ALTA_EMPLEADO, final String P_FECHA_INICIO, final String P_ID_DISCIPLINA, final String P_ID_CLASE) throws MsgException, ParseException {
        String retData = "";
        final ClasesDAO clasesDAO = new ClasesDAO();
        retData = clasesDAO.borraReserva(P_ID_SOCIEDAD, P_ID_EMPLEADO, P_FECHA_ALTA_EMPLEADO, P_FECHA_INICIO, P_ID_DISCIPLINA, P_ID_CLASE);
        return retData;
    }
    
    private String borraProfesor(final String P_ID_SOCIEDAD) throws MsgException, ParseException {
        String retData = "";
        final ClasesDAO clasesDAO = new ClasesDAO();
        retData = clasesDAO.bajaProfesor(P_ID_SOCIEDAD);
        return retData;
    }
    
    private String altaEmpleado(final String P_ID_SOCIEDAD, final String P_ID_EMPLEADO, final String P_FECHA_ALTA_EMPLEADO, final String P_TELEFONO_EMERGENCIA, final String P_X_DEPORTE_PREF, final String P_ID_NO_EJERCICIO, final String P_CK_FUMA, final String P_X_LESIONES, final String P_APTO_FISICO, final String P_X_NOM_APELLIDO_MED, final String P_FECHA_APTO_MEDICO, final String P_X_NUM_MATRICULA, final String P_X_PARENTESCO, final String P_CK_DEBITO) throws MsgException, ParseException {
        String retData = "";
        final ClasesDAO clasesDAO = new ClasesDAO();
        retData = clasesDAO.altaEmpleado(P_ID_SOCIEDAD, P_ID_EMPLEADO, P_FECHA_ALTA_EMPLEADO, P_TELEFONO_EMERGENCIA, P_X_DEPORTE_PREF, P_ID_NO_EJERCICIO, P_CK_FUMA, P_X_LESIONES, P_APTO_FISICO, P_X_NOM_APELLIDO_MED, P_FECHA_APTO_MEDICO, P_X_NUM_MATRICULA, P_X_PARENTESCO, P_CK_DEBITO);
        return retData;
    }
    
    private String bajaEmpleado(final String P_ID_SOCIEDAD, final String P_ID_EMPLEADO, final String P_FECHA_ALTA_EMPLEADO) throws MsgException, ParseException {
        String retData = "";
        final ClasesDAO clasesDAO = new ClasesDAO();
        retData = clasesDAO.bajaEmpleado(P_ID_SOCIEDAD, P_ID_EMPLEADO, P_FECHA_ALTA_EMPLEADO);
        return retData;
    }
    
    private String clasesReservadas(final HttpServletRequest request) throws MsgException, ParseException, GeneralException {
        String retData = "";
        final ClasesDAO clasesDAO = new ClasesDAO();
        retData = clasesDAO.consultaClasesReservadas(request);
        return retData;
    }
    
    private String inscripcionClase(final String P_ID_SOCIEDAD, final String P_ID_EMPLEADO, final String P_FECHA_ALTA_EMPLEADO, final String P_FECHA_INICIO, final String P_FECHA_FIN, final String P_ID_DISCIPLINA, final String P_ID_CLASE, final String P_TIPO_CLASE) throws MsgException, ParseException {
        String retData = "";
        final ClasesDAO clasesDAO = new ClasesDAO();
        retData = clasesDAO.inscripcionClase(P_ID_SOCIEDAD, P_ID_EMPLEADO, P_FECHA_ALTA_EMPLEADO, P_FECHA_INICIO, P_FECHA_FIN, P_ID_DISCIPLINA, P_ID_CLASE, P_TIPO_CLASE);
        return retData;
    }
    
    private String insertaAusencia(final String P_ID_SOCIEDAD, final String P_ID_EMPLEADO, final String P_FECHA_ALTA_EMPLEADO, final String P_ID_DISCIPLINA, final String P_ID_CLASE, final String P_FECHA_AUSENCIA) throws MsgException, ParseException {
        String retData = "";
        final ClasesDAO clasesDAO = new ClasesDAO();
        retData = clasesDAO.insertaAusencia(P_ID_SOCIEDAD, P_ID_EMPLEADO, P_FECHA_ALTA_EMPLEADO, P_ID_DISCIPLINA, P_ID_CLASE, P_FECHA_AUSENCIA);
        return retData;
    }
    
    private String deleteAusencia(final String P_ID_SOCIEDAD, final String P_ID_EMPLEADO, final String P_FECHA_ALTA_EMPLEADO, final String P_ID_DISCIPLINA, final String P_ID_CLASE, final String P_FECHA_AUSENCIA) throws MsgException, ParseException {
        String retData = "";
        final ClasesDAO clasesDAO = new ClasesDAO();
        retData = clasesDAO.deleteAusencia(P_ID_SOCIEDAD, P_ID_EMPLEADO, P_FECHA_ALTA_EMPLEADO, P_ID_DISCIPLINA, P_ID_CLASE, P_FECHA_AUSENCIA);
        return retData;
    }
    
    private String actualizaTipo(final String P_ID_TIPO, final String P_X_DESCRIPCION, final String P_CANT_CLASES) throws MsgException, ParseException {
        String retData = "";
        final ClasesDAO clasesDAO = new ClasesDAO();
        retData = clasesDAO.actualizaTipo(P_ID_TIPO, P_X_DESCRIPCION, P_CANT_CLASES);
        return retData;
    }
    
    private String insertaTipo(final String P_X_DESCRIPCION, final String P_CANT_CLASES) throws MsgException, ParseException {
        String retData = "";
        final ClasesDAO clasesDAO = new ClasesDAO();
        retData = clasesDAO.insertaTipo(P_X_DESCRIPCION, P_CANT_CLASES);
        return retData;
    }
    
    private String datosInscriptos(final HttpServletRequest request) throws MsgException, ParseException, GeneralException {
        String retData = "";
        final ClasesDAO clasesDAO = new ClasesDAO();
        retData = clasesDAO.consultaDatosInscriptos(request);
        return retData;
    }
    
    private String consultaAusencia(final HttpServletRequest request) throws MsgException, ParseException, GeneralException {
        String retData = "";
        final ClasesDAO clasesDAO = new ClasesDAO();
        retData = clasesDAO.consultaDatosInasistencias(request);
        return retData;
    }
    
    private String altaProfesor(final String P_NUM_DOCUMENTO, final String P_NOMBRE_APELLIDO, final String P_DIRECCION, final String P_TELEFONO) throws MsgException, ParseException {
        String retData = "";
        final ClasesDAO clasesDAO = new ClasesDAO();
        retData = clasesDAO.altaProfesor(P_NUM_DOCUMENTO, P_NOMBRE_APELLIDO, P_DIRECCION, P_TELEFONO);
        return retData;
    }
    
    private String consultaClases(final HttpServletRequest request) throws MsgException, GeneralException {
        String retData = "";
        final ClasesDAO clasesDAO = new ClasesDAO();
        retData = clasesDAO.consultaClases(request);
        return retData;
    }
    
    private String consultarLegajo(final String inputLegajoConsulta) throws MsgException {
        String retData = "";
        final ClasesDAO clasesDAO = new ClasesDAO();
        retData = clasesDAO.consultaLegajo(inputLegajoConsulta);
        return retData;
    }
    
    private String consultaDatosCargadosEmpleado(final String inputLegajoConsulta) throws MsgException {
        String retData = "";
        final ClasesDAO clasesDAO = new ClasesDAO();
        retData = clasesDAO.consultaDatosCargadosEmpleado(inputLegajoConsulta);
        return retData;
    }
    
    private String comboProfesor() throws MsgException {
        String retData = "";
        final ClasesDAO clasesDAO = new ClasesDAO();
        retData = clasesDAO.datosProfesores();
        return retData;
    }
    
    private String consultaProfesores(final HttpServletRequest request) throws MsgException, GeneralException {
        String retData = "";
        final ClasesDAO clasesDAO = new ClasesDAO();
        retData = clasesDAO.consultaProfesores(request);
        return retData;
    }
    
    private String updateProfesor(final String P_ID_PROFESOR, final String P_NUM_DOCUMENTO, final String P_NOMBRE_APELLIDO, final String P_DIRECCION, final String P_TELEFONO) throws MsgException, ParseException {
        String retData = "";
        final ClasesDAO clasesDAO = new ClasesDAO();
        retData = clasesDAO.updateProfesor(P_ID_PROFESOR, P_NUM_DOCUMENTO, P_NOMBRE_APELLIDO, P_DIRECCION, P_TELEFONO);
        return retData;
    }
    
    private String comboTipoClase() throws MsgException {
        String retData = "";
        final ClasesDAO clasesDAO = new ClasesDAO();
        retData = clasesDAO.comboTiposClase();
        return retData;
    }
    
    private String comboDisciplina() throws MsgException {
        String retData = "";
        final ClasesDAO clasesDAO = new ClasesDAO();
        retData = clasesDAO.datosdisciplinas();
        return retData;
    }
    
    private String comboActFisica() throws MsgException {
        String retData = "";
        final ClasesDAO clasesDAO = new ClasesDAO();
        retData = clasesDAO.datosInactividad();
        return retData;
    }
    
    private String comboPrepaga() throws MsgException {
        String retData = "";
        final RhCuentaCorrienteDAO corrienteDAO = new RhCuentaCorrienteDAO();
        retData = corrienteDAO.comboPrepaga();
        return retData;
    }
    
    private String comboPrepagasEmp(final String pIdMedicinaPrepaga) throws MsgException {
        String retData = "";
        final RhCuentaCorrienteDAO corrienteDAO = new RhCuentaCorrienteDAO();
        retData = corrienteDAO.comboPrepagaEmp(pIdMedicinaPrepaga);
        return retData;
    }
    
    private String cargaCajas() throws MsgException {
        String retData = "";
        final RhCuentaCorrienteDAO corrienteDAO = new RhCuentaCorrienteDAO();
        retData = corrienteDAO.cajasPrepagasNovedades();
        return retData;
    }
    
    private String datosPrepaga(final String legajo) throws MsgException {
        String retData = "";
        final RhCuentaCorrienteDAO corrienteDAO = new RhCuentaCorrienteDAO();
        retData = corrienteDAO.datosPrepaga(legajo);
        return retData;
    }
    
    private String updateArchivosEstaticos(final String p_id_archivos) throws MsgException, ParseException {
        String retData = "";
        final RhCuentaCorrienteDAO corrienteDAO = new RhCuentaCorrienteDAO();
        retData = corrienteDAO.updateArchivoEstatico(p_id_archivos);
        return retData;
    }
    
    private String updatePrepaga(final String pIdMedicinaPrepaga, final String pXplan, final String pXarchivo) throws MsgException, ParseException {
        String retData = "";
        final RhCuentaCorrienteDAO corrienteDAO = new RhCuentaCorrienteDAO();
        retData = corrienteDAO.updatePrepaga(pIdMedicinaPrepaga, pXplan, pXarchivo);
        return retData;
    }
    
    private String insertPrepaga(final String pIdMedicinaPrepaga, final String pXplan, final String pXarchivo, final Integer calificacion) throws MsgException, ParseException {
        String retData = "";
        final RhCuentaCorrienteDAO corrienteDAO = new RhCuentaCorrienteDAO();
        retData = corrienteDAO.insertPrepaga(pIdMedicinaPrepaga, pXplan, pXarchivo, calificacion);
        return retData;
    }
    
    private String insertArchivo(final String pXdirectorio, final String pXnombreArchivo, final String pXdescripcion, final String pIdAGArchivos) throws MsgException, ParseException {
        String retData = "";
        final RhCuentaCorrienteDAO corrienteDAO = new RhCuentaCorrienteDAO();
        retData = corrienteDAO.insertArchivo(pXdirectorio, pXnombreArchivo, pXdescripcion, pIdAGArchivos);
        return retData;
    }
    
    private String deleteArchivo(final String p_id_archivos) throws MsgException, ParseException {
        String retData = "";
        final RhCuentaCorrienteDAO corrienteDAO = new RhCuentaCorrienteDAO();
        retData = corrienteDAO.deleteArchivo(p_id_archivos);
        return retData;
    }
    
    private String deletePrepaga(final String pIdMedicinaPrepaga, final String pXplan, final String pXarchivo) throws MsgException, ParseException {
        String retData = "";
        final RhCuentaCorrienteDAO corrienteDAO = new RhCuentaCorrienteDAO();
        retData = corrienteDAO.deletePrepaga(pIdMedicinaPrepaga, pXplan, pXarchivo);
        return retData;
    }
    
    private String pr_legajo_de_un_usuario(final String usrId) throws MsgException {
        String sociedadCorp = "";
        final BeneficiosDAO beneficiosDao = new BeneficiosDAO();
        sociedadCorp = beneficiosDao.pr_legajo_de_un_usuarioDao(usrId);
        return sociedadCorp;
    }
    
    private String pr_nro_legajo_de_un_usuario(final String usrId) throws MsgException {
        String sociedadCorp = "";
        final BeneficiosDAO beneficiosDao = new BeneficiosDAO();
        sociedadCorp = beneficiosDao.pr_nro_legajo_de_un_usuarioDao(usrId);
        return sociedadCorp;
    }
    
    private String consultarBenefFamiliaKE(final String usrId, final String idSociedad, final String iDBeneficio) throws MsgException {
        String retData = "";
        final BeneficiosDAO beneficiosDao = new BeneficiosDAO();
        retData = beneficiosDao.consultaBeneficiariosFamiliaresKE(usrId, idSociedad, iDBeneficio);
        return retData;
    }
    
    private String consultarBenefFamilia(final String usrId, final String idSociedad, final String iDBeneficio) throws MsgException {
        String retData = "";
        final BeneficiosDAO beneficiosDao = new BeneficiosDAO();
        retData = beneficiosDao.consultaBeneficiariosFamiliares(usrId, idSociedad, iDBeneficio);
        return retData;
    }
    
    private String consultarBenefFamiliaAdm(final String usrId, final String idSociedad, final String iDBeneficio) throws MsgException {
        String retData = "";
        final BeneficiosDAO beneficiosDao = new BeneficiosDAO();
        retData = beneficiosDao.consultaBeneficiariosFamiliaresAdm(usrId, idSociedad, iDBeneficio);
        return retData;
    }
    
    private String consultarDatosEmpleado(final String usrId, final String idSociedad, final RhGralLegajo legajo) throws MsgException {
        String retData = "";
        final BeneficiosDAO beneficiosDao = new BeneficiosDAO();
        retData = beneficiosDao.consultaDatosEmpleados(usrId, idSociedad, legajo);
        return retData;
    }
    
    private String consultarDatosEnvio(final String usrId, final String idSociedad, final RhGralLegajo legajo, final String beneficio) throws MsgException {
        String retData = "";
        final BeneficiosDAO beneficiosDao = new BeneficiosDAO();
        retData = beneficiosDao.consultaDatosEnvio(usrId, idSociedad, legajo, beneficio);
        return retData;
    }
    
    private String envioMailDireccion(final String asuntoMail, final String textoMail, final String usrId, final String idSociedad) throws MsgException {
        String retData = "";
        final BeneficiosDAO beneficiosDao = new BeneficiosDAO();
        try {
            retData = beneficiosDao.envioMailDireccion(usrId, idSociedad, asuntoMail, textoMail);
        }
        catch (ParseException e) {
            e.printStackTrace();
        }
        return retData;
    }
    
    private String cargaSupervisoresPorArea(final HttpServletRequest req, final HttpServletResponse resp) {
        String json = "";
        final String sociedad = req.getParameter("sociedad");
        final String unidad = req.getParameter("unidad");
        final RhCrucesPresentismo crucesPresentismo = new RhCrucesPresentismo();
        json = crucesPresentismo.cargaSupervisoresPorArea(sociedad, unidad);
        return json;
    }
    
    private String cargarEmpleadosPorArea(final HttpServletRequest req, final HttpServletResponse resp) {
        String json = "";
        final String sociedad = req.getParameter("sociedad");
        final String unidad = req.getParameter("unidad");
        final RhCrucesPresentismo crucesPresentismo = new RhCrucesPresentismo();
        json = crucesPresentismo.cargarEmpleadosPorUnidad(sociedad, unidad);
        return json;
    }
    
    private String autorizaCruces(final HttpServletRequest req, final HttpServletResponse resp) throws ServletException, IOException {
        String autoriza = "";
        try {
            RhGralLegajo legajo = null;
            final RhGralAppSessionContext asc = new RhGralAppSessionContext();
            legajo = asc.getLegajo(req.getSession());
            final RhCrucesPresentismo crucesPresentismo = new RhCrucesPresentismo();
            autoriza = crucesPresentismo.autorizaCruces(legajo.getSociedad(), legajo.getEstrucArea());
        }
        catch (MsgException e) {
            RhCrucesPresentismoServlet.log.error((Object)e.getMessage(), (Throwable)e);
            e.printStackTrace();
        }
        return autoriza;
    }
    
    private String consultaSupervisores(final HttpServletRequest req, final HttpServletResponse resp) throws ServletException, IOException {
        String empleados = "";
        try {
            RhGralLegajo legajo = null;
            final RhGralAppSessionContext asc = new RhGralAppSessionContext();
            legajo = asc.getLegajo(req.getSession());
            final String idLegajo = legajo.getNumeroLegajo();
            final String idSociedad = legajo.getSociedad();
            final Date fechaAlta = this.fechaAltaEmpleado(idLegajo, idSociedad);
            final RhCrucesPresentismo crucesPresentismo = new RhCrucesPresentismo();
            empleados = crucesPresentismo.supervisores(idLegajo, idSociedad, fechaAlta);
        }
        catch (MsgException e) {
            RhCrucesPresentismoServlet.log.error((Object)e.getMessage(), (Throwable)e);
            e.printStackTrace();
        }
        return empleados;
    }
    
    private String consultaEmpleadosSupervisados(final HttpServletRequest req, final HttpServletResponse resp) throws ServletException, IOException {
        String empleados = "";
        try {
            RhGralLegajo legajo = null;
            final RhGralAppSessionContext asc = new RhGralAppSessionContext();
            legajo = asc.getLegajo(req.getSession());
            final String idLegajo = legajo.getNumeroLegajo();
            final String idSociedad = legajo.getSociedad();
            final Date fechaAlta = this.fechaAltaEmpleado(idLegajo, idSociedad);
            final RhCrucesPresentismo crucesPresentismo = new RhCrucesPresentismo();
            empleados = crucesPresentismo.empleadosSupervisados(idLegajo, idSociedad, fechaAlta);
        }
        catch (MsgException e) {
            RhCrucesPresentismoServlet.log.error((Object)e.getMessage(), (Throwable)e);
            e.printStackTrace();
        }
        return empleados;
    }
    
    private String consultaEmpleados(final HttpServletRequest req, final HttpServletResponse resp) throws ServletException, IOException {
        String empleados = "";
        try {
            RhGralLegajo legajo = null;
            final RhGralAppSessionContext asc = new RhGralAppSessionContext();
            legajo = asc.getLegajo(req.getSession());
            final String idLegajo = legajo.getNumeroLegajo();
            final String idSociedad = legajo.getSociedad();
            final Date fechaAlta = this.fechaAltaEmpleado(idLegajo, idSociedad);
            final RhCrucesPresentismo crucesPresentismo = new RhCrucesPresentismo();
            empleados = crucesPresentismo.cargaEmpleadosPorArea(idLegajo, idSociedad, fechaAlta);
        }
        catch (MsgException e) {
            RhCrucesPresentismoServlet.log.error((Object)e.getMessage(), (Throwable)e);
            e.printStackTrace();
        }
        return empleados;
    }
    
    private String consultaAreasSupervisadas(final HttpServletRequest req, final HttpServletResponse resp) throws ServletException, IOException {
        String areas = "";
        try {
            final RhGralAppSessionContext asc = new RhGralAppSessionContext();
            RhGralLegajo legajo = null;
            legajo = asc.getLegajo(req.getSession());
            final String idEmpleLog = legajo.getNumeroLegajo();
            final String socEmpleLog = legajo.getSociedad();
            final RhCrucesPresentismo crucesPresentismo = new RhCrucesPresentismo();
            areas = crucesPresentismo.findAreasSupervisadas(req.getParameter("codArea"), idEmpleLog, socEmpleLog);
        }
        catch (MsgException e) {
            RhCrucesPresentismoServlet.log.error((Object)e.getMessage(), (Throwable)e);
        }
        return areas;
    }
    
    private String consultaSelectJustificar(final HttpServletRequest req, final HttpServletResponse resp) throws ServletException, IOException {
        String selects = "";
        try {
            final RhCrucesPresentismo crucesPresentismo = new RhCrucesPresentismo();
            selects = crucesPresentismo.consultaJustificacionesCruces();
        }
        catch (MsgException e) {
            RhCrucesPresentismoServlet.log.error((Object)e.getMessage(), (Throwable)e);
        }
        return selects;
    }
    
    private String consultaSelectJustificacionesCruces(final HttpServletRequest req, final HttpServletResponse resp) throws ServletException, IOException {
        String selects = "";
        try {
            final RhCrucesPresentismo crucesPresentismo = new RhCrucesPresentismo();
            selects = crucesPresentismo.consultaSelectJustificacionesCruces();
        }
        catch (MsgException e) {
            RhCrucesPresentismoServlet.log.error((Object)e.getMessage(), (Throwable)e);
        }
        return selects;
    }
    
    private String consultaSelectJustificacionesCrucesMasivo(final HttpServletRequest req, final HttpServletResponse resp) throws ServletException, IOException {
        String selects = "";
        try {
            final RhCrucesPresentismo crucesPresentismo = new RhCrucesPresentismo();
            selects = crucesPresentismo.consultaSelectJustificacionesCrucesMasivo();
        }
        catch (MsgException e) {
            RhCrucesPresentismoServlet.log.error((Object)e.getMessage(), (Throwable)e);
        }
        return selects;
    }
    
    private String consultaInicialCrucesJustificar(final HttpServletRequest req, final HttpServletResponse resp) throws ServletException, IOException {
        String cruces = "";
        try {
            final RhCrucesPresentismo crucesPresentismo = new RhCrucesPresentismo();
            final RhGralAppSessionContext asc = new RhGralAppSessionContext();
            RhGralLegajo legajo = null;
            legajo = asc.getLegajo(req.getSession());
            final String idEmpleLog = legajo.getNumeroLegajo();
            final String socEmpleLog = legajo.getSociedad();
            cruces = crucesPresentismo.consultaInicialCrucesJustificar(idEmpleLog, socEmpleLog);
        }
        catch (MsgException e) {
            RhCrucesPresentismoServlet.log.error((Object)e.getMessage(), (Throwable)e);
        }
        return cruces;
    }
    
    private String consultaCrucesJustificar(final HttpServletRequest req, final HttpServletResponse resp) throws ServletException, IOException {
        String cruces = "";
        try {
            final RhCrucesPresentismo crucesPresentismo = new RhCrucesPresentismo();
            final String empleadoSel = req.getParameter("empleadoSel");
            String idEmpleadoSel = "";
            String socEmpleadoSel = "";
            Date fechaAltaEmpSel = null;
            String idUsrSel = "";
            String socUsrSel = "";
            Date fecAltaUsrSel = null;
            if (empleadoSel != null && !empleadoSel.trim().equals("")) {
                idEmpleadoSel = empleadoSel.substring(2);
                socEmpleadoSel = empleadoSel.substring(0, 2);
                fechaAltaEmpSel = this.fechaAltaEmpleado(idEmpleadoSel, socEmpleadoSel);
            }
            else {
                RhGralLegajo legajo = null;
                final RhGralAppSessionContext asc = new RhGralAppSessionContext();
                legajo = asc.getLegajo(req.getSession());
                idUsrSel = legajo.getNumeroLegajo();
                socUsrSel = legajo.getSociedad();
                fecAltaUsrSel = this.fechaAltaEmpleado(idUsrSel, socUsrSel);
            }
            final Date fechaAusDesde = this.fechaStrADate(req.getParameter("fechaDesde"));
            final Date fechaAusHasta = this.fechaStrADate(req.getParameter("fechaHasta"));
            cruces = crucesPresentismo.consultaFiltradoCrucesJustificar(socEmpleadoSel, idEmpleadoSel, fechaAltaEmpSel, socUsrSel, idUsrSel, fecAltaUsrSel, fechaAusDesde, fechaAusHasta);
        }
        catch (MsgException e) {
            RhCrucesPresentismoServlet.log.error((Object)e.getMessage(), (Throwable)e);
        }
        return cruces;
    }
    
    private String consultaCruces(final HttpServletRequest req, final HttpServletResponse resp) throws ServletException, IOException {
        String cruces = "";
        try {
            final RhCrucesPresentismo crucesPresentismo = new RhCrucesPresentismo();
            final String idUnidadSupervisada = req.getParameter("areaUser");
            String idEmpLog = null;
            String socEmpleadoSel = null;
            String idEmpleadoSel = null;
            Date fechaAltaEmpSel = null;
            String socEmpleadoSup = null;
            String idEmpleadoSup = null;
            Date fechaAltaSupSel = null;
            final String empleadoSel = req.getParameter("empleadoSel");
            final String empleadoSup = req.getParameter("empleadoSup");
            String idUnidadSel = req.getParameter("areaSel");
            final RhGralAppSessionContext asc = new RhGralAppSessionContext();
            final RhGralLegajo legajo = asc.getLegajo(req.getSession());
            if (empleadoSel != null) {
                idEmpleadoSel = empleadoSel.substring(2);
                socEmpleadoSel = empleadoSel.substring(0, 2);
                fechaAltaEmpSel = this.fechaAltaEmpleado(idEmpleadoSel, socEmpleadoSel);
            }
            else if (empleadoSup != null) {
                idEmpleadoSup = empleadoSup.substring(2);
                socEmpleadoSup = empleadoSup.substring(0, 2);
                fechaAltaSupSel = this.fechaAltaEmpleado(idEmpleadoSup, socEmpleadoSup);
            }
            else if (idUnidadSel == null) {
                idUnidadSel = legajo.getId_unidad();
                idUnidadSel = idUnidadSupervisada;
            }
            else {
                idUnidadSel = idUnidadSel.split(";")[0];
            }
            idEmpLog = legajo.getNumeroLegajo();
            final Date fechaAusDesde = this.fechaStrADate(req.getParameter("fechaDesde"));
            final Date fechaAusHasta = this.fechaStrADate(req.getParameter("fechaHasta"));
            cruces = crucesPresentismo.consultaCruces(idUnidadSel, socEmpleadoSel, idEmpleadoSel, fechaAltaEmpSel, socEmpleadoSup, idEmpleadoSup, fechaAltaSupSel, idEmpLog, fechaAusDesde, fechaAusHasta);
        }
        catch (MsgException e) {
            RhCrucesPresentismoServlet.log.error((Object)e.getMessage(), (Throwable)e);
        }
        return cruces;
    }
    
    private String justificaAusentismo(final HttpServletRequest req, final HttpServletResponse resp) throws ServletException, IOException {
        String cruces = "";
        try {
            final RhCrucesPresentismo crucesPresentismo = new RhCrucesPresentismo();
            final String idRow = req.getParameter("id");
            final String[] rowId = idRow.split(":");
            final String socEmple = rowId[0];
            final String idEmple = rowId[1];
            final Date fechaDesdeAus = this.fechaStrADate(rowId[2]);
            final Date fechaHastaAus = this.fechaStrADate(rowId[3]);
            final String comentario = req.getParameter("Comentario");
            final String justificacion = req.getParameter("Justificacion");
            final RhGralAppSessionContext asc = new RhGralAppSessionContext();
            final String usuario = asc.getUsuario(req.getSession());
            cruces = crucesPresentismo.justificaAusentismo(socEmple, idEmple, this.fechaAltaEmpleado(idEmple, socEmple), fechaDesdeAus, fechaHastaAus, justificacion, comentario, usuario);
        }
        catch (MsgException e) {
            RhCrucesPresentismoServlet.log.error((Object)e.getMessage(), (Throwable)e);
        }
        return cruces;
    }
    
    private String datosEmpleado(final String idEmpleado, final String idSociedad) {
        String empleados = "";
        final RhCrucesPresentismo crucesPresentismo = new RhCrucesPresentismo();
        empleados = crucesPresentismo.datosEmpleado(idEmpleado, idSociedad);
        return empleados;
    }
    
    private Date fechaStrADate(final String fechaStr, final String formato) {
        Date fechaDate = null;
        final SimpleDateFormat format = new SimpleDateFormat(formato);
        try {
            fechaDate = format.parse(fechaStr);
        }
        catch (ParseException e) {
            RhCrucesPresentismoServlet.log.error((Object)e.getMessage(), (Throwable)e);
            e.printStackTrace();
        }
        return fechaDate;
    }
    
    private Date fechaStrADate(final String fechaStr) {
        Date fechaDate = null;
        final SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
        try {
            fechaDate = formato.parse(fechaStr);
        }
        catch (ParseException e) {
            RhCrucesPresentismoServlet.log.error((Object)e.getMessage(), (Throwable)e);
            e.printStackTrace();
        }
        return fechaDate;
    }
    
    private Date fechaAltaEmpleado(final String idLegajo, final String idSociedad) {
        final String empleado = this.datosEmpleado(idLegajo, idSociedad);
        final String[] datosEmpleado = empleado.split("@");
        return this.fechaStrADate(datosEmpleado[1]);
    }
    
    private String cargaEmpleadosPorSupervisor(final HttpServletRequest req, final HttpServletResponse resp) throws ServletException, IOException {
        String json = "";
        try {
            final RhCrucesPresentismo crucesPresentismo = new RhCrucesPresentismo();
            final String supervisorSel = req.getParameter("idSup");
            final String idSUpSel = supervisorSel.substring(2);
            final String socSupSel = supervisorSel.substring(0, 2);
            final Date fechaAltaEmpSel = this.fechaAltaEmpleado(idSUpSel, socSupSel);
            json = crucesPresentismo.empleadosSupervisados(idSUpSel, socSupSel, fechaAltaEmpSel);
        }
        catch (MsgException e) {
            RhCrucesPresentismoServlet.log.error((Object)e.getMessage(), (Throwable)e);
        }
        return json;
    }
    
    private String graboEmpleadosComboJust(final HttpServletRequest req, final String usrId) throws MsgException {
        final String retData = "";
        final String emple = req.getParameter("map");
        final String codArea = "";
        final RhGralAppSessionContext asc = new RhGralAppSessionContext();
        RhGralLegajo legajo = null;
        legajo = asc.getLegajo(req.getSession());
        final RhDatosAusentismo horasAusentismo = new RhDatosAusentismo();
        final String error = horasAusentismo.updateAusentismo(emple, codArea, usrId);
        if (error == null) {
            System.out.println("sin error");
            return retData;
        }
        if (error != null && !error.equals("")) {
            throw new MsgException(RhAusentismoServlet.remove1(error));
        }
        throw new MsgException("Ha ocurrido un error al grabar");
    }
    
    private String consultaInicialDelegaciones_miras_miv(final HttpServletRequest req, final HttpServletResponse resp, final RhGralLegajo legajo) throws ServletException, IOException {
        String cruces = "";
        try {
            final RhCargarDelegacion cargarDelegacion = new RhCargarDelegacion();
            final String idEmpleLog = legajo.getNumeroLegajo();
            final String socEmpleLog = legajo.getSociedad();
            final String tipoDelegacion = req.getParameter("tipoDelegacion");
            final Date fechaAlta = this.fechaAltaEmpleado(idEmpleLog, socEmpleLog);
            cruces = cargarDelegacion.consultaInicialDelegaciones_miras_miv(idEmpleLog, socEmpleLog, fechaAlta, tipoDelegacion);
        }
        catch (MsgException e) {
            RhCrucesPresentismoServlet.log.error((Object)e.getMessage(), (Throwable)e);
        }
        return cruces;
    }
    
    private String consultaInicialDelegaciones(final HttpServletRequest req, final HttpServletResponse resp, final RhGralLegajo legajo) throws ServletException, IOException {
        String cruces = "";
        try {
            final RhCargarDelegacion cargarDelegacion = new RhCargarDelegacion();
            final String idEmpleLog = legajo.getNumeroLegajo();
            final String socEmpleLog = legajo.getSociedad();
            final Date fechaAlta = this.fechaAltaEmpleado(idEmpleLog, socEmpleLog);
            cruces = cargarDelegacion.consultaInicialDelegaciones(idEmpleLog, socEmpleLog, fechaAlta);
        }
        catch (MsgException e) {
            RhCrucesPresentismoServlet.log.error((Object)e.getMessage(), (Throwable)e);
        }
        return cruces;
    }
    
    private String consultaEmpleadosDelegados_miras_miv(final HttpServletRequest req, final HttpServletResponse resp, final RhGralLegajo legajo) throws ServletException, IOException {
        String empleados = "";
        try {
            final String idLegajo = legajo.getNumeroLegajo();
            final String idSociedad = legajo.getSociedad();
            final String tipoDelegacion = req.getParameter("tipoDel");
            final Date fechaAlta = this.fechaAltaEmpleado(idLegajo, idSociedad);
            final RhCargarDelegacion cargarDelegacion = new RhCargarDelegacion();
            empleados = cargarDelegacion.listadoDelegado_miras_miv(idLegajo, idSociedad, fechaAlta, tipoDelegacion);
        }
        catch (MsgException e) {
            RhCrucesPresentismoServlet.log.error((Object)e.getMessage(), (Throwable)e);
            e.printStackTrace();
        }
        return empleados;
    }
    
    private String consultaEmpleadosDelegados(final HttpServletRequest req, final HttpServletResponse resp, final RhGralLegajo legajo) throws ServletException, IOException {
        String empleados = "";
        try {
            final String idLegajo = legajo.getNumeroLegajo();
            final String idSociedad = legajo.getSociedad();
            final Date fechaAlta = this.fechaAltaEmpleado(idLegajo, idSociedad);
            final RhCargarDelegacion cargarDelegacion = new RhCargarDelegacion();
            empleados = cargarDelegacion.listadoDelegado(idLegajo, idSociedad, fechaAlta);
        }
        catch (MsgException e) {
            RhCrucesPresentismoServlet.log.error((Object)e.getMessage(), (Throwable)e);
            e.printStackTrace();
        }
        return empleados;
    }
    
    private String cargarDelegacion(final HttpServletRequest req, final HttpServletResponse resp, final RhGralLegajo legajo) throws ServletException, IOException {
        String error = "";
        try {
            final RhCargarDelegacion cargarDelegacion = new RhCargarDelegacion();
            final String idLegajo = legajo.getNumeroLegajo();
            final String idSociedad = legajo.getSociedad();
            final String empleadoSel = req.getParameter("empleadoSel");
            String tipoDelegacion = req.getParameter("tipoDelegacion");
            String idEmpleadoSel = "";
            String socEmpleadoSel = "";
            if (empleadoSel != null && !empleadoSel.trim().equals("")) {
                idEmpleadoSel = empleadoSel.substring(2);
                socEmpleadoSel = empleadoSel.substring(0, 2);
            }
            if (tipoDelegacion == null) {
                tipoDelegacion = "AUS";
            }
            final Date fechaAusDesde = this.fechaStrADate(req.getParameter("fechaDesde"));
            final Date fechaAusHasta = this.fechaStrADate(req.getParameter("fechaHasta"));
            final int estado = 4;
            error = cargarDelegacion.cargarDelegacion(idLegajo, idSociedad, idEmpleadoSel, socEmpleadoSel, fechaAusDesde, fechaAusHasta, estado, fechaAusHasta, tipoDelegacion);
        }
        catch (MsgException e) {
            RhCrucesPresentismoServlet.log.error((Object)e.getMessage(), (Throwable)e);
            e.printStackTrace();
        }
        return error;
    }
    
    private String eliminarDelegacion(final HttpServletRequest req, final HttpServletResponse resp, final RhGralLegajo legajo) throws ServletException, IOException {
        String error = "";
        try {
            final RhCargarDelegacion cargarDelegacion = new RhCargarDelegacion();
            final String idDelegacion = req.getParameter("idDelegacion");
            error = cargarDelegacion.eliminarDelegacion(idDelegacion);
        }
        catch (MsgException e) {
            RhCrucesPresentismoServlet.log.error((Object)e.getMessage(), (Throwable)e);
            e.printStackTrace();
        }
        return error;
    }
    
    private String getArchivosEstAdmin(final HttpServletRequest req, final HttpServletResponse resp, final RhGralLegajo legajo) throws ServletException, IOException {
        String data = "";
        final RhCuentaCorrienteDAO cuentaCorriente = new RhCuentaCorrienteDAO();
        final String ID_AG_ARCHIVOS = "AF";
        data = cuentaCorriente.getGrillaArchivosEstAdmin(ID_AG_ARCHIVOS);
        return data;
    }
    
    private String getGrillaArchivosGestorContenidos(final HttpServletRequest req, final HttpServletResponse resp, final RhGralLegajo legajo) throws ServletException, IOException {
        String data = "";
        System.out.println(legajo.getUsrId());
        final RhCuentaCorrienteDAO cuentaCorriente = new RhCuentaCorrienteDAO();
        final String ID_AG_ARCHIVOS = req.getParameter("ID_AG_ARCHIVOS");
        data = cuentaCorriente.getGrillaArchivosGestorContenidos(ID_AG_ARCHIVOS);
        return data;
    }
    
    private String getArchivosPrepagas(final HttpServletRequest req, final HttpServletResponse resp, final RhGralLegajo legajo) throws ServletException, IOException {
        String data = "";
        System.out.println(legajo.getUsrId());
        final RhCuentaCorrienteDAO cuentaCorriente = new RhCuentaCorrienteDAO();
        final String idMedicinaPrepaga = req.getParameter("idMedicinaPrepaga1");
        data = cuentaCorriente.getGrillaArchivosPrepaga(idMedicinaPrepaga);
        return data;
    }
    
    private String datosCuentaCorriente(final HttpServletRequest req, final HttpServletResponse resp, final RhGralLegajo legajo) throws ServletException, IOException {
        String data = "";
        final RhCuentaCorrienteDAO cuentaCorriente = new RhCuentaCorrienteDAO();
        final String legajoCons = req.getParameter("legajoCons");
        final String admin = req.getParameter("admin");
        if (admin.equalsIgnoreCase("S")) {
            data = cuentaCorriente.getDatosPrepagaAdmin(legajoCons.trim());
        }
        else {
            data = cuentaCorriente.getDatosPrepaga(legajo.getUsrId());
        }
        return data;
    }
    
    private String datosFamiliares(final HttpServletRequest req, final HttpServletResponse resp, final RhGralLegajo legajo) throws ServletException, IOException {
        String leg = req.getParameter("leg");
        if (leg == null) {
            leg = legajo.getUsrId();
        }
        String data = "";
        System.out.println("leg: " + leg);
        final RhCuentaCorrienteDAO cuentaCorriente = new RhCuentaCorrienteDAO();
        data = cuentaCorriente.getDatosFamiliares(leg);
        return data;
    }
    
    private String datosCuentaCorrienteDetalle(final HttpServletRequest req, final HttpServletResponse resp, final RhGralLegajo legajo) throws ServletException, IOException {
        String fechaPago = req.getParameter("fecPago");
        fechaPago = fechaPago.replaceAll("-", "/");
        final Date fecPago = this.fechaStrADate(fechaPago, "yyyy/MM/dd");
        final String tipoFamiliar = req.getParameter("tipoFamiliar");
        String leg = req.getParameter("leg");
        if (leg == null) {
            leg = legajo.getUsrId();
        }
        String data = "";
        System.out.println("leg: " + leg);
        final RhCuentaCorrienteDAO cuentaCorriente = new RhCuentaCorrienteDAO();
        data = cuentaCorriente.getDatosDetalle(leg, fecPago, tipoFamiliar);
        return data;
    }
    
    private String contactoPrepagas(final HttpServletRequest req, final HttpServletResponse resp, final RhGralLegajo legajo) throws ServletException, IOException {
        final String idMedicinaPrepaga = req.getParameter("idMed");
        String data = "";
        final RhCuentaCorrienteDAO cuentaCorriente = new RhCuentaCorrienteDAO();
        data = cuentaCorriente.getDatosContactoPrepaga(idMedicinaPrepaga);
        return data;
    }
    
    private String datosSanatorios(final HttpServletRequest req, final HttpServletResponse resp, final RhGralLegajo legajo) throws ServletException, IOException {
        final String idMedicinaPrepaga = req.getParameter("idMed");
        String data = "";
        final RhCuentaCorrienteDAO cuentaCorriente = new RhCuentaCorrienteDAO();
        data = cuentaCorriente.datosSanatorio(idMedicinaPrepaga);
        return data;
    }
    
    private String getGrillaPDFPlanes(final HttpServletRequest req, final HttpServletResponse resp, final RhGralLegajo legajo) throws ServletException, IOException {
        String data = "";
        final String idMedicinaPrepaga = req.getParameter("idMedicinaPrepaga");
        final RhCuentaCorrienteDAO cuentaCorriente = new RhCuentaCorrienteDAO();
        data = cuentaCorriente.getGrillaPDFPlanes(idMedicinaPrepaga);
        return data;
    }
    
    private String consultarTiposAnticipo(final HttpServletRequest req, final String usrId, final String idSociedad) throws MsgException {
        String retData = "";
        final AdelantoSueldoDAO sueldoDAO = new AdelantoSueldoDAO();
        retData = sueldoDAO.consultarTiposAdelanto(usrId, idSociedad);
        return retData;
    }
    
    private String altaSolicitud(final HttpServletRequest req, final String usrId, final String idSociedad, final RhGralLegajo legajo) throws MsgException, ParseException {
        String retData = "";
        final AdelantoSueldoDAO sueldoDAO = new AdelantoSueldoDAO();
        final String tipoAnticipo = req.getParameter("idTipoAnticipo");
        final String monto = req.getParameter("monto");
        retData = sueldoDAO.altaSolicitud(usrId, idSociedad, legajo, tipoAnticipo, monto);
        return retData;
    }
    
    private String updateSolicitud(final HttpServletRequest req, final String usrId, final String idSociedad, final RhGralLegajo legajo) throws MsgException, ParseException {
        String retData = "";
        final AdelantoSueldoDAO sueldoDAO = new AdelantoSueldoDAO();
        final String tipoAnticipo = req.getParameter("idTipoAnticipo");
        final String monto = req.getParameter("monto");
        final String fechaAltaM = req.getParameter("fechaAltaM");
        retData = sueldoDAO.updateSolicitud(usrId, idSociedad, legajo, tipoAnticipo, monto, fechaAltaM);
        return retData;
    }
    
    private String listaAnticipos(final HttpServletRequest req, final String usrId, final String idSociedad) throws MsgException, ParseException {
        String retData = "";
        final AdelantoSueldoDAO sueldoDAO = new AdelantoSueldoDAO();
        retData = sueldoDAO.listaAdelantos(usrId, idSociedad);
        return retData;
    }
    
    private String eliminarSolicitud(final HttpServletRequest req, final String usrId, final String idSociedad) throws MsgException, ParseException {
        String retData = "";
        final String pIdAnticipo = req.getParameter("pIdAnticipo");
        final String PfecSoli = req.getParameter("PfecSoli");
        final AdelantoSueldoDAO sueldoDAO = new AdelantoSueldoDAO();
        retData = sueldoDAO.eliminarSolicitud(usrId, idSociedad, pIdAnticipo, PfecSoli);
        return retData;
    }
    
    public static String remove1(final String input) {
        final String original = "\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd\ufffdu\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd";
        final String ascii = "aaaeeeiiiooouuunAAAEEEIIIOOOUUUNcC";
        String output = input;
        for (int i = 0; i < original.length(); ++i) {
            output = output.replace(original.charAt(i), ascii.charAt(i));
        }
        return output;
    }
}
