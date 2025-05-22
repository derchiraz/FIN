package com.eadn.controller;

import com.eadn.entity.Timesheet;
import com.eadn.entity.Projet;
import com.eadn.entity.Utilisateur;
import com.eadn.service.TimesheetService;
import com.eadn.service.ProjetService;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@WebServlet("/timesheet/*")
public class TimesheetServlet extends HttpServlet {
    
    @Inject
    private TimesheetService timesheetService;
    
    @Inject
    private ProjetService projetService;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getPathInfo();
        if (action == null) {
            action = "/view";
        }
        
        try {
            HttpSession session = request.getSession();
            Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
            
            if (utilisateur == null) {
                response.sendRedirect(request.getContextPath() + "/views/login.jsp");
                return;
            }
            
            switch (action) {
                case "/view":
                    viewTimesheet(request, response, utilisateur);
                    break;
                case "/delete":
                    deleteTimesheet(request, response, utilisateur);
                    break;
                default:
                    viewTimesheet(request, response, utilisateur);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur: " + e.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getPathInfo();
        if (action == null) {
            action = "/save";
        }
        
        try {
            HttpSession session = request.getSession();
            Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
            
            if (utilisateur == null) {
                response.sendRedirect(request.getContextPath() + "/views/login.jsp");
                return;
            }
            
            switch (action) {
                case "/save":
                    saveTimesheet(request, response, utilisateur);
                    break;
                case "/submit":
                    submitTimesheet(request, response, utilisateur);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/timesheet/view");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur: " + e.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }
    
    
  private void viewTimesheet(HttpServletRequest request, HttpServletResponse response, Utilisateur utilisateur) 
        throws ServletException, IOException {
    
    try {
        // Récupérer la date de début depuis le paramètre ou utiliser la date courante
        String dateDebutStr = request.getParameter("dateDebut");
        String nav = request.getParameter("nav");
        Date dateDebut;
        
        if (dateDebutStr != null && !dateDebutStr.isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                dateDebut = sdf.parse(dateDebutStr);
                
                // Si un paramètre de navigation est présent, ajuster la date
                if (nav != null) {
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(dateDebut);
                    
                    if ("prev".equals(nav)) {
                        cal.add(Calendar.DAY_OF_MONTH, -7); // Semaine précédente
                    } else if ("next".equals(nav)) {
                        cal.add(Calendar.DAY_OF_MONTH, 7); // Semaine suivante
                    }
                    
                    dateDebut = cal.getTime();
                }
            } catch (Exception e) {
                dateDebut = timesheetService.getFirstDayOfCurrentWeek();
            }
        } else {
            dateDebut = timesheetService.getFirstDayOfCurrentWeek();
        }
        
        // Récupérer les timesheets de l'utilisateur pour cette semaine
        List<Timesheet> timesheets = timesheetService.findByUtilisateurAndWeek(utilisateur.getId(), dateDebut);
        
        // Récupérer tous les projets pour le formulaire
        List<Projet> projets = projetService.findAll();
        
        // Mettre les objets dans la requête
        request.setAttribute("dateDebut", dateDebut);
        
        // Ajouter une date formatée pour les liens de navigation
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        request.setAttribute("Monday", sdf.format(dateDebut));
        
        request.setAttribute("timesheets", timesheets);
        request.setAttribute("projets", projets);
        
        // Afficher la page
        request.getRequestDispatcher("/views/timesheet.jsp").forward(request, response);
        
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("errorMessage", "Erreur lors de la récupération des timesheets: " + e.getMessage());
        request.getRequestDispatcher("/views/error.jsp").forward(request, response);
    }

}
    private void saveTimesheet(HttpServletRequest request, HttpServletResponse response, Utilisateur utilisateur) 
            throws ServletException, IOException {
        
        try {
        // Récupérer les paramètres communs
        String dateDebutStr = request.getParameter("dateDebut");
        Date dateDebut;
        
        // Vérifier si la date est bien fournie et au bon format
        if (dateDebutStr == null || dateDebutStr.isEmpty() || dateDebutStr.contains("<fmt:formatDate")) {
            // Si la date est invalide, utiliser la date du lundi de la semaine courante
            dateDebut = timesheetService.getFirstDayOfCurrentWeek();
        } else {
            try {
                // Essayer de parser la date fournie
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                dateDebut = sdf.parse(dateDebutStr);
            } catch (Exception ex) {
                // En cas d'erreur de parsing, utiliser la date du lundi de la semaine courante
                System.err.println("Erreur de parsing de date: " + dateDebutStr);
                dateDebut = timesheetService.getFirstDayOfCurrentWeek();
            }
        }
            // Récupérer les IDs des projets
            String[] projetIds = request.getParameterValues("projetId");
            
            if (projetIds != null) {
                for (String projetIdStr : projetIds) {
                    // Ignorer les entrées vides
                    if (projetIdStr == null || projetIdStr.isEmpty()) {
                        continue;
                    }
                    
                    Long projetId = Long.parseLong(projetIdStr);
                    String role = request.getParameter("role_" + projetId);
                    
                    // Si le rôle n'est pas spécifique au projet, utiliser le rôle général
                    if (role == null || role.isEmpty()) {
                        role = request.getParameter("role");
                    }
                    
                    // Récupérer les heures pour chaque jour
                    String lundiStr = request.getParameter("lundi_" + projetId);
                    String mardiStr = request.getParameter("mardi_" + projetId);
                    String mercrediStr = request.getParameter("mercredi_" + projetId);
                    String jeudiStr = request.getParameter("jeudi_" + projetId);
                    String vendrediStr = request.getParameter("vendredi_" + projetId);
                    String samediStr = request.getParameter("samedi_" + projetId);
                    String dimancheStr = request.getParameter("dimanche_" + projetId);
                    
                    // Si les heures ne sont pas spécifiques au projet, utiliser les heures générales
                    if (lundiStr == null || lundiStr.isEmpty()) lundiStr = request.getParameter("lundi");
                    if (mardiStr == null || mardiStr.isEmpty()) mardiStr = request.getParameter("mardi");
                    if (mercrediStr == null || mercrediStr.isEmpty()) mercrediStr = request.getParameter("mercredi");
                    if (jeudiStr == null || jeudiStr.isEmpty()) jeudiStr = request.getParameter("jeudi");
                    if (vendrediStr == null || vendrediStr.isEmpty()) vendrediStr = request.getParameter("vendredi");
                    if (samediStr == null || samediStr.isEmpty()) samediStr = request.getParameter("samedi");
                    if (dimancheStr == null || dimancheStr.isEmpty()) dimancheStr = request.getParameter("dimanche");
                    
                    // Convertir en minutes
                    int lundi = Timesheet.convertirHeureEnMinutes(lundiStr);
                    int mardi = Timesheet.convertirHeureEnMinutes(mardiStr);
                    int mercredi = Timesheet.convertirHeureEnMinutes(mercrediStr);
                    int jeudi = Timesheet.convertirHeureEnMinutes(jeudiStr);
                    int vendredi = Timesheet.convertirHeureEnMinutes(vendrediStr);
                    int samedi = Timesheet.convertirHeureEnMinutes(samediStr);
                    int dimanche = Timesheet.convertirHeureEnMinutes(dimancheStr);
                    
                    // Vérifier si une entrée existe déjà pour ce projet et cette semaine
                    List<Timesheet> existingTimesheets = timesheetService.findByUtilisateurAndWeek(utilisateur.getId(), dateDebut);
                    Timesheet existingTimesheet = null;
                    
                    for (Timesheet ts : existingTimesheets) {
                        if (ts.getProjet().getId().equals(projetId)) {
                            existingTimesheet = ts;
                            break;
                        }
                    }
                    
                    if (existingTimesheet != null) {
                        // Mettre à jour l'existant s'il est encore en brouillon
                        if ("Brouillon".equals(existingTimesheet.getStatut())) {
                            existingTimesheet.setRole(role);
                            existingTimesheet.setLundi(lundi);
                            existingTimesheet.setMardi(mardi);
                            existingTimesheet.setMercredi(mercredi);
                            existingTimesheet.setJeudi(jeudi);
                            existingTimesheet.setVendredi(vendredi);
                            existingTimesheet.setSamedi(samedi);
                            existingTimesheet.setDimanche(dimanche);
                            
                            timesheetService.save(existingTimesheet);
                        }
                    } else {
                        // Créer une nouvelle entrée
                        Timesheet timesheet = new Timesheet();
                        timesheet.setUtilisateur(utilisateur);
                        timesheet.setProjet(projetService.findById(projetId));
                        timesheet.setRole(role);
                        timesheet.setDateDebut(dateDebut);
                        timesheet.setLundi(lundi);
                        timesheet.setMardi(mardi);
                        timesheet.setMercredi(mercredi);
                        timesheet.setJeudi(jeudi);
                        timesheet.setVendredi(vendredi);
                        timesheet.setSamedi(samedi);
                        timesheet.setDimanche(dimanche);
                        
                        timesheetService.save(timesheet);
                    }
                }
            }
            
            // Message de succès
            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "Timesheet enregistrée avec succès!");
            
            // Redirection vers la vue
            response.sendRedirect(request.getContextPath() + "/timesheet/view?dateDebut=" + dateDebutStr);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors de l'enregistrement: " + e.getMessage());
            request.getRequestDispatcher("/views/timesheet.jsp").forward(request, response);
        }
    }
    
    private void submitTimesheet(HttpServletRequest request, HttpServletResponse response, Utilisateur utilisateur) 
            throws ServletException, IOException {
        
        try {
            // Récupérer la date de début
            String dateDebutStr = request.getParameter("dateDebut");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date dateDebut = sdf.parse(dateDebutStr);
            
            // Soumettre toutes les timesheets de la semaine
            timesheetService.soumettreTimesheetsSemaine(utilisateur.getId(), dateDebut);
            
            // Message de succès
            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "Timesheet soumise avec succès!");
            
            // Redirection
            response.sendRedirect(request.getContextPath() + "/timesheet/view?dateDebut=" + dateDebutStr);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors de la soumission: " + e.getMessage());
            request.getRequestDispatcher("/views/timesheet.jsp").forward(request, response);
        }
    }
    
       private void deleteTimesheet(HttpServletRequest request, HttpServletResponse response, Utilisateur utilisateur) 
            throws ServletException, IOException {
        
        try {
            // Récupérer l'ID du timesheet à supprimer
            String timesheetIdStr = request.getParameter("id");
            
            if (timesheetIdStr != null && !timesheetIdStr.isEmpty()) {
                Long timesheetId = Long.parseLong(timesheetIdStr);
                
                // Vérifier que le timesheet appartient bien à l'utilisateur courant
                Timesheet timesheet = timesheetService.findById(timesheetId);
                if (timesheet != null && timesheet.getUtilisateur().getId().equals(utilisateur.getId())) {
                    // Seulement si le statut est "Brouillon"
                    if ("Brouillon".equals(timesheet.getStatut())) {
                        boolean success = timesheetService.delete(timesheetId);
                        
                        HttpSession session = request.getSession();
                        if (success) {
                            session.setAttribute("successMessage", "Timesheet supprimée avec succès!");
                        } else {
                            session.setAttribute("errorMessage", "Impossible de supprimer ce timesheet.");
                        }
                    } else {
                        HttpSession session = request.getSession();
                        session.setAttribute("errorMessage", "Impossible de supprimer un timesheet déjà soumis.");
                    }
                } else {
                    HttpSession session = request.getSession();
                    session.setAttribute("errorMessage", "Vous n'avez pas l'autorisation de supprimer ce timesheet.");
                }
            }
            
            // Redirection
            String dateDebutStr = request.getParameter("dateDebut");
            if (dateDebutStr == null || dateDebutStr.isEmpty()) {
                dateDebutStr = new SimpleDateFormat("yyyy-MM-dd").format(timesheetService.getFirstDayOfCurrentWeek());
            }
            
            response.sendRedirect(request.getContextPath() + "/timesheet/view?dateDebut=" + dateDebutStr);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors de la suppression: " + e.getMessage());
            request.getRequestDispatcher("/views/timesheet.jsp").forward(request, response);
        }
    }
    
    /**
     * Méthode pour récupérer les jours de la semaine à partir d'une date de début (lundi)
     */
    private void prepareDatesSemaine(HttpServletRequest request, Date dateDebut) {
        try {
            Calendar cal = Calendar.getInstance();
            cal.setTime(dateDebut);
            
            String[] joursNoms = {"Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"};
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM");
            
            // Créer des attributs pour chaque jour de la semaine
            for (int i = 0; i < 7; i++) {
                Date jourDate = cal.getTime();
                request.setAttribute("jour" + i + "Nom", joursNoms[i]);
                request.setAttribute("jour" + i + "Date", sdf.format(jourDate));
                request.setAttribute("jour" + i + "DateFull", new SimpleDateFormat("yyyy-MM-dd").format(jourDate));
                
                // Passer au jour suivant
                cal.add(Calendar.DATE, 1);
            }
            
            // Calculer la date de fin de semaine (dimanche)
            cal.setTime(dateDebut);
            cal.add(Calendar.DATE, 6);
            request.setAttribute("dateFin", cal.getTime());
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    /**
     * Méthode pour traiter l'ajout d'un timesheet pour le mois entier 
     * (utile pour des entrées récurrentes)
     */
    private void addMonthlyTimesheet(HttpServletRequest request, HttpServletResponse response, Utilisateur utilisateur)
            throws ServletException, IOException {
        
        try {
            // Récupérer les paramètres communs
            String dateDebutStr = request.getParameter("dateDebut");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date dateDebut = sdf.parse(dateDebutStr);
            
            String projetIdStr = request.getParameter("projetId");
            String role = request.getParameter("role");
            
            if (projetIdStr != null && !projetIdStr.isEmpty() && role != null && !role.isEmpty()) {
                Long projetId = Long.parseLong(projetIdStr);
                
                // Heures standards pour chaque jour (chaîne)
                String heuresStr = request.getParameter("heuresJour");
                int heures = Timesheet.convertirHeureEnMinutes(heuresStr);
                
                // Récupérer le premier jour du mois et le nombre de semaines
                Calendar cal = Calendar.getInstance();
                cal.setTime(dateDebut);
                cal.set(Calendar.DAY_OF_MONTH, 1);
                
                // Trouver le premier lundi du mois (ou le lundi précédent si le 1er est après lundi)
                int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
                if (dayOfWeek != Calendar.MONDAY) {
                    cal.add(Calendar.DATE, -(dayOfWeek - Calendar.MONDAY + (dayOfWeek == Calendar.SUNDAY ? 7 : 0)));
                }
                
                // Projet
                Projet projet = projetService.findById(projetId);
                
                // Créer un timesheet pour chaque semaine du mois
                Calendar endOfMonth = Calendar.getInstance();
                endOfMonth.setTime(dateDebut);
                endOfMonth.set(Calendar.DAY_OF_MONTH, endOfMonth.getActualMaximum(Calendar.DAY_OF_MONTH));
                
                while (cal.getTime().before(endOfMonth.getTime()) || cal.get(Calendar.MONTH) == endOfMonth.get(Calendar.MONTH)) {
                    Date weekStart = cal.getTime();
                    
                    // Vérifier si un timesheet existe déjà pour cette semaine et ce projet
                    List<Timesheet> existingTimesheets = timesheetService.findByUtilisateurAndWeek(utilisateur.getId(), weekStart);
                    boolean exists = false;
                    
                    for (Timesheet ts : existingTimesheets) {
                        if (ts.getProjet().getId().equals(projetId)) {
                            exists = true;
                            break;
                        }
                    }
                    
                    if (!exists) {
                        // Créer un nouveau timesheet
                        Timesheet timesheet = new Timesheet();
                        timesheet.setUtilisateur(utilisateur);
                        timesheet.setProjet(projet);
                        timesheet.setRole(role);
                        timesheet.setDateDebut(weekStart);
                        
                        // Définir les heures standards pour tous les jours de la semaine
                        timesheet.setLundi(heures);
                        timesheet.setMardi(heures);
                        timesheet.setMercredi(heures);
                        timesheet.setJeudi(heures);
                        timesheet.setVendredi(heures);
                        timesheet.setSamedi(0); // Weekend par défaut à 0
                        timesheet.setDimanche(0); // Weekend par défaut à 0
                        
                        timesheetService.save(timesheet);
                    }
                    
                    // Passer à la semaine suivante
                    cal.add(Calendar.DATE, 7);
                }
                
                // Message de succès
                HttpSession session = request.getSession();
                session.setAttribute("successMessage", "Timesheets mensuels créés avec succès!");
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Veuillez spécifier un projet et un rôle.");
            }
            
            // Redirection
            response.sendRedirect(request.getContextPath() + "/timesheet/view?dateDebut=" + dateDebutStr);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors de la création des timesheets mensuels: " + e.getMessage());
            request.getRequestDispatcher("/views/timesheet.jsp").forward(request, response);
        }
    }
    
    /**
     * Méthode pour récupérer l'historique des timesheets d'un utilisateur
     */
    private void viewHistorique(HttpServletRequest request, HttpServletResponse response, Utilisateur utilisateur)
            throws ServletException, IOException {
        
        try {
            // Récupérer tous les timesheets de l'utilisateur
            List<Timesheet> timesheets = timesheetService.findByUtilisateur(utilisateur.getId());
            
            // Préparer les données pour l'affichage
            // Organiser les timesheets par semaine et par projet
            java.util.Map<Date, java.util.Map<Long, Timesheet>> timesheetsByWeek = new java.util.TreeMap<>(java.util.Collections.reverseOrder());
            
            for (Timesheet ts : timesheets) {
                // Obtenir ou créer la map pour cette semaine
                java.util.Map<Long, Timesheet> weekMap = timesheetsByWeek.computeIfAbsent(ts.getDateDebut(), k -> new java.util.HashMap<>());
                
                // Ajouter le timesheet à la map de la semaine
                weekMap.put(ts.getProjet().getId(), ts);
            }
            
            request.setAttribute("timesheetsByWeek", timesheetsByWeek);
            
            // Afficher la page d'historique
            request.getRequestDispatcher("/views/timesheetHistorique.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors de la récupération de l'historique: " + e.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }
    
    /**
     * Méthode pour exporter les timesheets d'un utilisateur au format CSV
     */
    private void exportCSV(HttpServletRequest request, HttpServletResponse response, Utilisateur utilisateur)
            throws ServletException, IOException {
        
        try {
            // Récupérer la période d'export (début et fin)
            String dateDebutStr = request.getParameter("dateDebut");
            String dateFinStr = request.getParameter("dateFin");
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date dateDebut = (dateDebutStr != null && !dateDebutStr.isEmpty()) ? sdf.parse(dateDebutStr) : null;
            Date dateFin = (dateFinStr != null && !dateFinStr.isEmpty()) ? sdf.parse(dateFinStr) : null;
            
            // Si pas de date spécifiée, exporter le mois courant
            if (dateDebut == null) {
                Calendar cal = Calendar.getInstance();
                cal.set(Calendar.DAY_OF_MONTH, 1); // Premier jour du mois
                dateDebut = cal.getTime();
                
                cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH)); // Dernier jour du mois
                dateFin = cal.getTime();
            } else if (dateFin == null) {
                // Si dateDebut spécifiée mais pas dateFin, utiliser 1 mois après dateDebut
                Calendar cal = Calendar.getInstance();
                cal.setTime(dateDebut);
                cal.add(Calendar.MONTH, 1);
                dateFin = cal.getTime();
            }
            
            // Récupérer les timesheets pour la période
            List<Timesheet> timesheets = timesheetService.findByUtilisateurAndPeriod(utilisateur.getId(), dateDebut, dateFin);
            
            // Configurer la réponse pour téléchargement de fichier CSV
            response.setContentType("text/csv");
            response.setHeader("Content-Disposition", "attachment; filename=\"timesheet_export.csv\"");
            
            // Écrire les données CSV
            try (java.io.PrintWriter writer = response.getWriter()) {
                // En-tête
                writer.println("Date début,Projet,Rôle,Lundi,Mardi,Mercredi,Jeudi,Vendredi,Samedi,Dimanche,Total,Statut");
                
                // Données
                SimpleDateFormat dateFmt = new SimpleDateFormat("dd/MM/yyyy");
                for (Timesheet ts : timesheets) {
                    StringBuilder line = new StringBuilder();
                    line.append(dateFmt.format(ts.getDateDebut())).append(",");
                    line.append(cleanCsvField(ts.getProjet().getNom())).append(",");
                    line.append(cleanCsvField(ts.getRole())).append(",");
                    line.append(Timesheet.convertirMinutesEnHeure(ts.getLundi())).append(",");
                    line.append(Timesheet.convertirMinutesEnHeure(ts.getMardi())).append(",");
                    line.append(Timesheet.convertirMinutesEnHeure(ts.getMercredi())).append(",");
                    line.append(Timesheet.convertirMinutesEnHeure(ts.getJeudi())).append(",");
                    line.append(Timesheet.convertirMinutesEnHeure(ts.getVendredi())).append(",");
                    line.append(Timesheet.convertirMinutesEnHeure(ts.getSamedi())).append(",");
                    line.append(Timesheet.convertirMinutesEnHeure(ts.getDimanche())).append(",");
                    line.append(Timesheet.convertirMinutesEnHeure(ts.getTotalHeures())).append(",");
                    line.append(cleanCsvField(ts.getStatut()));
                    
                    writer.println(line.toString());
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors de l'export CSV: " + e.getMessage());
            request.getRequestDispatcher("/views/timesheet.jsp").forward(request, response);
        }
    }
    
    /**
     * Utilitaire pour échapper les champs CSV contenant des virgules
     */
    private String cleanCsvField(String field) {
        if (field == null) {
            return "";
        }
        
        // Si le champ contient une virgule ou un guillemet, entourer de guillemets
        if (field.contains(",") || field.contains("\"")) {
            return "\"" + field.replace("\"", "\"\"") + "\"";
        }
        return field;
    }
}