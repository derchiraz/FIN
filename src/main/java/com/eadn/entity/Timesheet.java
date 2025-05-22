package com.eadn.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "timesheets")
public class Timesheet implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "projet_id")
    private Projet projet;
    
    @ManyToOne
    @JoinColumn(name = "utilisateur_id")
    private Utilisateur utilisateur;
    
    private String role;
    
    @Temporal(TemporalType.DATE)
    private Date dateDebut;  // Date du début de la semaine
    
    private Integer lundi;    // Minutes travaillées
    private Integer mardi;    // Minutes travaillées
    private Integer mercredi; // Minutes travaillées
    private Integer jeudi;    // Minutes travaillées
    private Integer vendredi; // Minutes travaillées
    private Integer samedi;   // Minutes travaillées
    private Integer dimanche; // Minutes travaillées
    
    private Integer totalHeures; // Total des heures pour la semaine
    
    private String statut;    // "Brouillon", "Soumis", "Approuvé", "Rejeté"
    
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateCreation;
    
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateMiseAJour;
    
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateSoumission;
    
    @PrePersist
    protected void onCreate() {
        dateCreation = new Date();
        dateMiseAJour = new Date();
    }
    
    @PreUpdate
    protected void onUpdate() {
        dateMiseAJour = new Date();
    }
    
    // Constructeur par défaut
    public Timesheet() {
        this.lundi = 0;
        this.mardi = 0;
        this.mercredi = 0;
        this.jeudi = 0;
        this.vendredi = 0;
        this.samedi = 0;
        this.dimanche = 0;
        this.totalHeures = 0;
        this.statut = "Brouillon";
    }
    
    // Méthode pour calculer le total des heures
    public void calculerTotal() {
        this.totalHeures = (this.lundi + this.mardi + this.mercredi + this.jeudi + 
                          this.vendredi + this.samedi + this.dimanche);
    }
    
    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Projet getProjet() {
        return projet;
    }

    public void setProjet(Projet projet) {
        this.projet = projet;
    }

    public Utilisateur getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur(Utilisateur utilisateur) {
        this.utilisateur = utilisateur;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Date getDateDebut() {
        return dateDebut;
    }

    public void setDateDebut(Date dateDebut) {
        this.dateDebut = dateDebut;
    }

    public Integer getLundi() {
        return lundi;
    }

    public void setLundi(Integer lundi) {
        this.lundi = lundi;
    }

    public Integer getMardi() {
        return mardi;
    }

    public void setMardi(Integer mardi) {
        this.mardi = mardi;
    }

    public Integer getMercredi() {
        return mercredi;
    }

    public void setMercredi(Integer mercredi) {
        this.mercredi = mercredi;
    }

    public Integer getJeudi() {
        return jeudi;
    }

    public void setJeudi(Integer jeudi) {
        this.jeudi = jeudi;
    }

    public Integer getVendredi() {
        return vendredi;
    }

    public void setVendredi(Integer vendredi) {
        this.vendredi = vendredi;
    }

    public Integer getSamedi() {
        return samedi;
    }

    public void setSamedi(Integer samedi) {
        this.samedi = samedi;
    }

    public Integer getDimanche() {
        return dimanche;
    }

    public void setDimanche(Integer dimanche) {
        this.dimanche = dimanche;
    }

    public Integer getTotalHeures() {
        return totalHeures;
    }

    public void setTotalHeures(Integer totalHeures) {
        this.totalHeures = totalHeures;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }

    public Date getDateCreation() {
        return dateCreation;
    }

    public Date getDateMiseAJour() {
        return dateMiseAJour;
    }

    public Date getDateSoumission() {
        return dateSoumission;
    }

    public void setDateSoumission(Date dateSoumission) {
        this.dateSoumission = dateSoumission;
    }
    
    // Méthode pour convertir hh:mm en minutes
    public static int convertirHeureEnMinutes(String heureMinute) {
        if (heureMinute == null || heureMinute.isEmpty()) {
            return 0;
        }
        
        String[] parts = heureMinute.split(":");
        if (parts.length != 2) {
            return 0;
        }
        
        try {
            int heures = Integer.parseInt(parts[0]);
            int minutes = Integer.parseInt(parts[1]);
            return heures * 60 + minutes;
        } catch (NumberFormatException e) {
            return 0;
        }
    }
    
    // Méthode pour convertir minutes en format hh:mm
    public static String convertirMinutesEnHeure(int minutes) {
        int heures = minutes / 60;
        int mins = minutes % 60;
        return String.format("%02d:%02d", heures, mins);
    }
}