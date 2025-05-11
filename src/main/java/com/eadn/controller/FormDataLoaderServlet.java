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
import java.util.List;

@WebServlet("/load-form-data")
public class FormDataLoaderServlet extends HttpServlet {
    
    @Inject
    private UtilisateurService utilisateurService;
    
    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    // Récupère la page cible
    String targetPage = request.getParameter("page");
    System.out.println("FormDataLoaderServlet appelé avec page: " + targetPage);
    
    // Charge la liste des utilisateurs
    List<Utilisateur> utilisateurs = utilisateurService.findAll();
    System.out.println("Nombre d'utilisateurs chargés: " + utilisateurs.size());
    
    request.setAttribute("utilisateurs", utilisateurs);
    
    // Redirige vers la page appropriée
    if (targetPage != null) {
        request.getRequestDispatcher("/views/" + targetPage + ".jsp").forward(request, response);
    } else {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Page cible non spécifiée");
    }
}
}