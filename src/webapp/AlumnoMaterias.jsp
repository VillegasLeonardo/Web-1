<%@ page import="org.gerdoc.service.AlumnoMateriaService" %>
<%@ page import="org.gerdoc.service.impl.AlumnoMateriaServiceImpl" %>
<%@ page import="org.gerdoc.model.AlumnoMateria" %>
<%@ page import="org.gerdoc.service.AlumnoService" %>
<%@ page import="org.gerdoc.service.impl.AlumnoServiceImpl" %>
<%@ page import="org.gerdoc.service.MateriaService" %>
<%@ page import="org.gerdoc.service.impl.MateriaServiceImpl" %>
<%@ page import="org.gerdoc.model.Alumno" %>
<%@ page import="org.gerdoc.model.Materia" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Alumno Materias</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container py-4">
    <h1>Alumno Materias</h1>
    <%
        AlumnoMateriaService service = new AlumnoMateriaServiceImpl();
        List<AlumnoMateria> inscripciones = service.findAll();
        List<Alumno> alumnos = new AlumnoServiceImpl().findAll();
        List<Materia> materias = new MateriaServiceImpl().findAll();
        String error = (String) session.getAttribute("alumnoMateriaError");
        if (error != null) { session.removeAttribute("alumnoMateriaError"); }
    %>
    <% if (error != null) { %><div class="alert alert-danger" role="alert"><%= error %></div><% } %>
    <% if (alumnos.isEmpty() || materias.isEmpty()) { %>
        <div class="alert alert-info">Primero registra al menos un alumno y una materia para crear una inscripción.</div>
    <% } else { %>
        <button type="button" class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#alumnoMateriaModal" onclick="nuevaInscripcion()">Agregar inscripción</button>
    <% } %>
    <table class="table table-striped">
        <thead><tr><th>#</th><th>Alumno</th><th>Materia</th><th>Calificación</th><th>Acción</th></tr></thead>
        <tbody>
        <% int i = 0; for (AlumnoMateria item : inscripciones) { %>
            <tr>
                <th scope="row"><%= ++i %></th>
                <td><a href="AlumnoMateria.jsp?id=<%= item.getId() %>" class="link-primary"><%= item.getAlumno().getNombre() %></a></td>
                <td><%= item.getMateria().getNombre() %></td>
                <td><%= item.getCalificacion() == null ? "Sin calificar" : item.getCalificacion().toPlainString() %></td>
                <td class="text-nowrap">
                    <button type="button" class="btn btn-warning btn-sm btn-editar" data-bs-toggle="modal" data-bs-target="#alumnoMateriaModal"
                            data-id="<%= item.getId() %>" data-alumno-id="<%= item.getAlumno().getId() %>" data-materia-id="<%= item.getMateria().getId() %>"
                            data-calificacion="<%= item.getCalificacion() == null ? "" : item.getCalificacion().toPlainString() %>">Editar</button>
                    <form action="AlumnoMateriaServlet" method="post" class="d-inline">
                        <input type="hidden" name="accion" value="delete"><input type="hidden" name="id" value="<%= item.getId() %>">
                        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('¿Seguro que deseas borrar esta inscripción?');">Borrar</button>
                    </form>
                </td>
            </tr>
        <% } %>
        </tbody>
    </table>
    <a href="index.jsp" class="btn btn-secondary">Home</a>
</div>

<div class="modal fade" id="alumnoMateriaModal" tabindex="-1" aria-labelledby="alumnoMateriaModalLabel" aria-hidden="true">
    <div class="modal-dialog"><div class="modal-content">
        <div class="modal-header"><h5 class="modal-title" id="alumnoMateriaModalLabel">Formulario de alumno-materia</h5><button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button></div>
        <form action="AlumnoMateriaServlet" method="post" id="formAlumnoMateria">
            <input type="hidden" id="accion" name="accion" value="save"><input type="hidden" id="id" name="id" value="0">
            <div class="modal-body">
                <div class="mb-3"><label for="alumnoId" class="form-label">Alumno</label><select class="form-select" id="alumnoId" name="alumnoId" required><option value="">Selecciona un alumno</option>
                    <% for (Alumno alumno : alumnos) { %><option value="<%= alumno.getId() %>"><%= alumno.getNombre() %></option><% } %>
                </select></div>
                <div class="mb-3"><label for="materiaId" class="form-label">Materia</label><select class="form-select" id="materiaId" name="materiaId" required><option value="">Selecciona una materia</option>
                    <% for (Materia materia : materias) { %><option value="<%= materia.getId() %>"><%= materia.getNombre() %></option><% } %>
                </select></div>
                <div class="mb-3"><label for="calificacion" class="form-label">Calificación</label><input type="number" class="form-control" id="calificacion" name="calificacion" min="0" max="10" step="0.01"><div class="form-text">Opcional, de 0 a 10.</div></div>
            </div>
            <div class="modal-footer"><button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button><button type="submit" class="btn btn-primary" id="btnGuardar">Guardar inscripción</button></div>
        </form>
    </div></div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function nuevaInscripcion() {
        document.getElementById('formAlumnoMateria').reset();
        document.getElementById('id').value = '0';
        document.getElementById('accion').value = 'save';
        document.getElementById('alumnoMateriaModalLabel').textContent = 'Agregar inscripción';
        document.getElementById('btnGuardar').textContent = 'Guardar inscripción';
    }
    document.getElementById('alumnoMateriaModal').addEventListener('show.bs.modal', function (event) {
        const button = event.relatedTarget;
        if (!button || !button.classList.contains('btn-editar')) return;
        document.getElementById('id').value = button.dataset.id;
        document.getElementById('alumnoId').value = button.dataset.alumnoId;
        document.getElementById('materiaId').value = button.dataset.materiaId;
        document.getElementById('calificacion').value = button.dataset.calificacion;
        document.getElementById('accion').value = 'update';
        document.getElementById('alumnoMateriaModalLabel').textContent = 'Editar inscripción';
        document.getElementById('btnGuardar').textContent = 'Actualizar inscripción';
    });
</script>
</body>
</html>
