
package com.eadn.service;

import com.eadn.entity.Projet;
import jakarta.ejb.Stateless;
import jakarta.persistence.*;

import java.util.List;

@Stateless
public class ProjetService {

    @PersistenceContext
    private EntityManager em;
    
    public List<Projet> findAll() {
        try {
            return em.createQuery("SELECT p FROM Projet p ORDER BY p.nom ASC", Projet.class)

                    .getResultList();
        } catch (Exception e) {
            System.err.println("Erreur lors de la récupération des projets: " + e.getMessage());
            e.printStackTrace();
            return java.util.Collections.emptyList();
        }
    }
    
    public void save(Projet p) {
        em.persist(p);
    }

    public Projet findById(Long id) {
        return em.find(Projet.class, id);
    }

    public void update(Projet p) {
        em.merge(p);
    }

    public boolean delete(Long id) {
        try {
            Projet p = findById(id);
            if (p != null) {
                em.remove(p);
                return true;
            }
            return false;
        } catch (Exception e) {
            System.err.println("Erreur lors de la suppression du projet " + id + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Projet> findByStatus(String status) {
        return em.createQuery("SELECT p FROM Projet p WHERE p.status = :status ORDER BY p.nom ASC", Projet.class)
                 .setParameter("status", status)
                 .getResultList();
    }
    
    public List<Projet> search(String term) {
        String searchTerm = "%" + term.toLowerCase() + "%";
        return em.createQuery(
                "SELECT p FROM Projet p WHERE " +
                "LOWER(p.nom) LIKE :term OR " +
                "LOWER(p.nomCourt) LIKE :term OR " +
                "LOWER(p.utilisateur.nom) LIKE :term " +
                "ORDER BY p.nom ASC", 
                Projet.class)
            .setParameter("term", searchTerm)
            .getResultList();
    }
}
