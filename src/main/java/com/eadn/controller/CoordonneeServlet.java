package com.eadn.controller;

import com.eadn.entity.Coordonnee;
import com.eadn.entity.Utilisateur;
import com.eadn.service.CoordonneeService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/coordonnee/save")
public class CoordonneeServlet extends HttpServlet {

    @Inject
    private CoordonneeService service;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Récupérer l'utilisateur de la session
            HttpSession session = request.getSession();
            Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
            
            // Créer ou récupérer les coordonnées existantes
            Coordonnee coordonnee;
            if (utilisateur != null) {
                coordonnee = service.findByUtilisateur(utilisateur);
                if (coordonnee == null) {
                    coordonnee = new Coordonnee();
                    coordonnee.setUtilisateur(utilisateur);
                }
            } else {
                coordonnee = new Coordonnee();
            }
            
            // Remplir l'objet avec les données du formulaire
            coordonnee.setNom(request.getParameter("nom"));
            coordonnee.setTitre(request.getParameter("titre"));
            coordonnee.setService(request.getParameter("service"));
            coordonnee.setEmail(request.getParameter("email"));
            coordonnee.setPhone(request.getParameter("phone"));
            coordonnee.setDisponibilite(request.getParameter("disponibilite"));
            
            // Sauvegarder ou mettre à jour
            if (coordonnee.getId() == null) {
                service.save(coordonnee);
            } else {
                service.update(coordonnee);
            }
            
            // Afficher un message de succès
            request.setAttribute("successMessage", "Vos coordonnées ont été mises à jour avec succès !");
            request.getRequestDispatcher("/views/coordonne.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors de l'enregistrement des coordonnées: " + e.getMessage());
            request.getRequestDispatcher("/views/coordonne.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Récupérer l'utilisateur depuis la session
            HttpSession session = request.getSession();
            Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
            
            if (utilisateur != null) {
                // Récupérer les coordonnées de l'utilisateur
                Coordonnee coordonnee = service.findByUtilisateur(utilisateur);
                // Passer à la JSP
                request.setAttribute("coordonnee", coordonnee);
            }
            
            request.getRequestDispatcher("/views/coordonne.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors du chargement des coordonnées: " + e.getMessage());
            request.getRequestDispatcher("/views/coordonne.jsp").forward(request, response);
        }
    }
}