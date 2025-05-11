package com.eadn.controller;

import com.eadn.entity.PasswordReset;
import com.eadn.entity.Utilisateur;
import com.eadn.service.EmailService;
import com.eadn.service.PasswordResetService;
import com.eadn.service.UtilisateurService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    
    @Inject
    private UtilisateurService utilisateurService;
    
    @Inject
    private PasswordResetService passwordResetService;
    
    @Inject
    private EmailService emailService;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Afficher le formulaire de demande de réinitialisation
        request.getRequestDispatcher("/views/forgotPassword.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Veuillez entrer une adresse email");
            request.getRequestDispatcher("/views/forgotPassword.jsp").forward(request, response);
            return;
        }
        
        // Vérifier si l'utilisateur existe
        Utilisateur utilisateur = utilisateurService.findByEmail(email);
        
        if (utilisateur != null) {
            // L'email existe dans la base de données, créer un token de réinitialisation
            PasswordReset reset = passwordResetService.createResetToken(email);
            
            // Construire l'URL de réinitialisation
            String resetUrl = request.getScheme() + "://" + request.getServerName() + 
                    (request.getServerPort() != 80 ? ":" + request.getServerPort() : "") + 
                    request.getContextPath() + "/reset-password?token=" + reset.getToken();
            
            // Afficher l'URL dans les logs (pour les tests)
            System.out.println("URL de réinitialisation pour " + email + ": " + resetUrl);
            
            try {
                // Envoyer l'email avec le lien de réinitialisation
                emailService.sendPasswordResetEmail(email, resetUrl);
                
                // Message de succès
                request.setAttribute("successMessage", "Un email de réinitialisation a été envoyé à " + email);
                request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            } catch (Exception e) {
                System.err.println("Erreur lors de l'envoi de l'email: " + e.getMessage());
                e.printStackTrace();
                
                // En cas d'erreur d'envoi d'email, afficher quand même l'URL pour les tests
                request.setAttribute("devMessage", "URL de réinitialisation (à utiliser pour les tests) : " + resetUrl);
                request.setAttribute("errorMessage", "Erreur lors de l'envoi de l'email. Utilisez l'URL affichée pour réinitialiser votre mot de passe.");
                request.getRequestDispatcher("/views/forgotPassword.jsp").forward(request, response);
            }
        } else {
            // L'email n'existe pas dans la base de données
            request.setAttribute("errorMessage", "Aucun compte ne correspond à cette adresse email");
            request.getRequestDispatcher("/views/forgotPassword.jsp").forward(request, response);
        }
    }
}