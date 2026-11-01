package org.gerdoc.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.math.BigDecimal;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "ALUMNO_MATERIA")
public class AlumnoMateria {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "ALUMNO_ID", nullable = false)
    private Alumno alumno;

    @ManyToOne(optional = false)
    @JoinColumn(name = "MATERIA_ID", nullable = false)
    private Materia materia;

    @Column(name = "CALIFICACION", precision = 4, scale = 2)
    private BigDecimal calificacion;
}
