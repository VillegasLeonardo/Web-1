<%@ page import="org.gerdoc.service.AlumnoMateriaService" %>
<%@ page import="org.gerdoc.service.impl.AlumnoMateriaServiceImpl" %>
<%@ page import="org.gerdoc.model.AlumnoMateria" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html lang="es">
<head>
    <meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Detalle de inscripción</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container py-4">
    <h1>Información de la inscripción</h1>
    <%
        AlumnoMateria item = null;
        String idValue = request.getParameter("id");
        if (idValue != null) {
            try { item = new AlumnoMateriaServiceImpl().findById(Long.parseLong(idValue)); }
            catch (NumberFormatException ignored) { }
        }
    %>
    <% if (item == null) { %><div class="alert alert-warning">No se encontró la inscripción solicitada.</div><% } else { %>
    <table class="table"><tbody>
        <tr><th>Alumno</th><td><%= item.getAlumno().getNombre() %></td></tr>
        <tr><th>Materia</th><td><%= item.getMateria().getNombre() %></td></tr>
        <tr><th>Calificación</th><td><%= item.getCalificacion() == null ? "Sin calificar" : item.getCalificacion().toPlainString() %></td></tr>
    </tbody></table>
    <% } %>
    <a href="AlumnoMaterias.jsp" class="btn btn-secondary">Regresar</a>
</div>
</body>
</html>
