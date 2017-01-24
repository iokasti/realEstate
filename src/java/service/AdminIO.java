package service;

import db.HibernateUtil;
import entities.Admin;
import jBCrypt.BCrypt;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class AdminIO {

    public static Admin getAdmin(String username) {
        SessionFactory sessionfactory = HibernateUtil.getSessionFactory();
        Session session = sessionfactory.getCurrentSession();
        Transaction tx = null;
        Admin admin = null;
        try {
            tx = session.getTransaction();
            tx.begin();
            Query query = session.createQuery("from Admin admin where admin.username='" + username + "'");
            admin = (Admin) query.uniqueResult();
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            return null;
        }
        return admin;
    }

    public static boolean authenticate(String username, String password) {
        Admin admin = getAdmin(username);
        return admin != null && admin.getUsername().equals(username) && BCrypt.checkpw(password, admin.getPassword());
    }
}
