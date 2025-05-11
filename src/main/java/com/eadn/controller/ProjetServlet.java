package com.eadn.controller;

import com.eadn.entity.Projet;
import com.eadn.service.ProjetService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/projet/save")
public class ProjetServlet extends HttpServlet {

    @Inject
    private ProjetService service;

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
            
            //p.setResponsable(request.getParameter("responsable"));
            p.setStatus(request.getParameter("status")); // Important: utiliser statut et non status
            
           
            
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