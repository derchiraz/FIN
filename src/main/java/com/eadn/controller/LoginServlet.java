package com.eadn.controller;

import com.eadn.entity.Utilisateur;
import com.eadn.service.UtilisateurService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import jakarta.ejb.EJB;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    
@EJB
private UtilisateurService service;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Rediriger vers la page de login
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Validation des champs obligatoires
        if (email == null || email.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "Veuillez remplir tous les champs");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            return;
        }
        
        try {
            // Authentifier l'utilisateur
            Utilisateur utilisateur = service.authenticate(email, password);
            
            if (utilisateur != null) {
                // Créer une session pour l'utilisateur
                HttpSession session = request.getSession();
                session.setAttribute("utilisateur", utilisateur);
                
                // Log de connexion réussie
                System.out.println("Connexion réussie pour l'utilisateur: " + utilisateur.getEmail() + " (ID: " + utilisateur.getId() + ")");
                
                // Rediriger vers la page d'accueil
                response.sendRedirect(request.getContextPath() + "/views/home.jsp");
            } else {
                // Authentification échouée
                request.setAttribute("errorMessage", "Email ou mot de passe incorrect");
                request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Erreur lors de l'authentification: " + e.getMessage());
            request.setAttribute("errorMessage", "Une erreur s'est produite lors de la connexion");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }
}