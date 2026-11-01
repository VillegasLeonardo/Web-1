package org.gerdoc.dao.impl;

import org.gerdoc.dao.AlumnoMateriaDao;
import org.gerdoc.model.AlumnoMateria;
import org.gerdoc.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import java.util.List;

public class AlumnoMateriaDaoImpl implements AlumnoMateriaDao {
    @Override
    public List<AlumnoMateria> findAll() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("select am from AlumnoMateria am join fetch am.alumno join fetch am.materia", AlumnoMateria.class).getResultList();
        }
    }

    @Override
    public AlumnoMateria findById(Long id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("select am from AlumnoMateria am join fetch am.alumno join fetch am.materia where am.id = :id", AlumnoMateria.class)
                    .setParameter("id", id).uniqueResult();
        }
    }

    @Override
    public AlumnoMateria save(AlumnoMateria alumnoMateria) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction transaction = session.beginTransaction();
            try {
                session.save(alumnoMateria);
                transaction.commit();
                return alumnoMateria;
            } catch (RuntimeException e) {
                if (transaction.isActive()) transaction.rollback();
                throw e;
            }
        }
    }

    @Override
    public AlumnoMateria update(AlumnoMateria alumnoMateria) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction transaction = session.beginTransaction();
            try {
                AlumnoMateria updated = (AlumnoMateria) session.merge(alumnoMateria);
                transaction.commit();
                return updated;
            } catch (RuntimeException e) {
                if (transaction.isActive()) transaction.rollback();
                throw e;
            }
        }
    }

    @Override
    public void deleteById(Long id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction transaction = session.beginTransaction();
            try {
                AlumnoMateria item = session.get(AlumnoMateria.class, id);
                if (item != null) session.delete(item);
                transaction.commit();
            } catch (RuntimeException e) {
                if (transaction.isActive()) transaction.rollback();
                throw e;
            }
        }
    }
}
