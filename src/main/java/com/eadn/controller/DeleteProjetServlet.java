package com.eadn.controller;

import com.eadn.service.ProjetService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/projet/delete")
public class DeleteProjetServlet extends HttpServlet {
    
    @Inject
    private ProjetService projetService;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("DeleteProjetServlet appelé ! Heure: " + new java.util.Date());
        
        try {
            // Vérifier que le service est injecté
            if (projetService == null) {
                System.err.println("ERREUR CRITIQUE: ProjetService n'est pas injecté !");
                response.sendRedirect(request.getContextPath() + "/projet/liste?erreur=service_non_disponible");
                return;
            }
            
            // Récupérer l'ID depuis le formulaire
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isEmpty()) {
                System.err.println("Aucun ID spécifié pour la suppression");
                response.sendRedirect(request.getContextPath() + "/projet/liste?erreur=id_manquant");
                return;
            }
            
            Long id = Long.parseLong(idStr);
            System.out.println("Tentative de suppression du projet avec ID: " + id);
            
            // Effectuer la suppression
            boolean success = projetService.delete(id);
            
            if (success) {
                System.out.println("Projet supprimé avec succès");
                response.sendRedirect(request.getContextPath() + "/projet/liste?message=suppression_reussie");
            } else {
                System.err.println("Échec de la suppression du projet");
                response.sendRedirect(request.getContextPath() + "/projet/liste?erreur=suppression_echouee");
            }
            
        } catch (NumberFormatException e) {
            System.err.println("ID invalide: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/projet/liste?erreur=id_invalide");
        } catch (Exception e) {
            System.err.println("Erreur lors de la suppression: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/projet/liste?erreur=exception&message=" + e.getMessage());
        }
    }
}