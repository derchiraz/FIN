package com.eadn.service;

import com.eadn.entity.PasswordReset;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import java.util.Date;
import java.util.UUID;

@Stateless
public class PasswordResetService {
    
    @PersistenceContext
    private EntityManager em;
    
    /**
     * Créer un nouveau token de réinitialisation pour l'email spécifié
     */
    public PasswordReset createResetToken(String email) {
        // Invalider tous les tokens précédents pour cet email
        invalidateExistingTokens(email);
        
        // Créer un nouveau token
        PasswordReset reset = new PasswordReset();
        reset.setEmail(email);
        reset.setToken(generateToken());
        reset.setExpiryDate(new Date(System.currentTimeMillis() + 24 * 60 * 60 * 1000)); // expire après 24h
        
        em.persist(reset);
        
        return reset;
    }
    
    /**
     * Trouver un token de réinitialisation par sa valeur
     */
    public PasswordReset findByToken(String token) {
        try {
            TypedQuery<PasswordReset> query = em.createQuery(
                    "SELECT r FROM PasswordReset r WHERE r.token = :token AND r.used = false", 
                    PasswordReset.class);
            query.setParameter("token", token);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }
    
    /**
     * Vérifier si un token est valide (existe, non expiré, non utilisé)
     */
    public boolean isTokenValid(String token) {
        PasswordReset reset = findByToken(token);
        
        if (reset == null) {
            return false;
        }
        
        // Vérifier si le token est expiré
        if (reset.isExpired()) {
            return false;
        }
        
        return true;
    }
    
    /**
     * Marquer un token comme utilisé
     */
    public void useToken(String token) {
        PasswordReset reset = findByToken(token);
        
        if (reset != null) {
            reset.setUsed(true);
            em.merge(reset);
        }
    }
    
    /**
     * Invalider tous les tokens existants pour un email
     */
    private void invalidateExistingTokens(String email) {
        em.createQuery("UPDATE PasswordReset r SET r.used = true WHERE r.email = :email")
                .setParameter("email", email)
                .executeUpdate();
    }
    
    /**
     * Générer un token unique
     */
    private String generateToken() {
        return UUID.randomUUID().toString();
    }
}