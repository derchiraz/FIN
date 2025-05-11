package com.eadn.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "projets")
public class Projet implements Serializable {
    
    @ManyToOne
@JoinColumn(name = "utilisateur_id")
private Utilisateur utilisateur;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nomCourt;
    private String nom;
    private String description;
    
    private String responsable;
    private String status; 
   
    
    // Valeurs numériques
    private Double budget;
    private Integer dureeEnJours;
    
    // Dates
    @Temporal(TemporalType.DATE)
    private Date dateDebut;
    
    @Temporal(TemporalType.DATE)
    private Date dateFin;
    
     
    
    

    public Projet() {}

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNomCourt() {
        return nomCourt;
    }

    public void setNomCourt(String nomCourt) {
        this.nomCourt = nomCourt;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    

    public String getResponsable() {
        return responsable;
    }

    public void setResponsable(String responsable) {
        this.responsable = responsable;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

   

    public Double getBudget() {
        return budget;
    }

    public void setBudget(Double budget) {
        this.budget = budget;
    }

    public Integer getDureeEnJours() {
        return dureeEnJours;
    }

    public void setDureeEnJours(Integer dureeEnJours) {
        this.dureeEnJours = dureeEnJours;
    }

    public Date getDateDebut() {
        return dateDebut;
    }

    public void setDateDebut(Date dateDebut) {
        this.dateDebut = dateDebut;
    }

    public Date getDateFin() {
        return dateFin;
    }

    public void setDateFin(Date dateFin) {
        this.dateFin = dateFin;
    }

    
    public Utilisateur getUtilisateur() {
    return utilisateur;
}
public void setUtilisateur(Utilisateur utilisateur) {
    this.utilisateur = utilisateur;
}

    
}

    