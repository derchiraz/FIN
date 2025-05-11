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

@WebServlet("/projet/valider")
public class ValiderProjetServlet extends HttpServlet {

    @Inject
    private ProjetService projetService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Long id = Long.parseLong(req.getParameter("id"));
            Projet projet = projetService.findById(id);

            if (projet != null) {
                projet.setStatus("validated");  // Correction: setStatut au lieu de setStatus
                projetService.update(projet);
                
                // Ajouter un message de succès
                HttpSession session = req.getSession();
                session.setAttribute("successMessage", "Le projet a été validé avec succès.");
            } else {
                // Ajouter un message d'erreur
                HttpSession session = req.getSession();
                session.setAttribute("errorMessage", "Projet introuvable, impossible de valider.");
            }

            // Rediriger vers la liste des projets avec le servlet
            resp.sendRedirect(req.getContextPath() + "/projet/liste");
            
        } catch (NumberFormatException e) {
            // Gérer l'erreur si l'ID n'est pas un nombre valide
            HttpSession session = req.getSession();
            session.setAttribute("errorMessage", "ID de projet invalide.");
            resp.sendRedirect(req.getContextPath() + "/projet/liste");
        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = req.getSession();
            session.setAttribute("errorMessage", "Erreur lors de la validation du projet: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/projet/liste");
        }
    }
}