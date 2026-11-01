<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
</head>
<body>
<div class="container">
    <h1>Proyecto funcionando</h1>
    <table class="table">
    <thead>
        <tr>
            <th scope="col">ID</th>
            <th scope="col">Nombre</th>
            <th scope="col">Apellido</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <th scope="row">1</th>
            <td>Gerdoc</td>
            <td>Gutiérrez</td>
        </tr>
    </tbody>
    </table>
    <a href="MiServlet">Ejecutar Servlet</a>
º</div>
<div class="container">
    <h1>Formularios</h1>
    <form action="MiServlet" method="get">
        <div class="mb-3">
            <label for="exampleInputEmail1" class="form-label">Email address</label>
            <input type="email" class="form-control" id="exampleInputEmail1" name="exampleInputEmail1" aria-describedby="emailHelp">
            <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
        </div>
        <div class="mb-3">
            <label for="exampleSelect" class="form-label">Números</label>
            <select id="exampleSelect" name="exampleSelect" class="form-select" aria-label="Default select example" aria-describedby="selectHelp">
                <option selected>Open this select menu</option>
                <option value="1">One</option>
                <option value="2">Two</option>
                <option value="3">Three</option>
            </select>
            <div id="selectHelp" class="form-text">Test.</div>
        </div>
        <button type="submit" class="btn btn-primary">
            Enviar información
        </button>
    </form>
    <p>
        <br/>
        <a href="Alumnos.jsp" class="btn btn-secondary">Alumnos</a>
        <a href="Profesores.jsp" class="btn btn-secondary">Profesores</a>
        <a href="Materias.jsp" class="btn btn-secondary">Materias</a>
        <a href="ProfesorMaterias.jsp" class="btn btn-secondary">Profesor Materias</a>
        <a href="AlumnoMaterias.jsp" class="btn btn-secondary">Alumno Materias</a>
    </p>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>
