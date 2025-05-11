package com.eadn.controller;

import com.eadn.service.OpportuniteService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/opportunite/delete")
public class SupprimerOpportuniteServlet extends HttpServlet {

    @EJB
    private OpportuniteService service;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Rediriger vers la liste car GET n'est pas supporté pour la suppression
        response.sendRedirect(request.getContextPath() + "/opportunite/liste");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idStr = request.getParameter("id");
            
            if (idStr == null || idStr.isEmpty()) {
                request.getSession().setAttribute("errorMessage", "ID d'opportunité non spécifié");
                response.sendRedirect(request.getContextPath() + "/opportunite/liste");
                return;
            }
            
            Long id = Long.parseLong(idStr);
            System.out.println("Traitement de la suppression pour l'opportunité ID: " + id);
            
            // Vérifier si le service est bien injecté
            if (service == null) {
                System.err.println("ERREUR CRITIQUE: Service est null");
                request.getSession().setAttribute("errorMessage", "Erreur serveur: Service non disponible");
                response.sendRedirect(request.getContextPath() + "/opportunite/liste");
                return;
            }
            
            // Tentative de suppression avec try-catch dédié
            try {
                boolean success = service.delete(id);
                System.out.println("Résultat de la suppression: " + (success ? "réussite" : "échec"));
                
                if (success) {
                    request.getSession().setAttribute("successMessage", "Opportunité supprimée avec succès !");
                } else {
                    request.getSession().setAttribute("errorMessage", "Échec de la suppression de l'opportunité");
                }
            } catch (Exception e) {
                System.err.println("Exception pendant la suppression: " + e.getMessage());
                e.printStackTrace();
                request.getSession().setAttribute("errorMessage", "Erreur pendant la suppression: " + e.getMessage());
            }
            
            response.sendRedirect(request.getContextPath() + "/opportunite/liste");
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Format d'ID invalide");
            response.sendRedirect(request.getContextPath() + "/opportunite/liste");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Une erreur est survenue: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/opportunite/liste");
        }
    }
}