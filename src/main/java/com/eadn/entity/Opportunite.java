package com.eadn.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name = "opportunite")
public class Opportunite implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Informations client
    private String nom_entreprise;
    private String nom_contact;
    private String telephone;
    private String email;
    private String adresse;

    // Détails opportunité
    private String nom_opportunite;

    @Column(length = 2000)
    private String description_opportunite;

    private double budget_estime;
    private String status;

    // Planification
    @Temporal(TemporalType.DATE)
    private Date dateDebut;

    @Temporal(TemporalType.DATE)
    private Date dateFin;

    @Column(length = 2000)
    private String objectifs_principaux;

    // Architecture
    @Column(length = 2000)
    private String description_architecture;

    private String nom_fichier;

    // Suivi interne
    private String responsable;
    private String membre1;
    private String membre2;
    private String membre3;
    
    
    
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateCreation;
    
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateModification;

    public Opportunite() {}

    @PrePersist
    protected void onCreate() {
        dateCreation = new Date();
    }
    
    @PreUpdate
    protected void onUpdate() {
        dateModification = new Date();
    }

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNom_entreprise() {
        return nom_entreprise;
    }

    public void setNom_entreprise(String nom_entreprise) {
        this.nom_entreprise = nom_entreprise;
    }

    public String getNom_contact() {
        return nom_contact;
    }

    public void setNom_contact(String nom_contact) {
        this.nom_contact = nom_contact;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public String getNom_opportunite() {
        return nom_opportunite;
    }

    public void setNom_opportunite(String nom_opportunite) {
        this.nom_opportunite = nom_opportunite;
    }

    public String getDescription_opportunite() {
        return description_opportunite;
    }

    public void setDescription_opportunite(String description_opportunite) {
        this.description_opportunite = description_opportunite;
    }
    
    // Pour compatibilité
    public String getDescription() {
        return description_opportunite;
    }

    public void setDescription(String description) {
        this.description_opportunite = description;
    }

    public double getBudget_estime() {
        return budget_estime;
    }

    public void setBudget_estime(double budget_estime) {
        this.budget_estime = budget_estime;
    }
    
    public void setBudget(BigDecimal budget) {
        if (budget != null) {
            this.budget_estime = budget.doubleValue();
        }
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    public void setStatut(String statut) {
        this.status = statut;
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

    public String getObjectifs_principaux() {
        return objectifs_principaux;
    }

    public void setObjectifs_principaux(String objectifs_principaux) {
        this.objectifs_principaux = objectifs_principaux;
    }

    public String getDescription_architecture() {
        return description_architecture;
    }

    public void setDescription_architecture(String description_architecture) {
        this.description_architecture= description_architecture;
    }

    public String getNom_fichier() {
        return nom_fichier;
    }

    public void setNom_fichier(String nom_fichier) {
        this.nom_fichier = nom_fichier;
    }

    public String getResponsable() {
        return responsable;
    }

    public void setResponsable(String responsable) {
        this.responsable = responsable;
    }

    public String getMembre1() {
        return membre1;
    }

    public void setMembre1(String membre1) {
        this.membre1 = membre1;
    }

    public String getMembre2() {
        return membre2;
    }

    public void setMembre2(String membre2) {
        this.membre2 = membre2;
    }

    public String getMembre3() {
        return membre3;
    }

    public void setMembre3(String membre3) {
        this.membre3 = membre3;
    }
    
    
    
    
    public Date getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(Date dateCreation) {
        this.dateCreation = dateCreation;
    }

    public Date getDateModification() {
        return dateModification;
    }

    public void setDateModification(Date dateModification) {
        this.dateModification = dateModification;
    }
    
    // Pour compatibilité
    public void setContact(String contact) {
        this.nom_contact = contact;
    }

    public void setResponsable(Long responsable) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public void setMembre1_id(Long membre1Id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public void setMembre2_id(Long membre2Id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public void setMembre3_id(Long membre3Id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}