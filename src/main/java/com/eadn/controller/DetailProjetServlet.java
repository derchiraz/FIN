
package com.eadn.controller;

import com.eadn.entity.Projet;
import com.eadn.entity.Utilisateur;
import com.eadn.service.ProjetService;
import com.eadn.service.UtilisateurService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/projet/details/*")
public class DetailProjetServlet extends HttpServlet {
    
    private static final Logger logger = Logger.getLogger(DetailProjetServlet.class.getName());
    
    @Inject
    private ProjetService projetService;
    
    @Inject
    private UtilisateurService utilisateurService;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Extraction de l'ID du projet à partir de l'URL
            String pathInfo = request.getPathInfo();
            if (pathInfo == null || pathInfo.equals("/")) {
                response.sendRedirect(request.getContextPath() + "/projet/liste");
                return;
            }
            
            String[] splits = pathInfo.split("/");
            if (splits.length < 2) {
                response.sendRedirect(request.getContextPath() + "/projet/liste");
                return;
            }
            
            String idStr = splits[1];
            Long id = Long.parseLong(idStr);
            
            // Récupération du projet
            Projet projet = projetService.findById(id);
            
            
            if (projet == null) {
                // Si le projet n'existe pas, rediriger vers la liste
                logger.log(Level.WARNING, "Projet avec ID {0} non trouvé", id);
                request.setAttribute("errorMessage", "Projet non trouvé");
                request.getRequestDispatcher("/projet/liste").forward(request, response);
                return;
            }
            
             if (utilisateurService == null) {
                System.err.println("ERREUR CRITIQUE: UtilisateurService n'est pas injecté !");
                request.setAttribute("errorMessage", "Service utilisateur non disponible. Contactez l'administrateur.");
                request.getRequestDispatcher("/views/error.jsp").forward(request, response);
                return;
            }
             
              List<Utilisateur> utilisateurs = utilisateurService.findAll();
            System.out.println("Nombre d'utilisateurs récupérés: " + utilisateurs.size());
            
            
            // Placement du projet dans l'attribut de requête
            request.setAttribute("projet", projet);
            request.setAttribute("utilisateurs", utilisateurs);
            
            request.setAttribute("membresProjets", projet.getMembres());
            
            if (projet.getMembres() == null) {
    System.out.println("Membres du projet est NULL");
} else {
    System.out.println("Nombre de membres : " + projet.getMembres().size());
    for (Utilisateur u : projet.getMembres()) {
        System.out.println("- " + u.getNom() + " " + u.getPrenom());
    }
}

            
            // Redirection vers la page JSP de détails
            request.getRequestDispatcher("/views/detailProjet.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            logger.log(Level.SEVERE, "Format d'ID invalide: {0}", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/projet/liste");
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Erreur lors de la récupération des détails du projet: {0}", e.getMessage());
            request.setAttribute("errorMessage", "Une erreur est survenue: " + e.getMessage());
            request.getRequestDispatcher("/projet/liste").forward(request, response);
        }
    }
}
