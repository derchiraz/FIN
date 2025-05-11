package com.eadn.service;

import com.eadn.entity.Utilisateur;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import org.mindrot.jbcrypt.BCrypt;
import java.util.List;



@Stateless
public class UtilisateurService {

    @PersistenceContext
    private EntityManager em;

    // Enregistrer un nouvel utilisateur
    public void save(Utilisateur utilisateur) {
        // Hasher le mot de passe avant de persister si ce n'est pas déjà un hash BCrypt
        if (utilisateur.getPassword() != null && !utilisateur.getPassword().startsWith("$2a$")) {
            utilisateur.setPassword(hashPassword(utilisateur.getPassword()));
        }
        em.persist(utilisateur);
    }

    // Rechercher un utilisateur par ID
    public Utilisateur findById(Long id) {
        return em.find(Utilisateur.class, id);
    }

    // Mettre à jour un utilisateur existant
    public void update(Utilisateur utilisateur) {
        try {
            // Si c'est un update avec un nouveau mot de passe non hashé
            if (utilisateur.getId() != null) {
                Utilisateur existingUser = findById(utilisateur.getId());
                
                // Si le mot de passe a changé
                if (utilisateur.getPassword() != null && !utilisateur.getPassword().equals(existingUser.getPassword())) {
                    // Vérifier si le mot de passe fourni est déjà un hash BCrypt
                    if (!utilisateur.getPassword().startsWith("$2a$")) {
                        // C'est un mot de passe en clair, le hasher avec BCrypt
                        utilisateur.setPassword(hashPassword(utilisateur.getPassword()));
                    }
                }
            }
            
            System.out.println("Tentative de mise à jour de l'utilisateur ID: " + utilisateur.getId());
            em.merge(utilisateur);
            em.flush();
            System.out.println("Utilisateur mis à jour avec succès");
        } catch (Exception e) {
            System.err.println("Erreur lors de la mise à jour de l'utilisateur: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    // Supprimer un utilisateur
    public void delete(Long id) {
        try {
            Utilisateur utilisateur = findById(id);
            if (utilisateur != null) {
                System.out.println("Tentative de suppression de l'utilisateur ID: " + id);
                em.remove(utilisateur);
                em.flush();
                System.out.println("Utilisateur supprimé avec succès");
            }
        } catch (Exception e) {
            System.err.println("Erreur lors de la suppression de l'utilisateur: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    // Récupérer tous les utilisateurs
    public List<Utilisateur> findAll() {
        try {
            return em.createQuery("SELECT u FROM Utilisateur u ORDER BY u.nom", Utilisateur.class)
                    .getResultList();
        } catch (Exception e) {
            System.err.println("Erreur lors de la récupération de la liste des utilisateurs: " + e.getMessage());
            e.printStackTrace();
            return java.util.Collections.emptyList();
        }
    }
    
    // Trouver un utilisateur par email
    public Utilisateur findByEmail(String email) {
        try {
            TypedQuery<Utilisateur> query = em.createQuery(
                    "SELECT u FROM Utilisateur u WHERE u.email = :email", 
                    Utilisateur.class);
            query.setParameter("email", email);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }
    
    // Vérifier si un email existe déjà
    public boolean emailExists(String email) {
        return findByEmail(email) != null;
    }
    
    // Authentifier un utilisateur
    public Utilisateur authenticate(String email, String password) {
        Utilisateur utilisateur = findByEmail(email);
        
        if (utilisateur != null) {
            // Vérifier si le mot de passe stocké est un hash BCrypt
            if (utilisateur.getPassword() != null && utilisateur.getPassword().startsWith("$2a$")) {
                // C'est un hash BCrypt, utiliser checkpw pour vérifier
                if (BCrypt.checkpw(password, utilisateur.getPassword())) {
                    return utilisateur;
                }
            } else {
                // Pour la compatibilité avec les anciens mots de passe (Base64 de SHA-256)
                if (verifyOldPassword(password, utilisateur.getPassword())) {
                    // Mise à jour automatique vers BCrypt au premier login réussi
                    utilisateur.setPassword(hashPassword(password));
                    em.merge(utilisateur);
                    return utilisateur;
                }
            }
        }
        
        return null; // Authentification échouée
    }
    
    // Hasher un mot de passe avec BCrypt
    public String hashPassword(String password) {
        // Utiliser un facteur de coût de 12 (2^12 itérations)
        String salt = BCrypt.gensalt(12);
        String hashedPassword = BCrypt.hashpw(password, salt);
        
        System.out.println("Mot de passe haché avec BCrypt");
        return hashedPassword;
    }
    
    // Vérifier un mot de passe avec l'ancien système (pour migration)
    private boolean verifyOldPassword(String enteredPassword, String storedPassword) {
        try {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(enteredPassword.getBytes());
            String hashedPassword = java.util.Base64.getEncoder().encodeToString(hash);
            
            return hashedPassword.equals(storedPassword);
        } catch (java.security.NoSuchAlgorithmException e) {
            System.err.println("Erreur de vérification du mot de passe: " + e.getMessage());
            return false;
        }
    }
}