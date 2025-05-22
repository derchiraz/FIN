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

@WebServlet("/projet/edit")
public class EditProjetServlet extends HttpServlet {
    
    @Inject
    private ProjetService projetService;
    
    @Inject
    private UtilisateurService utilisateurService;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("EditProjetServlet appelé ! Heure: " + new java.util.Date());
        
        try {
            // Récupérer l'ID du projet à éditer
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isEmpty()) {
                System.err.println("Aucun ID spécifié pour l'édition");
                response.sendRedirect(request.getContextPath() + "/projet/liste?erreur=id_manquant");
                return;
            }
            
            // Vérifier que les services sont injectés
            if (projetService == null) {
                System.err.println("ERREUR CRITIQUE: ProjetService n'est pas injecté !");
                response.sendRedirect(request.getContextPath() + "/projet/liste?erreur=service_non_disponible");
                return;
            }
            
            if (utilisateurService == null) {
                System.err.println("ERREUR CRITIQUE: UtilisateurService n'est pas injecté !");
                response.sendRedirect(request.getContextPath() + "/projet/liste?erreur=service_non_disponible");
                return;
            }
            
            Long id = Long.parseLong(idStr);
            System.out.println("Récupération du projet avec ID: " + id);
            
            
            // Charger le projet
            Projet projet = projetService.findById(id);
            if (projet == null) {
                System.err.println("Projet avec ID " + id + " non trouvé");
                response.sendRedirect(request.getContextPath() + "/projet/liste?erreur=projet_non_trouve");
                return;
            }
            
            // Charger la liste des utilisateurs pour le choix du responsable
            List<Utilisateur> utilisateurs = utilisateurService.findAll();
            
            // Passer les données à la JSP
            request.setAttribute("projet", projet);
            request.setAttribute("utilisateurs", utilisateurs);
            
            System.out.println("Affichage du formulaire d'édition pour le projet: " + projet.getNom());
            request.getRequestDispatcher("/views/editProjet.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            System.err.println("ID du projet invalide: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/projet/liste?erreur=id_invalide");
        } catch (Exception e) {
            System.err.println("Erreur lors du chargement du projet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/projet/liste?erreur=exception&message=" + e.getMessage());
        }
    }
}