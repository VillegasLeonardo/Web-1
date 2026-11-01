package org.gerdoc.util;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class HibernateUtil
{
    private static final SessionFactory sessionFactory;
    static
    {
        try
        {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Configuration configuration = new Configuration().configure("hibernate.cfg.xml");
            configuration.setProperty("hibernate.connection.url", requiredSetting("DB_URL"));
            configuration.setProperty("hibernate.connection.username", requiredSetting("DB_USERNAME"));
            configuration.setProperty("hibernate.connection.password", requiredSetting("DB_PASSWORD"));
            sessionFactory = configuration.buildSessionFactory();
        }
        catch (Throwable e)
        {
            System.err.println( "Error al iniciar Hibernate: " + e.getMessage( ) );
            throw new ExceptionInInitializerError( e );
        }
    }

    public static SessionFactory getSessionFactory()
    {
        return sessionFactory;
    }

    private static String requiredSetting(String name)
    {
        String value = System.getenv(name);
        if (value == null || value.isBlank()) value = readDotEnv(name);
        if (value == null || value.isBlank())
        {
            throw new IllegalStateException("Falta configurar " + name + " en el entorno o en .env");
        }
        return value;
    }

    private static String readDotEnv(String name)
    {
        Path directory = Path.of("").toAbsolutePath();
        Path envFile = null;
        while (directory != null)
        {
            Path candidate = directory.resolve(".env");
            if (Files.isRegularFile(candidate))
            {
                envFile = candidate;
                break;
            }
            directory = directory.getParent();
        }
        if (envFile == null) return null;
        try (var lines = Files.lines(envFile))
        {
            return lines.map(String::trim)
                    .filter(line -> !line.isEmpty() && !line.startsWith("#"))
                    .filter(line -> line.startsWith(name + "="))
                    .map(line -> line.substring(line.indexOf('=') + 1).trim())
                    .map(value -> value.length() >= 2 && value.startsWith("\"") && value.endsWith("\"")
                            ? value.substring(1, value.length() - 1)
                            : value)
                    .findFirst()
                    .orElse(null);
        }
        catch (IOException e)
        {
            throw new IllegalStateException("No se pudo leer .env", e);
        }
    }
}
