package service;

import db.HibernateUtil;
import entities.Messages;
import entities.Property;
import entities.PropertyPhotos;
import entities.User;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class PropertyIO {

    public static boolean add(Property property, User user) {
        Session session;
        Transaction transaction = null;
        try {
            SessionFactory factory = HibernateUtil.getSessionFactory();
            session = factory.openSession();
            transaction = session.beginTransaction();
            session.save(property);
            user.setProperties(new HashSet<Property>(getProperties(user.getUserId(), user.getUsername())));
            user.getProperties().add(property);
            transaction.commit();
            session.close();
            return true;
        } catch (HibernateException ex) {
            System.out.println(ex.getMessage());
            if (transaction != null) {
                transaction.rollback();
            }
            return false;
        }
    }

    public static boolean add(PropertyPhotos photo) {
        Session session;
        Transaction transaction = null;
        try {
            SessionFactory factory = HibernateUtil.getSessionFactory();
            session = factory.openSession();
            transaction = session.beginTransaction();
            session.saveOrUpdate(photo);
            transaction.commit();
            session.close();
            return true;
        } catch (HibernateException ex) {
            System.out.println(ex.getMessage());
            if (transaction != null) {
                transaction.rollback();
            }
            return false;
        }
    }

    public static List<Property> getallProperties() {
        List<Property> list = new ArrayList<>();
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.getTransaction();
            tx.begin();
            list = session.createCriteria(Property.class).list();
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
        }
        session.close();
        return list;
    }

    public static List<Property> getProperties(int userId, String username) {
        List<Property> list = new ArrayList<>();
        List<Property> rlist = new ArrayList<>();
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.getTransaction();
            tx.begin();
            list = session.createCriteria(Property.class).list();
            for (Property p : list) {
                if (p.getId().getOwnerUserId() == userId) {
                    rlist.add(p);
                }
            }
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
        }
        session.close();
        return rlist;
    }

    public static Property getProperty(User user, int userId, String pid) {
        if (user == null) {
            user = UserIO.getUser(userId);
        }
        List<Property> properties = getProperties(userId, user.getUsername());
        for (Property p : properties) {
            if (p.getId().getPropertyId() == Integer.parseInt(pid)) {
                return p;
            }
        }
        return null;
    }

    public static List<PropertyPhotos> getPropertyPhotos(int pid) {
        List<PropertyPhotos> list = new ArrayList<>();
        List<PropertyPhotos> rlist = new ArrayList<>();
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.getTransaction();
            tx.begin();
            list = session.createCriteria(PropertyPhotos.class).list();
            tx.commit();
            for (PropertyPhotos pp : list) {
                if (pp.getId().getPropertyPropertyId() == pid) {
                    rlist.add(pp);
                }
            }
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
        }
        session.close();
        return rlist;
    }

    public static boolean edit(Property property) {
        Session session;
        Transaction transaction = null;
        try {
            SessionFactory factory = HibernateUtil.getSessionFactory();
            session = factory.openSession();
            transaction = session.beginTransaction();
            session.update(property);
            transaction.commit();
            session.close();
            return true;
        } catch (HibernateException ex) {
            System.out.println(ex.getMessage());
            if (transaction != null) {
                transaction.rollback();
            }
            return false;
        }
    }

    public static boolean delete(PropertyPhotos photo) throws IOException {
        Files.delete(Paths.get(photo.getPath()));
        Session session;
        Transaction transaction = null;
        try {
            SessionFactory factory = HibernateUtil.getSessionFactory();
            session = factory.openSession();
            transaction = session.beginTransaction();
            session.delete(photo);
            transaction.commit();
            session.close();
            return true;
        } catch (HibernateException ex) {
            System.out.println(ex.getMessage());
            if (transaction != null) {
                transaction.rollback();
            }
            return false;
        }
    }

    public static boolean add(Messages msge, String sender_id) {
        Session session;
        Transaction transaction = null;
        try {
            SessionFactory factory = HibernateUtil.getSessionFactory();
            session = factory.openSession();
            transaction = session.beginTransaction();
            if (msge.getUser() == null) {
                msge.setUser(UserIO.getUser(Integer.parseInt(sender_id)));
            }
            session.save(msge);
            transaction.commit();
            session.close();
            return true;
        } catch (HibernateException ex) {
            System.out.println(ex.getMessage());
            if (transaction != null) {
                transaction.rollback();
            }
            return false;
        }
    }

    public static List<Messages> getmsgs(int uid, int pid) {
        List<Messages> list = new ArrayList<>();
        List<Messages> rlist = new ArrayList<>();
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.getTransaction();
            tx.begin();
            list = session.createCriteria(Messages.class).list();
            tx.commit();
            for (Messages m : list) {
                if (m.getId().getOwnerUserId() == uid && m.getId().getPropertyId() == pid) {
                    rlist.add(m);
                }
            }
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
        }
        session.close();
        return rlist;
    }

    public static boolean delete(String userid, String pid, String mid) {
        List<Messages> msgslst = getmsgs(Integer.parseInt(userid), Integer.parseInt(pid));
        Messages msg = null;
        for (Messages m : msgslst) {
            if (m.getId().getMessageId() == Integer.parseInt(mid)) {
                msg = m;
                break;
            }
        }
        Session session;
        Transaction transaction = null;
        try {
            SessionFactory factory = HibernateUtil.getSessionFactory();
            session = factory.openSession();
            transaction = session.beginTransaction();
            session.delete(msg);
            transaction.commit();
            session.close();
            return true;
        } catch (HibernateException ex) {
            System.out.println(ex.getMessage());
            if (transaction != null) {
                transaction.rollback();
            }
            return false;
        }
    }
}
