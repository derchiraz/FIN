package com.eadn.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "password_resets")
public class PasswordReset implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "email", nullable = false)
    private String email;
    
    @Column(name = "token", nullable = false, unique = true)
    private String token;
    
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "expiry_date", nullable = false)
    private Date expiryDate;
    
    @Column(name = "used", nullable = false)
    private boolean used = false;
    
    @PrePersist
    protected void onCreate() {
        // Par défaut, le token expire après 24 heures
        if (expiryDate == null) {
            expiryDate = new Date(System.currentTimeMillis() + 24 * 60 * 60 * 1000);
        }
    }
    
    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public boolean isUsed() {
        return used;
    }

    public void setUsed(boolean used) {
        this.used = used;
    }
    
    public boolean isExpired() {
        return new Date().after(expiryDate);
    }
}