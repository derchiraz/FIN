package com.eadn.service;

import com.eadn.entity.Coordonnee;
import com.eadn.entity.Utilisateur;
import jakarta.ejb.Stateless;
import jakarta.persistence.*;

import java.util.List;

@Stateless
public class CoordonneeService {

    @PersistenceContext
    private EntityManager em;
    
    public void save(Coordonnee c) {
        em.persist(c);
    }
    
    public Coordonnee findById(Long id) {
        return em.find(Coordonnee.class, id);
    }
    
    public void update(Coordonnee c) {
        em.merge(c);
    }
    
    public void delete(Long id) {
        Coordonnee c = em.find(Coordonnee.class, id);
        if (c != null) {
            em.remove(c);
        }
    }
    
    public List<Coordonnee> findAll() {
        return em.createQuery("SELECT c FROM Coordonnee c", Coordonnee.class)
                 .getResultList();
    }
    
    public Coordonnee findByUtilisateur(Utilisateur utilisateur) {
        try {
            return em.createQuery(
                    "SELECT c FROM Coordonnee c WHERE c.utilisateur = :utilisateur", Coordonnee.class)
                    .setParameter("utilisateur", utilisateur)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }
    
    public Coordonnee findByUtilisateurId(Long id) {
        try {
            return em.createQuery(
                    "SELECT c FROM Coordonnee c WHERE c.utilisateur.id = :id", Coordonnee.class)
                    .setParameter("id", id)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    public Coordonnee findByRessourceId(Long id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}