package com.eadn.service;

import com.eadn.entity.Ressource;
import jakarta.ejb.Stateless;
import jakarta.persistence.*;
import java.util.List;
import java.util.Date;

@Stateless
public class RessourceService {

    @PersistenceContext
    private EntityManager em;
    
    /**
     * Récupère toutes les ressources de la base de données
     */
    public List<Ressource> findAll() {
        try {
            return em.createQuery("SELECT r FROM Ressource r ORDER BY r.nom", Ressource.class)
                    .getResultList();
        } catch (Exception e) {
            System.err.println("Erreur lors de la récupération des ressources: " + e.getMessage());
            e.printStackTrace();
            return java.util.Collections.emptyList();
        }
    }
    
    /**
     * Enregistre une nouvelle ressource
     */
    public void save(Ressource r) {
        try {
            em.persist(r);
        } catch (Exception e) {
            System.err.println("Erreur lors de l'enregistrement de la ressource: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    /**
     * Trouve une ressource par son ID
     */
    public Ressource findById(Long id) {
        try {
            return em.find(Ressource.class, id);
        } catch (Exception e) {
            System.err.println("Erreur lors de la recherche de la ressource par ID: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Met à jour une ressource existante
     */
    public void update(Ressource r) {
        try {
            em.merge(r);
        } catch (Exception e) {
            System.err.println("Erreur lors de la mise à jour de la ressource: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    /**
     * Supprime une ressource par son ID
     */
    public boolean delete(Long id) {
        try {
            Ressource r = findById(id);
            if (r != null) {
                em.remove(r);
                return true;
            }
            return false;
        } catch (Exception e) {
            System.err.println("Erreur lors de la suppression de la ressource " + id + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Recherche des ressources par branche
     */
    public List<Ressource> findByBranche(String branche) {
        try {
            return em.createQuery("SELECT r FROM Ressource r WHERE r.branche = :branche ORDER BY r.nom", Ressource.class)
                     .setParameter("branche", branche)
                     .getResultList();
        } catch (Exception e) {
            System.err.println("Erreur lors de la recherche par branche: " + e.getMessage());
            e.printStackTrace();
            return java.util.Collections.emptyList();
        }
    }
    
    /**
     * Recherche des ressources par poste
     */
    public List<Ressource> findByPoste(String poste) {
        try {
            return em.createQuery("SELECT r FROM Ressource r WHERE r.poste = :poste ORDER BY r.nom", Ressource.class)
                     .setParameter("poste", poste)
                     .getResultList();
        } catch (Exception e) {
            System.err.println("Erreur lors de la recherche par poste: " + e.getMessage());
            e.printStackTrace();
            return java.util.Collections.emptyList();
        }
    }
    
    /**
     * Recherche des ressources par terme (nom, code, qualification, etc.)
     */
    public List<Ressource> search(String term) {
        try {
            String searchTerm = "%" + term.toLowerCase() + "%";
            return em.createQuery(
                    "SELECT r FROM Ressource r WHERE " +
                    "LOWER(r.nom) LIKE :term OR " +
                    "LOWER(r.code) LIKE :term OR " +
                    "LOWER(r.identite) LIKE :term OR " +
                    "LOWER(r.qualification) LIKE :term OR " +
                    "LOWER(r.poste) LIKE :term OR " +
                    "LOWER(r.email) LIKE :term " +
                    "ORDER BY r.nom", 
                    Ressource.class)
                .setParameter("term", searchTerm)
                .getResultList();
        } catch (Exception e) {
            System.err.println("Erreur lors de la recherche par terme: " + e.getMessage());
            e.printStackTrace();
            return java.util.Collections.emptyList();
        }
    }
    
    /**
     * Trouve les ressources disponibles (contrat en cours)
     */
    public List<Ressource> findDisponibles() {
        try {
            Date maintenant = new Date();
            return em.createQuery(
                    "SELECT r FROM Ressource r WHERE " +
                    "(r.dateFin IS NULL OR r.dateFin > :maintenant) " +
                    "ORDER BY r.nom", 
                    Ressource.class)
                .setParameter("maintenant", maintenant)
                .getResultList();
        } catch (Exception e) {
            System.err.println("Erreur lors de la recherche des ressources disponibles: " + e.getMessage());
            e.printStackTrace();
            return java.util.Collections.emptyList();
        }
    }
    
    /**
     * Trouve les ressources indisponibles (contrat terminé)
     */
    public List<Ressource> findIndisponibles() {
        try {
            Date maintenant = new Date();
            return em.createQuery(
                    "SELECT r FROM Ressource r WHERE " +
                    "r.dateFin < :maintenant " +
                    "ORDER BY r.nom", 
                    Ressource.class)
                .setParameter("maintenant", maintenant)
                .getResultList();
        } catch (Exception e) {
            System.err.println("Erreur lors de la recherche des ressources indisponibles: " + e.getMessage());
            e.printStackTrace();
            return java.util.Collections.emptyList();
        }
    }
    
    /**
     * Trouve les ressources partiellement disponibles (contrat se terminant bientôt)
     */
    public List<Ressource> findPartielDisponibles(int joursLimite) {
        try {
            Date maintenant = new Date();
            Date limite = new Date(maintenant.getTime() + (joursLimite * 24L * 60L * 60L * 1000L));
            
            return em.createQuery(
                    "SELECT r FROM Ressource r WHERE " +
                    "r.dateFin > :maintenant AND r.dateFin < :limite " +
                    "ORDER BY r.dateFin ASC", 
                    Ressource.class)
                .setParameter("maintenant", maintenant)
                .setParameter("limite", limite)
                .getResultList();
        } catch (Exception e) {
            System.err.println("Erreur lors de la recherche des ressources partiellement disponibles: " + e.getMessage());
            e.printStackTrace();
            return java.util.Collections.emptyList();
        }
    }
    
    /**
     * Vérifie si une ressource existe déjà avec le même code
     */
    public boolean existsByCode(String code) {
        try {
            long count = em.createQuery("SELECT COUNT(r) FROM Ressource r WHERE r.code = :code", Long.class)
                          .setParameter("code", code)
                          .getSingleResult();
            return count > 0;
        } catch (Exception e) {
            System.err.println("Erreur lors de la vérification du code: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Vérifie si une ressource existe déjà avec le même email
     */
    public boolean existsByEmail(String email) {
        try {
            long count = em.createQuery("SELECT COUNT(r) FROM Ressource r WHERE r.email = :email", Long.class)
                          .setParameter("email", email)
                          .getSingleResult();
            return count > 0;
        } catch (Exception e) {
            System.err.println("Erreur lors de la vérification de l'email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}