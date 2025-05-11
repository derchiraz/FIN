
package com.eadn.controller;

import com.eadn.entity.Opportunite;
import com.eadn.service.OpportuniteService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/opportunite/update")
public class UpdateOpportuniteServlet extends HttpServlet {
    
    @Inject
    private OpportuniteService opportuniteService;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("UpdateOpportuniteServlet appelé ! Heure: " + new java.util.Date());
        
        try {
            // Récupérer l'ID de l'opportunité
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
            
            // Récupérer tous les paramètres du formulaire
            String nomEntreprise = request.getParameter("nom_entreprise");
            String nomContact = request.getParameter("nom_contact");
            String telephone = request.getParameter("telephone");
            String email = request.getParameter("email");
            String nomOpportunite = request.getParameter("nom_opportunite");
            String descriptionOpportunite = request.getParameter("description_opportunite");
            String budgetEstimeStr = request.getParameter("budget_estime");
            String adresse = request.getParameter("adresse");
            String status = request.getParameter("status");
            
            String dateDebutStr = request.getParameter("dateDebut");
            String dateFinStr = request.getParameter("dateFin");
            
            String objectifsPrincipaux = request.getParameter("objectifs_principaux");
            String descriptionArchitecture = request.getParameter("description_architecture");
            
            // Mise à jour des champs de l'opportunité
            opportunite.setNom_entreprise(nomEntreprise);
            opportunite.setNom_contact(nomContact);
            opportunite.setTelephone(telephone);
            opportunite.setEmail(email);
            opportunite.setNom_opportunite(nomOpportunite);
            opportunite.setDescription_opportunite(descriptionOpportunite);
            opportunite.setAdresse(adresse);
            opportunite.setStatus(status);
            
            
            
            // Traitement des champs optionnels
            if (objectifsPrincipaux != null) {
                opportunite.setObjectifs_principaux(objectifsPrincipaux);
            }
            
            if (descriptionArchitecture != null) {
                opportunite.setDescription_architecture(descriptionArchitecture);
            }
            
            // Gestion des responsables et membres (si ces champs existent)
            String responsableStr = request.getParameter("responsable");
            if (responsableStr != null && !responsableStr.isEmpty()) {
                try {
                    Long responsableId = Long.parseLong(responsableStr);
                    opportunite.setResponsable_id(responsableId);
                } catch (NumberFormatException e) {
                    System.err.println("Format d'ID de responsable invalide: " + e.getMessage());
                }
            }
            
            String membre1Str = request.getParameter("membre1");
            if (membre1Str != null && !membre1Str.isEmpty()) {
                try {
                    Long membre1Id = Long.parseLong(membre1Str);
                    opportunite.setMembre1_id(membre1Id);
                } catch (NumberFormatException e) {
                    System.err.println("Format d'ID de membre1 invalide: " + e.getMessage());
                }
            }
            
            String membre2Str = request.getParameter("membre2");
            if (membre2Str != null && !membre2Str.isEmpty()) {
                try {
                    Long membre2Id = Long.parseLong(membre2Str);
                    opportunite.setMembre2_id(membre2Id);
                } catch (NumberFormatException e) {
                    System.err.println("Format d'ID de membre2 invalide: " + e.getMessage());
                }
            }
            
            String membre3Str = request.getParameter("membre3");
            if (membre3Str != null && !membre3Str.isEmpty()) {
                try {
                    Long membre3Id = Long.parseLong(membre3Str);
                    opportunite.setMembre3_id(membre3Id);
                } catch (NumberFormatException e) {
                    System.err.println("Format d'ID de membre3 invalide: " + e.getMessage());
                }
            }
            
            // Conversion et mise à jour du budget
            if (budgetEstimeStr != null && !budgetEstimeStr.isEmpty()) {
                try {
                    Double budgetEstime = Double.parseDouble(budgetEstimeStr);
                    opportunite.setBudget_estime(budgetEstime);
                } catch (NumberFormatException e) {
                    System.err.println("Format de budget invalide: " + e.getMessage());
                }
            }
            
            // Conversion et mise à jour des dates
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            
            if (dateDebutStr != null && !dateDebutStr.isEmpty()) {
                try {
                    Date dateDebut = dateFormat.parse(dateDebutStr);
                    opportunite.setDateDebut(dateDebut);
                } catch (Exception e) {
                    System.err.println("Format de date de début invalide: " + e.getMessage());
                }
            }
            
            if (dateFinStr != null && !dateFinStr.isEmpty()) {
                try {
                    Date dateFin = dateFormat.parse(dateFinStr);
                    opportunite.setDateFin(dateFin);
                } catch (Exception e) {
                    System.err.println("Format de date de fin invalide: " + e.getMessage());
                }
            }
            
            // Mise à jour de l'opportunité
            opportuniteService.update(opportunite);
            
            // Message de succès
            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "Opportunité mise à jour avec succès !");
            
            // Redirection vers la page des détails
            response.sendRedirect(request.getContextPath() + "/opportunite/details?id=" + id);
            
        } catch (NumberFormatException e) {
            System.err.println("ID d'opportunité invalide: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/opportunite/liste?erreur=format_id_invalide");
        } catch (Exception e) {
            System.err.println("Erreur lors de la mise à jour: " + e.getMessage());
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Erreur lors de la mise à jour de l'opportunité: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/opportunite/liste");
        }
    }
}
