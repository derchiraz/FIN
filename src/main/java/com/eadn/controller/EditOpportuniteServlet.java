package com.eadn.controller;

import com.eadn.entity.Opportunite;
import com.eadn.entity.Utilisateur;
import com.eadn.service.OpportuniteService;
import com.eadn.service.UtilisateurService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/opportunite/edit")
public class EditOpportuniteServlet extends HttpServlet {
    
    @Inject
    private OpportuniteService opportuniteService;
    
    @Inject
    private UtilisateurService utilisateurService;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("EditOpportuniteServlet appelé ! Heure: " + new java.util.Date());
        
        try {
            // Récupérer l'ID de l'opportunité à éditer
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isEmpty()) {
                System.err.println("Aucun ID spécifié pour l'édition");
                response.sendRedirect(request.getContextPath() + "/opportunite/liste?erreur=id_manquant");
                return;
            }
            
            // Vérifier que les services sont injectés
            if (opportuniteService == null) {
                System.err.println("ERREUR CRITIQUE: OpportuniteService n'est pas injecté !");
                response.sendRedirect(request.getContextPath() + "/opportunite/liste?erreur=service_non_disponible");
                return;
            }
            
            if (utilisateurService == null) {
                System.err.println("ERREUR CRITIQUE: UtilisateurService n'est pas injecté !");
                response.sendRedirect(request.getContextPath() + "/opportunite/liste?erreur=service_non_disponible");
                return;
            }
            
            Long id = Long.parseLong(idStr);
            System.out.println("Récupération de l'opportunité avec ID: " + id);
            
            // Charger l'opportunité
            Opportunite opportunite = opportuniteService.findById(id);
            if (opportunite == null) {
                System.err.println("Opportunité avec ID " + id + " non trouvée");
                response.sendRedirect(request.getContextPath() + "/opportunite/liste?erreur=opportunite_non_trouvee");
                return;
            }
            
            // Charger la liste des utilisateurs pour le choix du responsable
            List<Utilisateur> utilisateurs = utilisateurService.findAll();
            
            // Passer les données à la JSP
            request.setAttribute("opportunite", opportunite);
            request.setAttribute("utilisateurs", utilisateurs);
            
            System.out.println("Affichage du formulaire d'édition pour l'opportunité: " + opportunite.getNom_opportunite());
            request.getRequestDispatcher("/views/editOpportunite.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            System.err.println("ID de l'opportunité invalide: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/opportunite/liste?erreur=id_invalide");
        } catch (Exception e) {
            System.err.println("Erreur lors du chargement de l'opportunité: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/opportunite/liste?erreur=exception&message=" + e.getMessage());
        }
    }
}