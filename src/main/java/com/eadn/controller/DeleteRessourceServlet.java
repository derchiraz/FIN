package com.eadn.controller;

import com.eadn.service.RessourceService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ressource/delete")
public class DeleteRessourceServlet extends HttpServlet {
    
    @Inject
    private RessourceService ressourceService;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("DeleteRessourceServlet appelé ! Heure: " + new java.util.Date());
        
        try {
            // Vérifier que le service est injecté
            if (ressourceService == null) {
                System.err.println("ERREUR CRITIQUE: RessourceService n'est pas injecté !");
                response.sendRedirect(request.getContextPath() + "/ressource/liste?erreur=service_non_disponible");
                return;
            }
            
            // Récupérer l'ID depuis le formulaire
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isEmpty()) {
                System.err.println("Aucun ID spécifié pour la suppression");
                response.sendRedirect(request.getContextPath() + "/ressource/liste?erreur=id_manquant");
                return;
            }
            
            Long id = Long.parseLong(idStr);
            System.out.println("Tentative de suppression de la ressource avec ID: " + id);
            
            // Effectuer la suppression
            boolean success = ressourceService.delete(id);
            
            if (success) {
                System.out.println("Ressource supprimée avec succès");
                response.sendRedirect(request.getContextPath() + "/ressource/liste?message=suppression_reussie");
            } else {
                System.err.println("Échec de la suppression de la ressource");
                response.sendRedirect(request.getContextPath() + "/ressource/liste?erreur=suppression_echouee");
            }
            
        } catch (NumberFormatException e) {
            System.err.println("ID invalide: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/ressource/liste?erreur=id_invalide");
        } catch (Exception e) {
            System.err.println("Erreur lors de la suppression: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/ressource/liste?erreur=exception&message=" + e.getMessage());
        }
    }
}