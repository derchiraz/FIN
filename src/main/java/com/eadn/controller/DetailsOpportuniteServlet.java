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

@WebServlet("/opportunite/details")
public class DetailsOpportuniteServlet extends HttpServlet {
    
    @Inject
    private OpportuniteService opportuniteService;
    
    @Inject
    private UtilisateurService utilisateurService;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("DetailsOpportuniteServlet appelé ! Heure: " + new java.util.Date());
        
        try {
            // Vérifier que le service est injecté
            if (opportuniteService == null) {
                System.err.println("ERREUR CRITIQUE: OpportuniteService n'est pas injecté !");
                request.setAttribute("errorMessage", "Service non disponible. Contactez l'administrateur.");
                request.getRequestDispatcher("/views/error.jsp").forward(request, response);
                return;
            }
            
            if (utilisateurService == null) {
                System.err.println("ERREUR CRITIQUE: UtilisateurService n'est pas injecté !");
                request.setAttribute("errorMessage", "Service utilisateur non disponible. Contactez l'administrateur.");
                request.getRequestDispatcher("/views/error.jsp").forward(request, response);
                return;
            }
            
            // Récupérer l'ID depuis le paramètre de requête
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isEmpty()) {
                System.err.println("Aucun ID spécifié pour les détails");
                response.sendRedirect(request.getContextPath() + "/opportunite/liste");
                return;
            }
            
            Long id = Long.parseLong(idStr);
            System.out.println("Recherche de l'opportunité avec l'ID: " + id);
            
            // Chercher l'opportunité par son ID
            Opportunite opportunite = opportuniteService.findById(id);
            if (opportunite == null) {
                System.err.println("Opportunité avec ID " + id + " non trouvée");
                request.setAttribute("errorMessage", "Opportunité non trouvée.");
                request.getRequestDispatcher("/views/error.jsp").forward(request, response);
                return;
            }
            
            System.out.println("Opportunité trouvée: " + opportunite.getNom_opportunite());
            
            // Récupérer la liste des utilisateurs pour afficher les noms des membres de l'équipe
            List<Utilisateur> utilisateurs = utilisateurService.findAll();
            System.out.println("Nombre d'utilisateurs récupérés: " + utilisateurs.size());
            
            // Placer l'opportunité et les utilisateurs dans les attributs de requête
            request.setAttribute("opportunite", opportunite);
            request.setAttribute("utilisateurs", utilisateurs);
            
            // Rediriger vers la page de détails
            request.getRequestDispatcher("/views/detailsOpportunite.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            System.err.println("ID d'opportunité invalide: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/opportunite/liste");
        } catch (Exception e) {
            System.err.println("Erreur lors de l'affichage des détails: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Une erreur est survenue: " + e.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        
        if ("delete".equals(action)) {
            // Gestion de la suppression d'une opportunité
            String idParam = req.getParameter("id");
            
            if (idParam != null && !idParam.isEmpty()) {
                try {
                    Long id = Long.parseLong(idParam);
                    boolean deleted = opportuniteService.delete(id);
                    
                    resp.setContentType("application/json");
                    resp.setCharacterEncoding("UTF-8");
                    
                    if (deleted) {
                        resp.getWriter().write("{\"success\":true,\"message\":\"Opportunité supprimée avec succès\"}");
                    } else {
                        resp.getWriter().write("{\"success\":false,\"message\":\"Impossible de supprimer l'opportunité\"}");
                    }
                } catch (NumberFormatException e) {
                    resp.getWriter().write("{\"success\":false,\"message\":\"ID d'opportunité invalide\"}");
                }
            } else {
                resp.getWriter().write("{\"success\":false,\"message\":\"ID d'opportunité manquant\"}");
            }
        }
    }
}