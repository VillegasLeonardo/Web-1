package org.gerdoc.dao;

import org.gerdoc.model.AlumnoMateria;
import java.util.List;

public interface AlumnoMateriaDao {
    List<AlumnoMateria> findAll();
    AlumnoMateria findById(Long id);
    AlumnoMateria save(AlumnoMateria alumnoMateria);
    AlumnoMateria update(AlumnoMateria alumnoMateria);
    void deleteById(Long id);
}
