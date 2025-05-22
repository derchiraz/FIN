package com.eadn.controller;

import com.eadn.entity.Opportunite;
import com.eadn.service.OpportuniteService;
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

@WebServlet("/opportunite/update")
public class UpdateOpportuniteServlet extends HttpServlet {

    @Inject
    private OpportuniteService opportuniteService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            Long id = Long.parseLong(req.getParameter("id"));
            Opportunite opportunite = opportuniteService.findById(id);

            if (opportunite != null) {
                
                opportunite.setNom_entreprise(req.getParameter("nom_entreprise"));
                opportunite.setNom_contact(req.getParameter("nom_contact"));
                opportunite.setTelephone(req.getParameter("telephone"));
                opportunite.setEmail(req.getParameter("email"));
                opportunite.setNom_opportunite(req.getParameter("nom_opportunite"));
                opportunite.setDescription_opportunite(req.getParameter("description_opportunite"));
                opportunite.setAdresse(req.getParameter("adresse"));
                opportunite.setStatus(req.getParameter("status"));
                
                opportunite.setObjectifs_principaux(req.getParameter("objectifs_principaux"));
                opportunite.setDescription_architecture(req.getParameter("description_architecture"));
                
                // Gestion des responsables - ne pas utiliser setResponsable qui n'est pas implémenté
                // La méthode setResponsable lance une UnsupportedOperationException
                /*
                String responsableStr = req.getParameter("responsable");
                if (responsableStr != null && !responsableStr.isEmpty()) {
                    // Ne pas appeler setResponsable car non implémenté
                    // opportunite.setResponsable(Long.parseLong(responsableStr));
                }
                */
                
                // Gestion des membres
                String membre1Str = req.getParameter("membre1");
                if (membre1Str != null && !membre1Str.isEmpty()) {
                    opportunite.setMembre1_id(Long.parseLong(membre1Str));
                }
                
                String membre2Str = req.getParameter("membre2");
                if (membre2Str != null && !membre2Str.isEmpty()) {
                    opportunite.setMembre2_id(Long.parseLong(membre2Str));
                }
                
                String membre3Str = req.getParameter("membre3");
                if (membre3Str != null && !membre3Str.isEmpty()) {
                    opportunite.setMembre3_id(Long.parseLong(membre3Str));
                }
                
                // Budget
                String budgetEstimeStr = req.getParameter("budget_estime");
                if (budgetEstimeStr != null && !budgetEstimeStr.isEmpty()) {
                    opportunite.setBudget_estime(Double.parseDouble(budgetEstimeStr));
                }
                
                // Dates - utiliser SimpleDateFormat pour la conversion
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                
                String dateDebutStr = req.getParameter("dateDebut");
                if (dateDebutStr != null && !dateDebutStr.isEmpty()) {
                    opportunite.setDateDebut(sdf.parse(dateDebutStr));
                }
                
                String dateFinStr = req.getParameter("dateFin");
                if (dateFinStr != null && !dateFinStr.isEmpty()) {
                    opportunite.setDateFin(sdf.parse(dateFinStr));
                    
                    
                }

                // Mise à jour
                opportuniteService.update(opportunite);
                
                // Message de succès
                HttpSession session = req.getSession();
                session.setAttribute("successMessage", "Opportunité mise à jour avec succès !");
            } else {
                // Message d'erreur si l'opportunité n'existe pas
                HttpSession session = req.getSession();
                session.setAttribute("errorMessage", "Opportunité introuvable, impossible de mettre à jour.");
            }

            // Redirection après mise à jour
            resp.sendRedirect(req.getContextPath() + "/opportunite/liste");

        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = req.getSession();
            session.setAttribute("errorMessage", "Erreur lors de la mise à jour de l'opportunité: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/opportunite/liste");
        }
    }
}