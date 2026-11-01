package org.gerdoc.servlet;

import org.gerdoc.model.Alumno;
import org.gerdoc.model.AlumnoMateria;
import org.gerdoc.model.Materia;
import org.gerdoc.service.AlumnoMateriaService;
import org.gerdoc.service.AlumnoService;
import org.gerdoc.service.MateriaService;
import org.gerdoc.service.impl.AlumnoMateriaServiceImpl;
import org.gerdoc.service.impl.AlumnoServiceImpl;
import org.gerdoc.service.impl.MateriaServiceImpl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Serial;
import java.math.BigDecimal;

@WebServlet("/AlumnoMateriaServlet")
public class AlumnoMateriaServlet extends HttpServlet {
    @Serial private static final long serialVersionUID = 1L;
    private final AlumnoMateriaService alumnoMateriaService = new AlumnoMateriaServiceImpl();
    private final AlumnoService alumnoService = new AlumnoServiceImpl();
    private final MateriaService materiaService = new MateriaServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("accion");
        try {
            Long id = Long.parseLong(req.getParameter("id"));
            if ("delete".equals(action)) {
                alumnoMateriaService.deleteById(id);
            } else {
                Long alumnoId = Long.parseLong(req.getParameter("alumnoId"));
                Long materiaId = Long.parseLong(req.getParameter("materiaId"));
                Alumno alumno = alumnoService.findById(alumnoId);
                Materia materia = materiaService.findById(materiaId);
                if (alumno == null || materia == null) throw new IllegalArgumentException("Selecciona un alumno y una materia existentes.");
                String gradeValue = req.getParameter("calificacion");
                BigDecimal grade = gradeValue == null || gradeValue.isBlank() ? null : new BigDecimal(gradeValue);
                if (grade != null && (grade.compareTo(BigDecimal.ZERO) < 0 || grade.compareTo(BigDecimal.TEN) > 0)) {
                    throw new IllegalArgumentException("La calificación debe estar entre 0 y 10.");
                }
                AlumnoMateria item = AlumnoMateria.builder().id(id == 0 ? null : id).alumno(alumno).materia(materia).calificacion(grade).build();
                if ("update".equals(action)) alumnoMateriaService.update(item);
                else alumnoMateriaService.save(item);
            }
            resp.sendRedirect("AlumnoMaterias.jsp");
        } catch (RuntimeException e) {
            req.getSession().setAttribute("alumnoMateriaError", "No se pudo completar la operación. Verifica que la inscripción no esté duplicada y que los datos sean válidos.");
            resp.sendRedirect("AlumnoMaterias.jsp");
        }
    }
}
