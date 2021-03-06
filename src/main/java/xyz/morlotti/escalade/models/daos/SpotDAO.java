package xyz.morlotti.escalade.models.daos;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import xyz.morlotti.escalade.models.beans.Spot;
import xyz.morlotti.escalade.models.beans.Topo;

import javax.persistence.TypedQuery;
import javax.transaction.Transactional;
import java.util.*;

@Repository
@Transactional
public class SpotDAO
{
    @Autowired
    private SessionFactory sessionFactory;

    public void add(Spot spot)
    {
        Session currentSession = sessionFactory.getCurrentSession();

        currentSession.save(spot);
    }

    public void update(Spot spot)
    {
        Session currentSession = sessionFactory.getCurrentSession();

        currentSession.merge(spot);
    }

    public void delete(int id)
    {
        Session currentSession = sessionFactory.getCurrentSession();

        Spot spot = currentSession.find(Spot.class, id);

        currentSession.delete(spot);
    }

    public Spot get(int id)
    {
        Session currentSession = sessionFactory.getCurrentSession();

        return currentSession.find(Spot.class, id);
    }

    public List<Spot> list() throws Exception
    {
        Session currentSession = sessionFactory.getCurrentSession();

        Query query = currentSession.createQuery("SELECT s FROM SPOT s");

        return query.list();
    }

    public List<Spot> list(int parentUser) throws Exception
    {
        Session currentSession = sessionFactory.getCurrentSession();

        TypedQuery<Spot> query = currentSession.createQuery("SELECT s FROM SPOT s WHERE s.userFK.id = ?1", Spot.class);

        return query.setParameter(1, parentUser).getResultList();
    }

	public List<Spot> get(String departement, Long nbofsectors, Long nbofvoies, String cotation)
    {
        Set<String> entities = new LinkedHashSet<>(); // Pour mettre dans la partie FROM
        Set<String> paths = new LinkedHashSet<>(); // Pour mettre dans la partie WHERE (CHEMINS)
        Set<String> conds = new LinkedHashSet<>(); // Pour mettre dans la partie WHERE (EXPRESSIONS)

        entities.add("SPOT s1");
        conds.add("1 = 1");

        if(departement != null)
        {
            conds.add("s1.departement = :departement");
        }

        if(nbofsectors != null)
        {
            conds.add(":nbofsectors = (SELECT COUNT(*) FROM SECTEUR s2 WHERE s2.spotFK.id = s1.id)");
        }

        if(nbofvoies != null)
        {
            entities.add("SECTEUR s2");
            paths.add("s2.spotFK = s1.id");

            conds.add(":nbofvoies = (SELECT COUNT(*) FROM VOIE v WHERE v.sectorFK.id = s2.id)");
        }

        if(cotation != null)
        {
            entities.add("SECTEUR s2");
            paths.add("s2.spotFK = s1.id");

            entities.add("VOIE v");
            paths.add("v.sectorFK = s2.id");

            entities.add("LENGTH l"); /* nécessaire pour les jointures cotation->length->voies */
            paths.add("l.voieFK = v.id");
            paths.add("l.cotationFK = c.id");

            entities.add("COTATION c");

            conds.add("c.name = :cotation");
        }

        paths.addAll(conds);

        String sql = "SELECT s1" +
                     " FROM " + String.join(", ", entities) +
                     " WHERE " + String.join(" AND ", paths)
        ;

        Session currentSession = sessionFactory.getCurrentSession();

        TypedQuery<Spot> query = currentSession.createQuery(sql, Spot.class);

        if(departement != null) {
            query.setParameter("departement", departement);
        }

        if(nbofsectors != null) {
            query.setParameter("nbofsectors", nbofsectors);
        }

        if(nbofvoies != null) {
            query.setParameter("nbofvoies", nbofvoies);
        }

        if(cotation != null) {
            query.setParameter("cotation", cotation);
        }

        return query.getResultList();
    }
}
