package service;

import entities.Algorithm;
import db.HibernateUtil;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class AlgorithmIO {

    public static Algorithm getAlgorithm(String name) {
        SessionFactory sessionfactory = HibernateUtil.getSessionFactory();
        Session session = sessionfactory.getCurrentSession();
        Transaction tx = null;
        Algorithm algorithm = null;
        try {
            tx = session.getTransaction();
            tx.begin();
            Query query = session.createQuery("from Algorithm algorithm where algorithm.name='" + name + "'");
            algorithm = (Algorithm) query.uniqueResult();
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            return null;
        }
        return algorithm;
    }

    public static boolean runningSaw() {
        Algorithm algorithm = getAlgorithm("saw");
        if (algorithm != null) {
            return algorithm.isRunning();
        } else {
            return false;
        }
    }

    public static boolean runningTopsis() {
        Algorithm algorithm = getAlgorithm("topsis");
        if (algorithm != null) {
            return algorithm.isRunning();
        } else {
            return false;
        }
    }

    public static void setAlgorithm(String name) {
        Algorithm algorithm_set, algorithm_unset;
        if (name.equals("saw")) {
            algorithm_set = getAlgorithm("saw");
            algorithm_unset = getAlgorithm("topsis");
        } else {
            algorithm_set = getAlgorithm("topsis");
            algorithm_unset = getAlgorithm("saw");
        }
        algorithm_set.setRunning(true);
        algorithm_unset.setRunning(false);
        Session session;
        Transaction transaction = null;
        try {
            SessionFactory factory = HibernateUtil.getSessionFactory();
            session = factory.getCurrentSession();
            transaction = session.beginTransaction();
            session.update(algorithm_set);
            session.update(algorithm_unset);
            transaction.commit();
        } catch (HibernateException ex) {
            System.out.println(ex.getMessage());
            if (transaction != null) {
                transaction.rollback();
            }
        }
    }
}
