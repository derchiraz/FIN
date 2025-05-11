package com.eadn.controller;

import com.eadn.entity.Opportunite;
import com.eadn.service.OpportuniteService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.text.SimpleDateFormat;

@WebServlet("/opportunite/save")
@MultipartConfig
public class OpportuniteServlet extends HttpServlet {

    @Inject
    private OpportuniteService service;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Opportunite o = new Opportunite();
            
            // Récupérer l'ID pour savoir si c'est une création ou une mise à jour
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                o.setId(Long.parseLong(idStr));
            }
            
            o.setNom_entreprise(request.getParameter("nom_entreprise"));
            o.setNom_contact(request.getParameter("nom_contact"));
            o.setTelephone(request.getParameter("telephone"));
            o.setEmail(request.getParameter("email"));
            o.setAdresse(request.getParameter("adresse"));
            o.setNom_opportunite(request.getParameter("nom_opportunite"));
            
            // Utilisation de la bonne méthode selon le modèle de l'entité
            String description = request.getParameter("description_opportunite");
            if (description != null) {
                o.setDescription_opportunite(description);
            }
            
            String budgetStr = request.getParameter("budget_estime");
            if (budgetStr != null && !budgetStr.isEmpty()) {
                o.setBudget_estime(Double.parseDouble(budgetStr));
            }
            
            o.setStatus(request.getParameter("status"));
            o.setObjectifs_principaux(request.getParameter("objectifs_principaux"));
            o.setDescription_architecture(request.getParameter("descriptionArchitecture"));
            o.setResponsable(request.getParameter("responsable"));
            
            // Membres de l'équipe
            o.setMembre1(request.getParameter("membre1"));
            o.setMembre2(request.getParameter("membre2"));
            o.setMembre3(request.getParameter("membre3"));

            // Format de date depuis input HTML
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            
            String dateDebutStr = request.getParameter("dateDebut");
            if (dateDebutStr != null && !dateDebutStr.isEmpty()) {
                o.setDateDebut(sdf.parse(dateDebutStr));
            }
            
            String dateFinStr = request.getParameter("dateFin");
            if (dateFinStr != null && !dateFinStr.isEmpty()) {
                o.setDateFin(sdf.parse(dateFinStr));
            }
            
            // Gestion fichier
            try {
                Part filePart = request.getPart("file");
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = filePart.getSubmittedFileName();
                    o.setNom_fichier(fileName);
                    // Pour enregistrer le fichier sur le disque : filePart.write(...)
                }
            } catch (Exception e) {
                System.out.println("Pas de fichier joint: " + e.getMessage());
            }

            // Sauvegarde dans la base de données
            if (o.getId() == null) {
                service.save(o);
                System.out.println("Opportunité sauvegardée avec ID: " + o.getId());
            } else {
                service.update(o);
                System.out.println("Opportunité mise à jour avec ID: " + o.getId());
            }

            request.setAttribute("successMessage", "Opportunité enregistrée avec succès !");
            request.getRequestDispatcher("/views/opportunite.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Erreur lors de l'enregistrement: " + e.getMessage());
            request.setAttribute("errorMessage", "Erreur lors de l'enregistrement de l'opportunité: " + e.getMessage());
            request.getRequestDispatcher("/views/opportunite.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("edit".equals(action)) {
            // Récupérer l'opportunité pour édition
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                try {
                    Long id = Long.parseLong(idStr);
                    Opportunite opportunite = service.findById(id);
                    if (opportunite != null) {
                        request.setAttribute("opportunite", opportunite);
                        request.getRequestDispatcher("/views/opportunite.jsp").forward(request, response);
                        return;
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "ID d'opportunité invalide.");
                }
            }
        } else if ("delete".equals(action)) {
            // Supprimer une opportunité
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                try {
                    Long id = Long.parseLong(idStr);
                    service.delete(id);
                    request.setAttribute("successMessage", "Opportunité supprimée avec succès.");
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "ID d'opportunité invalide.");
                }
            }
        }
        
        // Rediriger vers la liste des opportunités
        request.getRequestDispatcher("/views/listeOpportunite.jsp").forward(request, response);
    }
}