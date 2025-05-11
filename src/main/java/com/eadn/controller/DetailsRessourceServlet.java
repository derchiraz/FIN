package com.eadn.controller;

import com.eadn.entity.Ressource;
import com.eadn.entity.Coordonnee;
import com.eadn.service.RessourceService;
import com.eadn.service.CoordonneeService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/ressource/details/*")
public class DetailsRessourceServlet extends HttpServlet {
    
    @Inject
    private RessourceService ressourceService;
    
    @Inject
    private CoordonneeService coordonneeService;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("DetailsRessourceServlet appelé ! Heure: " + new java.util.Date());
        
        try {
            // Extraire l'ID de la ressource de l'URL
            String pathInfo = request.getPathInfo();
            if (pathInfo == null || pathInfo.equals("/")) {
                response.sendRedirect(request.getContextPath() + "/ressource/liste");
                return;
            }
            
            // Récupérer l'ID à partir du chemin (/123 => 123)
            String idStr = pathInfo.substring(1);
            Long id = Long.parseLong(idStr);
            
            System.out.println("Recherche de la ressource avec l'ID: " + id);
            
            // Vérifier que le service est injecté
            if (ressourceService == null) {
                System.err.println("ERREUR CRITIQUE: RessourceService n'est pas injecté !");
                request.setAttribute("errorMessage", "Service non disponible. Contactez l'administrateur.");
                request.getRequestDispatcher("/views/error.jsp").forward(request, response);
                return;
            }
            
            // Chercher la ressource par son ID
            Ressource ressource = ressourceService.findById(id);
            if (ressource == null) {
                System.err.println("Ressource avec ID " + id + " non trouvée");
                request.setAttribute("errorMessage", "Ressource non trouvée.");
                request.getRequestDispatcher("/views/error.jsp").forward(request, response);
                return;
            }
            
            System.out.println("Ressource trouvée: " + ressource.getNom());
            
            // Récupérer les coordonnées associées (si disponibles)
            Coordonnee coordonnee = null;
            if (coordonneeService != null) {
                try {
                    coordonnee = coordonneeService.findByRessourceId(id);
                    System.out.println("Coordonnées trouvées: " + (coordonnee != null));
                } catch (Exception e) {
                    System.out.println("Aucune coordonnée trouvée pour cette ressource: " + e.getMessage());
                }
            }
            
            // Calculer le service et la disponibilité
            Date aujourd_hui = new Date();
            String service = determinerService(ressource);
            String disponibilite = determinerDisponibilite(ressource, aujourd_hui);
            
            Map<String, String> attrs = new HashMap<>();
            attrs.put("service", service);
            attrs.put("disponibilite", disponibilite);
            
            // Placer les objets dans les attributs de requête
            request.setAttribute("ressource", ressource);
            request.setAttribute("coordonnee", coordonnee);
            request.setAttribute("attrs", attrs);
            
            // Rediriger vers la page de détails
            request.getRequestDispatcher("/views/detailsRessource.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            System.err.println("ID de ressource invalide: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/ressource/liste");
        } catch (Exception e) {
            System.err.println("Erreur lors de l'affichage des détails: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Une erreur est survenue: " + e.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
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