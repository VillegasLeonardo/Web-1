package org.gerdoc.service.impl;

import org.gerdoc.dao.AlumnoMateriaDao;
import org.gerdoc.dao.impl.AlumnoMateriaDaoImpl;
import org.gerdoc.model.AlumnoMateria;
import org.gerdoc.service.AlumnoMateriaService;
import java.util.List;

public class AlumnoMateriaServiceImpl implements AlumnoMateriaService {
    private final AlumnoMateriaDao alumnoMateriaDao = new AlumnoMateriaDaoImpl();
    @Override public List<AlumnoMateria> findAll() { return alumnoMateriaDao.findAll(); }
    @Override public AlumnoMateria findById(Long id) { return alumnoMateriaDao.findById(id); }
    @Override public void save(AlumnoMateria item) { alumnoMateriaDao.save(item); }
    @Override public void update(AlumnoMateria item) { alumnoMateriaDao.update(item); }
    @Override public void deleteById(Long id) { alumnoMateriaDao.deleteById(id); }
}
