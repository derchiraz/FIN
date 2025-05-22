package com.eadn.controller;

import com.eadn.entity.Projet;
import com.eadn.entity.Utilisateur;
import com.eadn.service.ProjetService;
import com.eadn.service.UtilisateurService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@WebServlet("/projet/save")
public class ProjetServlet extends HttpServlet {

    @Inject
    private ProjetService service;
    
    @Inject
    private UtilisateurService utilisateurService;
    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Créer un nouvel objet Projet
            Projet p = new Projet();
            
            // Informations de base
            p.setNom(request.getParameter("nom"));
            p.setNomCourt(request.getParameter("nomCourt"));
            p.setDescription(request.getParameter("description"));
            
            p.setResponsable(request.getParameter("responsable"));
            p.setStatus(request.getParameter("status")); // Important: utiliser statut et non status
            
            if (utilisateurService == null) {
                System.err.println("ERREUR CRITIQUE: UtilisateurService n'est pas injecté !");
                response.sendRedirect(request.getContextPath() + "/projet/liste?erreur=service_non_disponible");
                return;
            }
          
            // Valeurs numériques
            String budgetStr = request.getParameter("budget");
            if (budgetStr != null && !budgetStr.isEmpty()) {
                p.setBudget(Double.parseDouble(budgetStr));
            }
            
            // Dates
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String dateDebutStr = request.getParameter("dateDebut");
            if (dateDebutStr != null && !dateDebutStr.isEmpty()) {
                p.setDateDebut(sdf.parse(dateDebutStr));
            }
            
            String dateFinStr = request.getParameter("dateFin");
            if (dateFinStr != null && !dateFinStr.isEmpty()) {
                p.setDateFin(sdf.parse(dateFinStr));
                
                // Calculer la durée en jours
                if (p.getDateDebut() != null && p.getDateFin() != null) {
                    long diff = p.getDateFin().getTime() - p.getDateDebut().getTime();
                    p.setDureeEnJours((int) (diff / (1000 * 60 * 60 * 24)));
                }
            }
            // Récupération de la progression
              String progressionStr = request.getParameter("progression");
if (progressionStr != null && !progressionStr.isEmpty()) {
    p.setProgression(Integer.parseInt(progressionStr));
}

            // Charger la liste des utilisateurs pour le choix du responsable
            List<Utilisateur> utilisateurs = utilisateurService.findAll();
            request.setAttribute("utilisateurs", utilisateurs);
            
              String[] membresIds = request.getParameterValues("membresIds");
Set<Utilisateur> membres = new HashSet<>();

if (membresIds != null) {
    for (String idStr : membresIds) {
        Long userId = Long.parseLong(idStr);
        Utilisateur u = utilisateurService.findById(userId);
        membres.add(u);
    }
}
    p.setMembres(membres);

           
            
            // Sauvegarde avec logs détaillés
            System.out.println("Sauvegarde du projet: " + p.getNom());
            service.save(p);
            System.out.println("Projet sauvegardé avec ID: " + p.getId());
            
            // Message de succès et redirection
            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "Projet enregistré avec succès !");
            response.sendRedirect(request.getContextPath() + "/projet/liste");

        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Erreur lors de l'enregistrement du projet: " + e.getMessage());
            request.setAttribute("errorMessage", "Erreur lors de l'enregistrement du projet: " + e.getMessage());
            request.getRequestDispatcher("/views/projet.jsp").forward(request, response);
        }
    }
}