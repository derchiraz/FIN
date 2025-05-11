package com.eadn.controller;

import com.eadn.entity.Opportunite;
import com.eadn.service.OpportuniteService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.text.SimpleDateFormat;

@WebServlet("/opportunite/liste")
public class ListeOpportuniteServlet extends HttpServlet {
    
    @Inject
    private OpportuniteService opportuniteService;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("ListeOpportuniteServlet appelé ! Heure: " + new java.util.Date());
        
        try {
            // Vérifier que le service est injecté
            if (opportuniteService == null) {
                System.err.println("ERREUR CRITIQUE: OpportuniteService n'est pas injecté !");
                request.setAttribute("errorMessage", "Service non disponible. Contactez l'administrateur.");
                request.getRequestDispatcher("/views/listeOpportunite.jsp").forward(request, response);
                return;
            }
            
            // Récupérer la liste des opportunités depuis la base de données
            System.out.println("Tentative de récupération des opportunités...");
            List<Opportunite> opportunites = opportuniteService.findAll();
            System.out.println("Nombre d'opportunités trouvées : " + opportunites.size());
            
            // Afficher les détails pour le débogage
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            for (Opportunite o : opportunites) {
                System.out.println("==============================================");
                System.out.println("ID: " + o.getId());
                System.out.println("Nom Opportunité: " + o.getNom_opportunite());
                System.out.println("Nom Entreprise: " + o.getNom_entreprise());
                System.out.println("Nom Contact: " + o.getNom_contact());
                System.out.println("Téléphone: " + o.getTelephone());
                System.out.println("Email: " + o.getEmail());
                System.out.println("Adresse: " + o.getAdresse());
                System.out.println("Description: " + o.getDescription_opportunite());
                System.out.println("Budget Estimé: " + o.getBudget_estime());
                System.out.println("Status: " + o.getStatus());
                System.out.println("Date Début: " + (o.getDateDebut() != null ? sdf.format(o.getDateDebut()) : "null"));
                System.out.println("Date Fin: " + (o.getDateFin() != null ? sdf.format(o.getDateFin()) : "null"));
                System.out.println("Responsable: " + o.getResponsable());
                System.out.println("==============================================");
            }
            
            // Placer la liste dans l'attribut de requête
            request.setAttribute("opportunites", opportunites);
            System.out.println("Attribut 'opportunites' défini dans la requête");
            
            // Pour éviter la mise en cache par le navigateur
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);
            
            // Rediriger vers la page JSP
            System.out.println("Redirection vers listeOpportunite.jsp");
            request.getRequestDispatcher("/views/listeOpportunite.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Erreur lors de la récupération des opportunités: " + e.getMessage());
            e.printStackTrace();
            
            // En cas d'erreur, afficher un message d'erreur et rediriger quand même
            request.setAttribute("errorMessage", "Une erreur est survenue lors du chargement des opportunités: " + e.getMessage());
            request.getRequestDispatcher("/views/listeOpportunite.jsp").forward(request, response);
        }
    }
}
