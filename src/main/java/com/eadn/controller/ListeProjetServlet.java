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
import java.text.SimpleDateFormat;

@WebServlet("/projet/liste")
public class ListeProjetServlet extends HttpServlet {
    
    @Inject
    private ProjetService projetService;
    
    @Inject
    private UtilisateurService utilisateurService;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("ListeProjetServlet appelé ! Heure: " + new java.util.Date());
        
        try {
            // Vérifier que les services sont injectés
            if (projetService == null) {
                System.err.println("ERREUR CRITIQUE: ProjetService n'est pas injecté !");
                request.setAttribute("errorMessage", "Service des projets non disponible. Contactez l'administrateur.");
                request.getRequestDispatcher("/views/listeProjet.jsp").forward(request, response);
                return;
            }
            
            if (utilisateurService == null) {
                System.err.println("ERREUR CRITIQUE: UtilisateurService n'est pas injecté !");
                request.setAttribute("errorMessage", "Service des utilisateurs non disponible. Contactez l'administrateur.");
                request.getRequestDispatcher("/views/listeProjet.jsp").forward(request, response);
                return;
            }
            
            // Récupérer la liste des projets depuis la base de données
            System.out.println("Tentative de récupération des projets...");
            List<Projet> projets = projetService.findAll();
            System.out.println("Nombre de projets trouvés : " + projets.size());
            
            // Récupérer la liste des utilisateurs (responsables potentiels)
            System.out.println("Tentative de récupération des utilisateurs...");
            List<Utilisateur> utilisateurs = utilisateurService.findAll();
            System.out.println("Nombre d'utilisateurs trouvés : " + utilisateurs.size());
            
            
            
            // Afficher les détails des projets pour le débogage
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            for (Projet p : projets) {
                System.out.println("==============================================");
                System.out.println("ID: " + p.getId());
                System.out.println("Nom Projet: " + p.getNom());
                System.out.println("Nom Court: " + p.getNomCourt());
                System.out.println("Description: " + p.getDescription());
                System.out.println("Date Début: " + (p.getDateDebut() != null ? sdf.format(p.getDateDebut()) : "null"));
                System.out.println("Date Fin: " + (p.getDateFin() != null ? sdf.format(p.getDateFin()) : "null"));
                System.out.println("Budget: " + p.getBudget());
                System.out.println("Statut: " + p.getStatus());
                System.out.println("Progression: " + (p.getProgression() != null ? p.getProgression() + "%" : "Non définie"));
                System.out.println("Responsable: " + p.getResponsable());
                System.out.println("==============================================");
            }
            
            // Placer les listes dans les attributs de requête
            request.setAttribute("projets", projets);
            request.setAttribute("utilisateurs", utilisateurs);
            System.out.println("Attributs 'projets' et 'utilisateurs' définis dans la requête");
            
            // Pour éviter la mise en cache par le navigateur
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);
            
            
            // Rediriger vers la page JSP
            System.out.println("Redirection vers listeProjet.jsp");
            request.getRequestDispatcher("/views/listeProjet.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Erreur lors de la récupération des projets: " + e.getMessage());
            e.printStackTrace();
            
            // En cas d'erreur, afficher un message d'erreur et rediriger quand même
            request.setAttribute("errorMessage", "Une erreur est survenue lors du chargement des projets: " + e.getMessage());
            request.getRequestDispatcher("/views/listeProjet.jsp").forward(request, response);
        }
    }
}