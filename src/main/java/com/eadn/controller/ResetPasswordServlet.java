package com.eadn.controller;

import com.eadn.entity.Utilisateur;
import com.eadn.service.PasswordResetService;
import com.eadn.service.UtilisateurService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {
    
    @Inject
    private PasswordResetService passwordResetService;
    
    @Inject
    private UtilisateurService utilisateurService;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String token = request.getParameter("token");
        
        if (token == null || token.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Token invalide ou manquant");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            return;
        }
        
        // Vérifier si le token est valide
        if (!passwordResetService.isTokenValid(token)) {
            request.setAttribute("errorMessage", "Ce lien de réinitialisation n'est plus valide. Veuillez faire une nouvelle demande.");
            request.getRequestDispatcher("/forgotPassword.jsp").forward(request, response);
            return;
        }
        
        // Token valide, afficher le formulaire de réinitialisation
        request.setAttribute("token", token);
        request.getRequestDispatcher("/resetPassword.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String token = request.getParameter("token");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Vérification des paramètres
        if (token == null || token.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Token invalide ou manquant");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            return;
        }
        
        if (password == null || password.trim().isEmpty() || 
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Veuillez remplir tous les champs");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/resetPassword.jsp").forward(request, response);
            return;
        }
        
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Les mots de passe ne correspondent pas");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/resetPassword.jsp").forward(request, response);
            return;
        }
        
        if (password.length() < 8) {
            request.setAttribute("errorMessage", "Le mot de passe doit contenir au moins 8 caractères");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/resetPassword.jsp").forward(request, response);
            return;
        }
        
        // Vérifier si le token est valide
        if (!passwordResetService.isTokenValid(token)) {
            request.setAttribute("errorMessage", "Ce lien de réinitialisation n'est plus valide. Veuillez faire une nouvelle demande.");
            request.getRequestDispatcher("//forgotPassword.jsp").forward(request, response);
            return;
        }
        
        // Récupérer l'email associé au token
        String email = passwordResetService.findByToken(token).getEmail();
        Utilisateur utilisateur = utilisateurService.findByEmail(email);
        
        if (utilisateur == null) {
            request.setAttribute("errorMessage", "Utilisateur introuvable");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            return;
        }
        
        // Mettre à jour le mot de passe
        utilisateur.setPassword(password); // Le service se chargera de hasher
        utilisateurService.update(utilisateur);
        
        // Marquer le token comme utilisé
        passwordResetService.useToken(token);
        
        // Rediriger vers la page de connexion avec un message de succès
        request.setAttribute("successMessage", "Votre mot de passe a été réinitialisé avec succès. Vous pouvez maintenant vous connecter.");
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }
}