package com.eadn.controller;

import com.eadn.entity.Opportunite;
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
import java.util.List;

@WebServlet("/opportunite/edit")
public class EditOpportuniteServlet extends HttpServlet {
    
    @Inject
    private com.eadn.service.OpportuniteService opportuniteService;
    @Inject
    private UtilisateurService utilisateurService;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("EditOpportuniteServlet appelé avec sendRedirect");
        
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/opportunite/liste?erreur=id_manquant");
                return;
            }
            
            Long id = Long.parseLong(idStr);
            Opportunite opportunite = opportuniteService.findById(id);
            
            if (opportunite == null) {
                response.sendRedirect(request.getContextPath() + "/opportunite/liste?erreur=opportunite_non_trouvee");
                return;
            }
            if (utilisateurService == null) {
                System.err.println("ERREUR CRITIQUE: UtilisateurService n'est pas injecté !");
                response.sendRedirect(request.getContextPath() + "/opportunite/liste?erreur=service_non_disponible");
                return;
            }
            // Charger la liste des utilisateurs pour le choix du responsable
            List<Utilisateur> utilisateurs = utilisateurService.findAll();
            // Stocke l'opportunité dans la session sous le nom "opportunite" au lieu de "opportuniteEdit"
            HttpSession session = request.getSession();
            session.setAttribute("opportunite", opportunite);
          
            // Rediriger vers la JSP
            response.sendRedirect(request.getContextPath() + "/views/editOpportunite.jsp");
            
        } catch (Exception e) {
            System.err.println("Erreur: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/opportunite/liste?erreur=" + e.getMessage());
        }
    }
}