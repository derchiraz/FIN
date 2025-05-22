package com.eadn.controller;

import com.eadn.entity.Projet;
import com.eadn.service.ProjetService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/projet/update")
public class UpdateProjetServlet extends HttpServlet {

    @Inject
    private ProjetService projetService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            Long id = Long.parseLong(req.getParameter("id"));
            Projet projet = projetService.findById(id);

            if (projet != null) {
                
                projet.setNom(req.getParameter("nom"));
                projet.setNomCourt(req.getParameter("nomCourt"));
                projet.setDescription(req.getParameter("description"));
                
                projet.setResponsable(req.getParameter("responsable"));
                
                // Mise à jour du statut (vérifiez le nom exact du champ)
                projet.setStatus(req.getParameter("status"));
                
               
               
                
                // Budget
                String budgetStr = req.getParameter("budget");
                if (budgetStr != null && !budgetStr.isEmpty()) {
                    projet.setBudget(Double.parseDouble(budgetStr));
                }
                
                // Dates - utiliser SimpleDateFormat pour la conversion
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                
                String dateDebutStr = req.getParameter("dateDebut");
                if (dateDebutStr != null && !dateDebutStr.isEmpty()) {
                    projet.setDateDebut(sdf.parse(dateDebutStr));
                }
                
                String dateFinStr = req.getParameter("dateFin");
                if (dateFinStr != null && !dateFinStr.isEmpty()) {
                    projet.setDateFin(sdf.parse(dateFinStr));
                    
                    // Recalculer la durée en jours si nécessaire
                    if (projet.getDateDebut() != null && projet.getDateFin() != null) {
                        long diff = projet.getDateFin().getTime() - projet.getDateDebut().getTime();
                        projet.setDureeEnJours((int) (diff / (1000 * 60 * 60 * 24)));
                    }
                }
                // 🎯 Progression (0 à 100)
                String progressionStr = req.getParameter("progression");
                if (progressionStr != null && !progressionStr.isEmpty()) {
                    int progression = Integer.parseInt(progressionStr);
                    if (progression < 0) progression = 0;
                    if (progression > 100) progression = 100;
                    projet.setProgression(progression);
                }

                // Mise à jour
                projetService.update(projet);
                
                // Message de succès
                HttpSession session = req.getSession();
                session.setAttribute("successMessage", "Projet mis à jour avec succès !");
            } else {
                // Message d'erreur si le projet n'existe pas
                HttpSession session = req.getSession();
                session.setAttribute("errorMessage", "Projet introuvable, impossible de mettre à jour.");
            }

            // Redirection après mise à jour
            resp.sendRedirect(req.getContextPath() + "/projet/liste");

        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = req.getSession();
            session.setAttribute("errorMessage", "Erreur lors de la mise à jour du projet: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/projet/liste");
        }
    }
}