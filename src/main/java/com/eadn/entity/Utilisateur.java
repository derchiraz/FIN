package com.eadn.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "utilisateurs")
public class Utilisateur implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "prenom") // Ajout de la propriété prenom
    private String prenom;
    
    @Column(name = "nom", nullable = false)
    private String nom;
    
    @Column(name = "email", unique = true, nullable = false)
    private String email;
    
    @Column(name = "password", nullable = false)
    private String password;
    
    @Column(name = "service")
    private String service;
    
    @Column(name = "statut")
    private String statut;
    
    @Column(name = "titre")
    private String titre;
    
    @Column(name = "phone")
    private String phone;
    
    @Column(name = "disponibilite")
    private String disponibilite;
    
    @Temporal(TemporalType.DATE)
    @Column(name = "date_inscription")
    private Date dateInscription;
    
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "date_creation")
    private Date dateCreation;
    
    @PrePersist
    protected void onCreate() {
        dateCreation = new Date();
    }
    
    // Méthode pour générer les initiales
    @Transient
    public String getInitiales() {
        if (nom == null || nom.isEmpty()) {
            return "?";
        }
        
        String[] parts = nom.split("\\s+");
        StringBuilder initials = new StringBuilder();
        
        for (String part : parts) {
            if (!part.isEmpty()) {
                initials.append(part.charAt(0));
                if (initials.length() >= 2) {
                    break;
                }
            }
        }
        
        return initials.toString().toUpperCase();
    }
    
    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
     public String getPrenom() {
        return prenom;
    }
    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getService() {
        return service;
    }

    public void setService(String service) {
        this.service = service;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getDisponibilite() {
        return disponibilite;
    }

    public void setDisponibilite(String disponibilite) {
        this.disponibilite = disponibilite;
    }

    public Date getDateInscription() {
        return dateInscription;
    }

    public void setDateInscription(Date dateInscription) {
        this.dateInscription = dateInscription;
    }

    public Date getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(Date dateCreation) {
        this.dateCreation = dateCreation;
    }
}