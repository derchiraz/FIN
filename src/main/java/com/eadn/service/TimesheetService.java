package com.eadn.service;

import com.eadn.entity.Timesheet;
import jakarta.ejb.Stateless;
import jakarta.persistence.*;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Stateless
public class TimesheetService {

    @PersistenceContext
    private EntityManager em;
    
    /**
     * Récupère tous les timesheets de la base de données
     */
    public List<Timesheet> findAll() {
        try {
            return em.createQuery("SELECT t FROM Timesheet t ORDER BY t.dateDebut DESC", Timesheet.class)
                    .getResultList();
        } catch (Exception e) {
            System.err.println("Erreur lors de la récupération des timesheets: " + e.getMessage());
            e.printStackTrace();
            return java.util.Collections.emptyList();
        }
    }
    
    /**
     * Trouve un timesheet par son ID
     */
    public Timesheet findById(Long id) {
        try {
            return em.find(Timesheet.class, id);
        } catch (Exception e) {
            System.err.println("Erreur lors de la recherche du timesheet par ID: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * Trouve les timesheets d'un utilisateur
     */
    public List<Timesheet> findByUtilisateur(Long utilisateurId) {
        try {
            return em.createQuery(
                    "SELECT t FROM Timesheet t WHERE t.utilisateur.id = :utilisateurId ORDER BY t.dateDebut DESC", 
                    Timesheet.class)
                    .setParameter("utilisateurId", utilisateurId)
                    .getResultList();
        } catch (Exception e) {
            System.err.println("Erreur lors de la recherche des timesheets par utilisateur: " + e.getMessage());
            e.printStackTrace();
            return java.util.Collections.emptyList();
        }
    }
    
    /**
     * Trouve les timesheets d'un utilisateur pour une semaine spécifique
     */
    public List<Timesheet> findByUtilisateurAndWeek(Long utilisateurId, Date dateDebut) {
        try {
            return em.createQuery(
                    "SELECT t FROM Timesheet t " +
                    "WHERE t.utilisateur.id = :utilisateurId " +
                    "AND t.dateDebut = :dateDebut " +
                    "ORDER BY t.projet.nom", 
                    Timesheet.class)
                    .setParameter("utilisateurId", utilisateurId)
                    .setParameter("dateDebut", dateDebut)
                    .getResultList();
        } catch (Exception e) {
            System.err.println("Erreur lors de la recherche des timesheets par utilisateur et semaine: " + e.getMessage());
            e.printStackTrace();
            return java.util.Collections.emptyList();
        }
    }
    
    /**
     * Trouve les timesheets d'un projet
     */
    public List<Timesheet> findByProjet(Long projetId) {
        try {
            return em.createQuery(
                    "SELECT t FROM Timesheet t WHERE t.projet.id = :projetId ORDER BY t.dateDebut DESC", 
                    Timesheet.class)
                    .setParameter("projetId", projetId)
                    .getResultList();
        } catch (Exception e) {
            System.err.println("Erreur lors de la recherche des timesheets par projet: " + e.getMessage());
            e.printStackTrace();
            return java.util.Collections.emptyList();
        }
    }
    
    /**
     * Enregistre un nouveau timesheet
     */
    public void save(Timesheet timesheet) {
        try {
            // Calculer le total avant de sauvegarder
            timesheet.calculerTotal();
            
            // Déterminer s'il s'agit d'une création ou d'une mise à jour
            if (timesheet.getId() == null) {
                em.persist(timesheet);
            } else {
                em.merge(timesheet);
            }
        } catch (Exception e) {
            System.err.println("Erreur lors de l'enregistrement du timesheet: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }
    
    /**
     * Supprime un timesheet par son ID
     */
    public boolean delete(Long id) {
        try {
            Timesheet timesheet = findById(id);
            if (timesheet != null) {
                em.remove(timesheet);
                return true;
            }
            return false;
        } catch (Exception e) {
            System.err.println("Erreur lors de la suppression du timesheet " + id + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Soumet un timesheet (change son statut à "Soumis")
     */
    public void soumettreTimesheet(Long id) {
        try {
            Timesheet timesheet = findById(id);
            if (timesheet != null && "Brouillon".equals(timesheet.getStatut())) {
                timesheet.setStatut("Soumis");
                timesheet.setDateSoumission(new Date());
                em.merge(timesheet);
            }
        } catch (Exception e) {
            System.err.println("Erreur lors de la soumission du timesheet: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }
    
    /**
     * Soumet tous les timesheets d'un utilisateur pour une semaine spécifique
     */
    public void soumettreTimesheetsSemaine(Long utilisateurId, Date dateDebut) {
        try {
            List<Timesheet> timesheets = findByUtilisateurAndWeek(utilisateurId, dateDebut);
            
            for (Timesheet timesheet : timesheets) {
                if ("Brouillon".equals(timesheet.getStatut())) {
                    timesheet.setStatut("Soumis");
                    timesheet.setDateSoumission(new Date());
                    em.merge(timesheet);
                }
            }
        } catch (Exception e) {
            System.err.println("Erreur lors de la soumission des timesheets: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }
    
    /**
     * Récupère les timesheets par statut
     */
    public List<Timesheet> findByStatut(String statut) {
        try {
            return em.createQuery(
                    "SELECT t FROM Timesheet t WHERE t.statut = :statut ORDER BY t.dateDebut DESC",
                    Timesheet.class)
                    .setParameter("statut", statut)
                    .getResultList();
        } catch (Exception e) {
            System.err.println("Erreur lors de la recherche des timesheets par statut: " + e.getMessage());
            e.printStackTrace();
            return java.util.Collections.emptyList();
        }
    }
    
    /**
     * Récupère les timesheets en attente d'approbation
     */
    public List<Timesheet> findEnAttente() {
        try {
            return em.createQuery(
                    "SELECT t FROM Timesheet t WHERE t.statut = 'Soumis' ORDER BY t.dateSoumission ASC",
                    Timesheet.class)
                    .getResultList();
        } catch (Exception e) {
            System.err.println("Erreur lors de la recherche des timesheets en attente: " + e.getMessage());
            e.printStackTrace();
            return java.util.Collections.emptyList();
        }
    }
    
    /**
     * Approuve un timesheet (change son statut à "Approuvé")
     */
    public void approuverTimesheet(Long id) {
        try {
            Timesheet timesheet = findById(id);
            if (timesheet != null && "Soumis".equals(timesheet.getStatut())) {
                timesheet.setStatut("Approuvé");
                em.merge(timesheet);
            }
        } catch (Exception e) {
            System.err.println("Erreur lors de l'approbation du timesheet: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }
    
    /**
     * Rejette un timesheet (change son statut à "Rejeté")
     */
    public void rejeterTimesheet(Long id) {
        try {
            Timesheet timesheet = findById(id);
            if (timesheet != null && "Soumis".equals(timesheet.getStatut())) {
                timesheet.setStatut("Rejeté");
                em.merge(timesheet);
            }
        } catch (Exception e) {
            System.err.println("Erreur lors du rejet du timesheet: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }
    
    /**
     * Méthode utilitaire pour obtenir le premier jour de la semaine courante (lundi)
     */
    public Date getFirstDayOfCurrentWeek() {
        Calendar cal = Calendar.getInstance();
        int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
        int diff = cal.get(Calendar.DATE) - dayOfWeek + (dayOfWeek == Calendar.SUNDAY ? -6 : 2);
        cal.add(Calendar.DATE, diff);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        return cal.getTime();
    }

    public List<Timesheet> findByUtilisateurAndPeriod(Long id, Date dateDebut, Date dateFin) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}