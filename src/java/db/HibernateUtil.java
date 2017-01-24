package db;

import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.AnnotationConfiguration;

public class HibernateUtil {
    

    private static final SessionFactory sessionFactory;
    
    static 
    {
        try 
        {
            AnnotationConfiguration config = new AnnotationConfiguration();
            config.configure();
            sessionFactory = config.buildSessionFactory();
        } 
        catch (HibernateException ex) 
        {
            // Log the exception. 
            System.out.println("Initial SessionFactory creation failed." + ex);
            System.out.println(ex.getMessage());
            throw new ExceptionInInitializerError(ex);
        }
    }
    
    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }
}
