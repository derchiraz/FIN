package com.eadn.controller;

import com.eadn.entity.Utilisateur;
import com.eadn.service.UtilisateurService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

    @Inject
    private UtilisateurService service;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Rediriger vers la page d'inscription
        request.getRequestDispatcher("/views/singup.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Récupérer les paramètres du formulaire
            String nom = request.getParameter("nom");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String service = request.getParameter("service");
            String statut = request.getParameter("statut");
            String dateStr = request.getParameter("date");
            
            // Validation des champs obligatoires
            if (nom == null || nom.trim().isEmpty() || 
                email == null || email.trim().isEmpty() || 
                password == null || password.trim().isEmpty() ||
                service == null || service.trim().isEmpty() ||
                statut == null || statut.trim().isEmpty() ||
                dateStr == null || dateStr.trim().isEmpty()) {
                
                request.setAttribute("errorMessage", "Tous les champs sont obligatoires");
                request.getRequestDispatcher("/views/singup.jsp").forward(request, response);
                return;
            }
            
            // Validation du mot de passe (minimum 8 caractères)
            if (password.length() < 8) {
                request.setAttribute("errorMessage", "Le mot de passe doit contenir au moins 8 caractères");
                request.getRequestDispatcher("/views/singup.jsp").forward(request, response);
                return;
            }
            
            // Vérifier si l'email existe déjà
            if (this.service.emailExists(email)) {
                request.setAttribute("errorMessage", "Cette adresse email est déjà utilisée");
                request.getRequestDispatcher("/views/singup.jsp").forward(request, response);
                return;
            }
            
            // Création de l'utilisateur
            Utilisateur utilisateur = new Utilisateur();
            utilisateur.setNom(nom);
            utilisateur.setEmail(email);
            utilisateur.setPassword(password);
            utilisateur.setService(service);
            utilisateur.setStatut(statut);
            
            // Conversion de la date
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date dateInscription = dateFormat.parse(dateStr);
            utilisateur.setDateInscription(dateInscription);
            
            // Valeur par défaut pour disponibilité
            utilisateur.setDisponibilite("disponible");
            
            // Sauvegarde avec logs
            System.out.println("Sauvegarde de l'utilisateur: " + utilisateur.getNom());
            this.service.save(utilisateur);
            System.out.println("Utilisateur sauvegardé avec ID: " + utilisateur.getId());
            
            // Message de succès et redirection vers login
            request.setAttribute("successMessage", "Inscription réussie ! Veuillez vous connecter.");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Erreur lors de l'inscription: " + e.getMessage());
            request.setAttribute("errorMessage", "Erreur lors de l'inscription: " + e.getMessage());
            request.getRequestDispatcher("/views/singup.jsp").forward(request, response);
        }
    }
}