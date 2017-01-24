package service;

import db.HibernateUtil;
import entities.Ids;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class IdsIO {

    public static int getUserId() {
        SessionFactory sessionfactory = HibernateUtil.getSessionFactory();
        Session session = sessionfactory.getCurrentSession();
        Transaction tx = null;
        Ids ids;
        int id;
        try {
            tx = session.getTransaction();
            tx.begin();
            Query query = session.createQuery("from Ids ids where ids.name='user_id'");
            ids = (Ids) query.uniqueResult();
            id = ids.getIdNum();
            ids.setIdNum(ids.getIdNum() + 1);
            session.update(ids);
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            return 0;
        }
        return id;
    }

    public static int getMessageId() {
        SessionFactory sessionfactory = HibernateUtil.getSessionFactory();
        Session session = sessionfactory.getCurrentSession();
        Transaction tx = null;
        Ids ids;
        int id;
        try {
            tx = session.getTransaction();
            tx.begin();
            Query query = session.createQuery("from Ids ids where ids.name='message_id'");
            ids = (Ids) query.uniqueResult();
            id = ids.getIdNum();
            ids.setIdNum(ids.getIdNum() + 1);
            session.update(ids);
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            return 0;
        }
        return id;
    }

    public static int getPhotoId() {
        SessionFactory sessionfactory = HibernateUtil.getSessionFactory();
        Session session = sessionfactory.getCurrentSession();
        Transaction tx = null;
        Ids ids;
        int id;
        try {
            tx = session.getTransaction();
            tx.begin();
            Query query = session.createQuery("from Ids ids where ids.name='photo_id'");
            ids = (Ids) query.uniqueResult();
            id = ids.getIdNum();
            ids.setIdNum(ids.getIdNum() + 1);
            session.update(ids);
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            return 0;
        }
        return id;
    }

    public static int getPropertyId() {
        SessionFactory sessionfactory = HibernateUtil.getSessionFactory();
        Session session = sessionfactory.getCurrentSession();
        Transaction tx = null;
        Ids ids;
        int id;
        try {
            tx = session.getTransaction();
            tx.begin();
            Query query = session.createQuery("from Ids ids where ids.name='property_id'");
            ids = (Ids) query.uniqueResult();
            id = ids.getIdNum();
            ids.setIdNum(ids.getIdNum() + 1);
            session.update(ids);
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            return 0;
        }
        return id;
    }
}
