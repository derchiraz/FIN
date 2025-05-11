package com.eadn.controller;

import com.eadn.entity.Ressource;
import com.eadn.service.RessourceService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/ressource/liste")
public class ListeRessourceServlet extends HttpServlet {
    
    @Inject
    private RessourceService ressourceService;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("ListeRessourceServlet appelé ! Heure: " + new java.util.Date());
        
        try {
            // Vérifier que le service est injecté
            if (ressourceService == null) {
                System.err.println("ERREUR CRITIQUE: RessourceService n'est pas injecté !");
                request.setAttribute("errorMessage", "Service non disponible. Contactez l'administrateur.");
                request.getRequestDispatcher("/views/listeRessources.jsp").forward(request, response);
                return;
            }
            
            // Récupérer la liste des ressources depuis la base de données
            System.out.println("Tentative de récupération des ressources...");
            List<Ressource> ressources = ressourceService.findAll();
            System.out.println("Nombre de ressources trouvées : " + ressources.size());
            
            // Créer un Map pour stocker les attributs calculés pour chaque ressource
            Map<Long, Map<String, String>> attributsRessources = new HashMap<>();
            
            // Date actuelle pour le calcul de la disponibilité
            Date aujourd_hui = new Date();
            
            // Afficher les détails pour le débogage
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            for (Ressource r : ressources) {
                // Calculer le service et la disponibilité
                String service = determinerService(r);
                String disponibilite = determinerDisponibilite(r, aujourd_hui);
                
                // Stocker ces valeurs calculées dans un Map
                Map<String, String> attributs = new HashMap<>();
                attributs.put("service", service);
                attributs.put("disponibilite", disponibilite);
                attributsRessources.put(r.getId(), attributs);
                
                // Log pour débogage
                System.out.println("==============================================");
                System.out.println("ID: " + r.getId());
                System.out.println("Code: " + r.getCode());
                System.out.println("Nom: " + r.getNom());
                System.out.println("Service calculé: " + service);
                System.out.println("Disponibilité calculée: " + disponibilite);
                System.out.println("==============================================");
            }
            
            // Placer les ressources et les attributs calculés dans la requête
            request.setAttribute("ressources", ressources);
            request.setAttribute("attributsRessources", attributsRessources);
            System.out.println("Attributs définis dans la requête");
            
            // Pour éviter la mise en cache par le navigateur
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);
            
            // Rediriger vers la page JSP
            System.out.println("Redirection vers listeRessources.jsp");
            request.getRequestDispatcher("/views/listeRessources.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Erreur lors de la récupération des ressources: " + e.getMessage());
            e.printStackTrace();
            
            // En cas d'erreur, afficher un message d'erreur et rediriger quand même
            request.setAttribute("errorMessage", "Une erreur est survenue lors du chargement des ressources: " + e.getMessage());
            request.getRequestDispatcher("/views/listeRessources.jsp").forward(request, response);
        }
    }
    
    /**
     * Détermine le service d'une ressource à partir de sa branche ou de son poste
     */
    private String determinerService(Ressource r) {
        // Déterminer à partir de la branche
        if (r.getBranche() != null && !r.getBranche().isEmpty()) {
            String branche = r.getBranche().toLowerCase();
            if (branche.contains("inform") || branche.contains("tech")) {
                return "informatique";
            } else if (branche.contains("commerc") || branche.contains("vente")) {
                return "commercial";
            } else if (branche.contains("rh") || branche.contains("human")) {
                return "rh";
            } else if (branche.contains("finan") || branche.contains("compta")) {
                return "finance";
            } else if (branche.contains("mark")) {
                return "marketing";
            }
        }
        
        // Déterminer à partir du poste
        if (r.getPoste() != null && !r.getPoste().isEmpty()) {
            String poste = r.getPoste().toLowerCase();
            if (poste.contains("dével") || poste.contains("program") || poste.contains("tech")) {
                return "informatique";
            } else if (poste.contains("vend") || poste.contains("commerc")) {
                return "commercial";
            } else if (poste.contains("rh") || poste.contains("recrut")) {
                return "rh";
            } else if (poste.contains("compt") || poste.contains("finan")) {
                return "finance";
            } else if (poste.contains("market") || poste.contains("communi")) {
                return "marketing";
            }
        }
        
        return "autre";
    }
    
    /**
     * Détermine la disponibilité d'une ressource en fonction de ses dates de contrat
     */
    private String determinerDisponibilite(Ressource r, Date aujourd_hui) {
        // Si pas de date de fin, considéré comme disponible
        if (r.getDateFin() == null) {
            return "disponible";
        }
        
        // Si date de fin est passée, considéré comme indisponible
        if (r.getDateFin().before(aujourd_hui)) {
            return "indisponible";
        }
        
        // Calculer le nombre de jours entre aujourd'hui et la date de fin
        long diffMs = r.getDateFin().getTime() - aujourd_hui.getTime();
        long diffJours = diffMs / (1000 * 60 * 60 * 24);
        
        // Si moins de 30 jours, considéré comme partiellement disponible
        if (diffJours < 30) {
            return "partiel";
        }
        
        return "disponible";
    }
}