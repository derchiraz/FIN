package com.eadn.service;

import com.eadn.entity.Opportunite;
import jakarta.ejb.Stateless;
import jakarta.persistence.*;

import java.util.List;

@Stateless
public class OpportuniteService {

    @PersistenceContext
    private EntityManager em;
    
    public List<Opportunite> findAll() {
        try {
            return em.createQuery("SELECT o FROM Opportunite o ORDER BY o.dateCreation DESC", Opportunite.class)
                    .getResultList();
        } catch (Exception e) {
            System.err.println("Erreur lors de la récupération des opportunités: " + e.getMessage());
            e.printStackTrace();
            return java.util.Collections.emptyList();
        }
    }
    
    public void save(Opportunite o) {
        em.persist(o);
    }

    public Opportunite findById(Long id) {
        return em.find(Opportunite.class, id);
    }

    public void update(Opportunite o) {
        em.merge(o);
    }

    // Version modifiée retournant un boolean
    public boolean delete(Long id) {
        try {
            Opportunite o = findById(id);
            if (o != null) {
                em.remove(o);
                return true;
            }
            return false;
        } catch (Exception e) {
            System.err.println("Erreur lors de la suppression de l'opportunité " + id + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Opportunite> findByStatus(String status) {
        return em.createQuery("SELECT o FROM Opportunite o WHERE o.status = :status ORDER BY o.dateCreation DESC", Opportunite.class)
                 .setParameter("status", status)
                 .getResultList();
    }
    
    public List<Opportunite> search(String term) {
        String searchTerm = "%" + term.toLowerCase() + "%";
        return em.createQuery(
                "SELECT o FROM Opportunite o WHERE " +
                "LOWER(o.nomEntreprise) LIKE :term OR " +
                "LOWER(o.nomOpportunite) LIKE :term OR " +
                "LOWER(o.nomContact) LIKE :term " +
                "ORDER BY o.dateCreation DESC", 
                Opportunite.class)
            .setParameter("term", searchTerm)
            .getResultList();
    }
    
}
