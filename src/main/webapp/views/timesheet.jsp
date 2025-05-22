<%-- 
    Document   : timesheet
    Created on : 24 mars 2025, 00:20:54
    Author     : L13
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Timesheet</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/projet.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/timesheet.css">
    <!-- Icons pour la sidebar -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <style>
    /* Styles pour les nouvelles fonctionnalités */

/* Styles pour les détails de projet */
.project-details {
    margin-top: 10px;
    padding: 8px;
    background-color: rgba(0, 0, 0, 0.02);
    border-radius: 4px;
    font-size: 0.85rem;
    transition: all 0.3s ease;
}

.dark-theme .project-details {
    background-color: rgba(255, 255, 255, 0.05);
}

.project-status {
    display: flex;
    align-items: center;
    margin-bottom: 5px;
}

.status-label, .client-label {
    font-weight: 500;
    margin-right: 5px;
}

.status-value {
    padding: 2px 6px;
    border-radius: 12px;
    font-size: 0.75rem;
    font-weight: 500;
}

.status-value.active {
    background-color: #dcfce7;
    color: #14532d;
}

.status-value.pending {
    background-color: #fef9c3;
    color: #713f12;
}

.status-value.completed {
    background-color: #dbeafe;
    color: #1e3a8a;
}

.status-value.cancelled {
    background-color: #fecaca;
    color: #7f1d1d;
}

.dark-theme .status-value.active {
    background-color: rgba(22, 163, 74, 0.2);
    color: #86efac;
}

.dark-theme .status-value.pending {
    background-color: rgba(234, 179, 8, 0.2);
    color: #fde047;
}

.dark-theme .status-value.completed {
    background-color: rgba(37, 99, 235, 0.2);
    color: #93c5fd;
}

.dark-theme .status-value.cancelled {
    background-color: rgba(220, 38, 38, 0.2);
    color: #fca5a5;
}

.project-progress {
    display: flex;
    align-items: center;
    margin-bottom: 5px;
}

.progress-bar {
    flex-grow: 1;
    height: 6px;
    background-color: #e5e7eb;
    border-radius: 3px;
    margin-right: 10px;
    overflow: hidden;
}

.dark-theme .progress-bar {
    background-color: #374151;
}

.progress-fill {
    height: 100%;
    background-color: #3b82f6;
    border-radius: 3px;
    width: 0%;
    transition: width 0.4s ease;
}

.progress-value {
    font-size: 0.75rem;
    font-weight: 500;
    min-width: 35px;
    text-align: right;
}

.project-client {
    margin-top: 5px;
    font-size: 0.8rem;
}

/* Animation pour afficher les détails du projet */
.project-details.show {
    max-height: 150px;
    opacity: 1;
}

.project-details.hide {
    max-height: 0;
    opacity: 0;
    padding: 0;
    margin: 0;
    overflow: hidden;
}

/* Styles pour surbrillance des projets sélectionnés */
.timesheet-table tr.project-selected {
    background-color: rgba(59, 130, 246, 0.05);
}

.dark-theme .timesheet-table tr.project-selected {
    background-color: rgba(59, 130, 246, 0.1);
}

/* Styles pour la fenêtre popup d'informations projet */
.project-info-popup {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: white;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
    padding: 20px;
    width: 80%;
    max-width: 600px;
    z-index: 1000;
    display: none;
}

.dark-theme .project-info-popup {
    background-color: #1f2937;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.4);
}

.project-info-popup .close-btn {
    position: absolute;
    top: 15px;
    right: 15px;
    background: none;
    border: none;
    cursor: pointer;
    font-size: 1.2rem;
    color: #6b7280;
}

.dark-theme .project-info-popup .close-btn {
    color: #9ca3af;
}

.project-info-header {
    margin-bottom: 15px;
    padding-bottom: 15px;
    border-bottom: 1px solid #e5e7eb;
}

.dark-theme .project-info-header {
    border-bottom: 1px solid #374151;
}

.project-info-title {
    font-size: 1.25rem;
    font-weight: 600;
    margin-bottom: 5px;
}

.project-info-client {
    color: #6b7280;
    font-size: 0.9rem;
}

.dark-theme .project-info-client {
    color: #9ca3af;
}

.project-info-section {
    margin-bottom: 15px;
}

.project-info-section h3 {
    font-size: 1rem;
    font-weight: 500;
    margin-bottom: 8px;
}

.project-info-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 15px;
}

.project-info-item {
    margin-bottom: 10px;
}

.project-info-label {
    font-size: 0.85rem;
    color: #6b7280;
    margin-bottom: 3px;
}

.dark-theme .project-info-label {
    color: #9ca3af;
}

.project-info-value {
    font-size: 0.95rem;
}

.project-details-show {
    font-size: 0.8rem;
    color: #3b82f6;
    margin-top: 5px;
    cursor: pointer;
    display: inline-block;
}

.dark-theme .project-details-show {
    color: #60a5fa;
}

.project-details-show:hover {
    text-decoration: underline;
}

.overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 999;
    display: none;
}

/* Ajustements CSS pour le timesheet */
.timesheet-table td {
    vertical-align: top;
}

.timesheet-table .project-input {
    width: 100%;
}
</style>
    
</head>
<body>
    <!-- Header principal -->
    <header class="main-header">
        <div class="logo">
            <span class="eadn">EADN</span> <span class="timex">Timex</span>
        </div>
        <div class="header-search">
            <input type="text" placeholder="Rechercher...">
            <button><i class="fas fa-search"></i></button>
        </div>
        
        <div class="user-menu">
            <span class="user-name">${sessionScope.utilisateur.nom}</span>
            <div class="user-avatar" id="avatar-trigger">
                <span>${sessionScope.utilisateur.initiales}</span>
                <i class="fas fa-chevron-down"></i>
            </div>
            <div class="user-dropdown" id="user-dropdown">
                <div class="dropdown-header">
                    <div class="user-avatar-lg">${sessionScope.utilisateur.initiales}</div>
                    <div class="user-info">
                        <div class="user-fullname">${sessionScope.utilisateur.nom} ${sessionScope.utilisateur.prenom}</div>
                        <div class="user-email">${sessionScope.utilisateur.email}</div>
                    </div>
                </div>
                <ul class="dropdown-menu">
                    <li><a href="${pageContext.request.contextPath}/views/coordonne.jsp"><i class="fas fa-user"></i> Mes coordonnées</a></li>
                    <li class="divider"></li>
                    <li>
                        <a href="${pageContext.request.contextPath}/views/login.jsp" class="login">
                            <i class="fas fa-sign-out-alt"></i> Déconnexion
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </header>

    <!-- Layout principal avec sidebar et contenu -->
    <div class="main-layout">
        <!-- Sidebar -->
        <aside class="sidebar" id="sidebar">
            <nav class="sidebar-nav">
                <ul>
                    <li>
                        <a href="${pageContext.request.contextPath}/views/home.jsp" class="nav-item">
                            <i class="fas fa-home"></i>
                            <span>Accueil</span>
                        </a>
                    </li>
                    
                    <li>
                        <a href="#" class="nav-item has-submenu" id="project-menu">
                            <i class="fas fa-project-diagram"></i>
                            <span>Projets</span>
                            <i class="fas fa-chevron-right submenu-icon"></i>
                        </a>
                        <ul class="submenu" id="project-submenu">
                            <li>
                                <a href="${pageContext.request.contextPath}/views/projet.jsp">
                                    <i class="fas fa-plus-circle"></i> Ajouter projet
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/views/listeProjet.jsp">
                                    <i class="fas fa-list"></i> Liste des projets
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="#" class="nav-item has-submenu" id="opportunite-menu">
                            <i class="fas fa-lightbulb"></i>
                            <span>Opportunités</span>
                            <i class="fas fa-chevron-right submenu-icon"></i>
                        </a>
                        <ul class="submenu" id="opportunite-submenu">
                            <li>
                                <a href="${pageContext.request.contextPath}/views/opportunite.jsp">
                                    <i class="fas fa-plus-circle"></i> Ajouter opportunité
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/views/listeOpportunite.jsp">
                                    <i class="fas fa-list"></i> Liste des opportunités
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="#" class="nav-item has-submenu" id="team-menu">
                            <i class="fas fa-users"></i>
                            <span>Ressource</span>
                            <i class="fas fa-chevron-right submenu-icon"></i>
                        </a>
                        <ul class="submenu" id="team-submenu">
                            <li>
                                <a href="${pageContext.request.contextPath}/views/ressources.jsp">
                                    <i class="fas fa-user-plus"></i> Nouvel employé
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/views/listeRessources.jsp">
                                    <i class="fas fa-users-cog"></i> liste des employés
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/timesheet/view" class="nav-item active">
                            <i class="fas fa-clock"></i>
                            <span>Timesheet</span>
                        </a>
                    </li>
                </ul>
            </nav>
            <div class="sidebar-footer">
                <div class="sidebar-collapse" id="sidebar-collapse">
                    <i class="fas fa-chevron-left"></i>
                </div>
                <div class="theme-toggle" id="theme-toggle">
                    <i class="fas fa-moon"></i>
                </div>
            </div>
        </aside>
    

        <!-- Contenu principal -->
        <main class="main-content" id="main-content">
            <div class="container">
                <div class="app-header">
                    <div class="breadcrumbs">
                        <a href="${pageContext.request.contextPath}/views/home.jsp">Accueil</a> / 
                        <span>Timesheet</span>
                    </div>
                    <div class="header-top">
                        <h1>Mon Timesheet</h1>
                        
                    </div>
                    <div class="header-divider"></div>
                </div>
                        
                            <form id="timesheet-form" action="${pageContext.request.contextPath}/timesheet/save" method="post">
    <c:set var="formattedDate"><fmt:formatDate value="${dateDebut}" pattern="yyyy-MM-dd" /></c:set>
    <input type="hidden" name="dateDebut" value="${formattedDate}">

                <div class="timesheet-container">
                    <div class="timesheet-header">
                       <div class="date-selector">
    <form id="week-form" action="${pageContext.request.contextPath}/timesheet/view" method="get">
        <label for="weekSelector">Semaine du:</label>
        <input type="date" id="weekSelector" name="dateDebut" value="<fmt:formatDate value="${dateDebut}" pattern="yyyy-MM-dd" />" class="form-control" onchange="this.form.submit()">
        <div class="week-nav">
            <a href="${pageContext.request.contextPath}/timesheet/view?dateDebut=${Monday}&nav=prev" class="btn btn-nav">
                <i class="fas fa-chevron-left"></i>
            </a>
            <button type="button" id="current-week" class="week-btn" onclick="goToCurrentWeek()"><i class="fas fa-calendar-day"></i></button>
            <a href="${pageContext.request.contextPath}/timesheet/view?dateDebut=${Monday}&nav=next" class="btn btn-nav">
                <i class="fas fa-chevron-right"></i>
            </a>
        </div>
        <input type="hidden" id="contextPath" value="${pageContext.request.contextPath}">
    </form>
</div>
</div>
                    </div>

                    <div class="timesheet-table-container">
                        <table class="timesheet-table">
                            <thead>
                                <tr>
                                    <th class="col-project">Projet</th>
                                    <th class="col-role">Rôle</th>
                                    <th class="day-header">Lun</th>
                                    <th class="day-header">Mar</th>
                                    <th class="day-header">Mer</th>
                                    <th class="day-header">Jeu</th>
                                    <th class="day-header">Ven</th>
                                    <th class="day-header">Sam</th>
                                    <th class="day-header">Dim</th>
                                    <th class="col-total">Total</th>
                                </tr>
                            </thead>
                            <tbody id="timesheetBody">
                                <tr>
    <td>
        <div class="row-actions">
            <button type="button" class="delete-row-btn" onclick="deleteRow(this)">
                <i class="fas fa-minus"></i>
            </button>
            <select name="projetId" class="project-input" onchange="updateProjectDetails(this)">
                <option value="">Sélectionner un projet</option>
                <c:forEach var="projet" items="${projets}">
                <option value="${projet.id}" 
                         data-status="${projet.status}" 
                         data-progress="${projet.progression}">
                    ${projet.nom}
                </option>
                </c:forEach>
            </select>
        </div>
    </td>
    <td>
        <select name="role" class="role-input">
            <option value="">Sélectionner un rôle</option>
            <option value="Développement">Développement</option>
            <option value="Design">Design</option>
            <option value="Tests">Tests</option>
            <option value="Gestion de projet">Gestion de projet</option>
        </select>
    </td>
    <td><input type="text" name="lundi_${projet.id}" value="${ts.lundiFormatted}" class="hours-input" placeholder="hh:mm" pattern="^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$" onchange="updateHours(this)" maxlength="5"></td>
<td><input type="text" name="mardi_${projet.id}" value="${ts.mardiFormatted}" class="hours-input" placeholder="hh:mm" pattern="^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$" onchange="updateHours(this)" maxlength="5"></td>
<td><input type="text" name="mercredi_${projet.id}" value="${ts.lundiFormatted}" class="hours-input" placeholder="hh:mm" pattern="^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$" onchange="updateHours(this)" maxlength="5"></td>
<td><input type="text" name="jeudi_${projet.id}" value="${ts.mardiFormatted}" class="hours-input" placeholder="hh:mm" pattern="^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$" onchange="updateHours(this)" maxlength="5"></td>
<td><input type="text" name="vendredi_${projet.id}" value="${ts.lundiFormatted}" class="hours-input" placeholder="hh:mm" pattern="^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$" onchange="updateHours(this)" maxlength="5"></td>
<td><input type="text" name="samedi_${projet.id}" value="${ts.mardiFormatted}" class="hours-input" placeholder="hh:mm" pattern="^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$" onchange="updateHours(this)" maxlength="5"></td>
<td><input type="text" name="dimanche_${projet.id}" value="${ts.lundiFormatted}" class="hours-input" placeholder="hh:mm" pattern="^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$" onchange="updateHours(this)" maxlength="5"></td>

    <td class="row-total">00:00</td>
</tr>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="2" class="total-label">Total journalier</td>
                                    <td class="column-total">00:00</td>
                                    <td class="column-total">00:00</td>
                                    <td class="column-total">00:00</td>
                                    <td class="column-total">00:00</td>
                                    <td class="column-total">00:00</td>
                                    <td class="column-total">00:00</td>
                                    <td class="column-total">00:00</td>
                                    <td class="grand-total">00:00</td>
                                </tr>
                            </tfoot>
                        </table>

                        <!-- Ajouter ce code après la fermeture du tableau -->
                        <div class="timesheet-actions" style="margin-top: 20px; text-align: right;">
    <button type="button" class="btn btn-primary" onclick="addNewRow()">
        <i class="fas fa-plus"></i> Ajouter une ligne
    </button>
    <button type="submit" class="btn btn-success">
        <i class="fas fa-save"></i> Enregistrer
    </button>
</div>

                    </div>

                    <div class="actions">
                        
                        <button class="btn btn-secondary" onclick="resetTimesheet()">
                            <i class="fas fa-undo"></i> Réinitialiser
                        </button>
                        <div class="right-actions">
                           
                            <button class="btn btn-success" onclick="submitTimesheet()">
                                <i class="fas fa-paper-plane"></i> Soumettre
                            </button>
                        </div>
                    </div>
                </div>
               </form>
            </div>
    
        </main>
    </div>

    <!-- Notification toast -->
    <div class="toast-container">
        <div class="toast" id="toast-success">
            <div class="toast-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            <div class="toast-content">
                <div class="toast-title">Succès!</div>
                <div class="toast-message">Votre timesheet a été enregistré avec succès.</div>
            </div>
            <button class="toast-close">
                <i class="fas fa-times"></i>
            </button>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/timesheet.js"></script>
    <script>
    // Fonction pour naviguer vers une date spécifique
    function navigateToDate(dateStr) {
        if (dateStr) {
            window.location.href = '${pageContext.request.contextPath}/timesheet/view?dateDebut=' + dateStr;
        }
    }
    
    // Fonction pour ajouter une nouvelle ligne avec les projets correctement chargés
   
    
    // Mettre à jour les totaux après chargement de la page
    document.addEventListener('DOMContentLoaded', function() {
        // Initialiser le sélecteur de semaine avec la date actuelle du serveur
        const dateDebut = "${formattedDate}";
        if (dateDebut) {
            const weekSelector = document.getElementById('weekSelector');
            if (weekSelector) {
                weekSelector.value = dateDebut;
            }
        }
        
        // Calculer les totaux initiaux
        calculateTotals();
    });
    // Fonction pour naviguer vers une date spécifique
function navigateToDate(dateStr) {
    if (dateStr) {
        window.location.href = contextPath + '/timesheet/view?dateDebut=' + dateStr;
    }
}
    </script>
</body>
</html>
        