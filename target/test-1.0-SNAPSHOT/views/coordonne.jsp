<%-- 
    Document   : coordonne
    Created on : 10 avr. 2025, 01:02:17
    Author     : L13
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Mes Coordonnées</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/projet.css">
    <!-- Icons pour la sidebar -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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
                        <a href="#" class="nav-item has-submenu " id="project-menu">
                            <i class="fas fa-project-diagram"></i>
                            <span>Projets</span>
                            <i class="fas fa-chevron-right submenu-icon"></i>
                        </a>
                        <ul class="submenu " id="project-submenu">
                            <li>
                                <a href="${pageContext.request.contextPath}/views/projet.jsp">
                                    <i class="fas fa-plus-circle"></i> Ajouter projet
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/views/listeProjet.jsp" >
                                    <i class="fas fa-list"></i> Liste des projets
                                </a>
                            </li>
                            
                        </ul>
                    </li>
                    <li>
                        <a href="#" class="nav-item has-submenu  " id="opportunite-menu">
                            <i class="fas fa-lightbulb"></i>
                            <span>Opportunités</span>
                            <i class="fas fa-chevron-right submenu-icon"></i>
                        </a>
                        <ul class="submenu  " id="opportunite-submenu">
                            <li>
                                <a href="${pageContext.request.contextPath}/views/opportunite.jsp" >
                                    <i class="fas fa-plus-circle"></i> Ajouter opportunité
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/views/listeOpportunite.jsp" >
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
                        <a href="${pageContext.request.contextPath}/views/timesheet.jsp" class="nav-item">
                            <i class="fas fa-cog"></i>
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
                        <span>Profil</span>/ 
                        <span>Mes coordonnées</span>
                    </div>
                    <div class="header-top">
                        <h1>Mes Coordonnées</h1>
                        <div class="header-actions">
                            <button class="btn-action" id="edit-btn">
                                <span class="icon"><i class="fas fa-pen"></i></span> <span class="btn-text">Modifier</span>
                            </button>
                        </div>
                    </div>
                    <div class="header-divider"></div>
                </div>
               <form id="coordonneesForm" action="${pageContext.request.contextPath}/coordonnee/save" method="post">
                    <div class="form-container">
                        <div class="row">
                            <!-- Colonne gauche - Informations -->
                            <div class="col-left">
                                <div class="form-section">
                                    <h4 class="section-title">Informations Personnelles</h4>
                                    <div class="input-group">
                                        <label for="nom">Nom</label>
                                        <input type="text" id="nom" name="nom" class="form-control" 
                                            value="${sessionScope.utilisateur.nom}" readonly>
                                    </div>
                                    <div class="input-group">
                                        <label for="titre">Titre</label>
                                        <input type="text" id="titre" name="titre" class="form-control" 
                                            value="${sessionScope.utilisateur.titre}" readonly>
                                    </div>
                                    <div class="input-group">
                                        <label for="service">Service</label>
                                        <input type="text" id="service" name="service" class="form-control" 
                                            value="${sessionScope.utilisateur.service}" readonly>
                                    </div>
                                    <div class="input-group">
                                        <label for="statut">Historique du statut</label>
                                        <input type="text" id="statut" name="statut" class="form-control" 
                                            value="${sessionScope.utilisateur.statut}" readonly>
                                    </div>
                                    <div class="input-group">
                                        <label for="disponibilite">Disponibilité</label>
                                        <select id="disponibilite" name="disponibilite" class="form-control" readonly>
                                            <option value="disponible" ${sessionScope.utilisateur.disponibilite == 'disponible' ? 'selected' : ''}>Disponible</option>
                                            <option value="partiel" ${sessionScope.utilisateur.disponibilite == 'partiel' ? 'selected' : ''}>Partiellement disponible</option>
                                            <option value="indisponible" ${sessionScope.utilisateur.disponibilite == 'indisponible' ? 'selected' : ''}>Indisponible</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="form-section">
                                    <h4 class="section-title">Coordonnées</h4>
                                    <div class="input-group">
                                        <label for="email">Email</label>
                                        <input type="email" id="email" name="email" class="form-control" 
                                            value="${sessionScope.utilisateur.email}" readonly>
                                    </div>
                                    <div class="input-group">
                                        <label for="phone">Téléphone</label>
                                        <input type="text" id="phone" name="phone" class="form-control" 
                                            value="${sessionScope.utilisateur.phone}" readonly>
                                    </div>
                                </div>

                                <div class="btn-container" id="buttons" style="display: none;">
                                    <button type="button" class="btn-secondary" id="cancel-btn">Annuler</button>
                                    <button type="button" class="btn-primary" id="save-btn">
                                        <i class="fas fa-save"></i> Sauvegarder
                                    </button>
                                </div>
                            </div>
                            
                            <!-- Colonne droite - Profil -->
                            <div class="col-right">
                                <div class="profile-card">
                                    <div class="profile-header">
                                        <div class="profile-avatar">
                                            <span id="profile-initials">${sessionScope.utilisateur.initiales}</span>
                                        </div>
                                        <div class="profile-info">
                                            <h3 id="profile-name">${sessionScope.utilisateur.nom}</h3>
                                            <p id="profile-title">${sessionScope.utilisateur.titre}</p>
                                        </div>
                                    </div>
                                    
                                    <div class="profile-actions">
                                        <a href="#" class="profile-action" id="email-action">
                                            <i class="fas fa-envelope"></i> Email
                                        </a>
                                        <a href="#" class="profile-action" id="phone-action">
                                            <i class="fas fa-phone"></i> Téléphone
                                        </a>
                                    </div>
                                    <div class="profile-links">
                                        <a href="${pageContext.request.contextPath}/views/timesheet.jsp" class="profile-link">
                                            <i class="fas fa-clock"></i> Mes feuilles de temps
                                        </a>
                                        <a href="${pageContext.request.contextPath}/cv" class="profile-link">
                                            <i class="fas fa-file-alt"></i> Mon CV
                                        </a>
                                    </div>
                                </div>
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
                <div class="toast-message">Vos coordonnées ont été mises à jour avec succès.</div>
            </div>
            <button class="toast-close">
                <i class="fas fa-times"></i>
            </button>
        </div>
    </div>

    <style>
        /* Styles spécifiques pour la page des coordonnées */
        .row {
            display: flex;
            flex-wrap: wrap;
            margin: 0 -15px;
        }
        
        .col-left {
            flex: 1;
            padding: 0 15px;
            min-width: 60%;
            width: 850px;
        }
        
        .col-right {
            width: 320px;
            padding: 0 15px;
            position: absolute;
            margin-left: 900px;
        }
        .profile-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            margin-bottom: 20px;
        }
        
        .profile-header {
            padding: 20px;
            display: flex;
            align-items: center;
            border-bottom: 1px solid #eee;
        }
        
        .profile-avatar {
            width: 70px;
            height: 70px;
            background: #007bff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: white;
            margin-right: 15px;
        }
        
        .profile-info h3 {
            margin: 0 0 5px;
            font-size: 18px;
        }
        
        .profile-info p {
            margin: 0;
            color: #666;
        }
        
        .profile-actions {
            display: flex;
            padding: 10px;
            border-bottom: 1px solid #eee;
        }
        
        .profile-action {
            flex: 1;
            text-align: center;
            padding: 10px;
            color: #007bff;
            text-decoration: none;
            font-size: 14px;
            transition: all 0.2s;
        }
        
        .profile-action:hover {
            background: rgba(0, 123, 255, 0.1);
            border-radius: 5px;
        }
        
        .profile-links {
            padding: 10px;
        }
        
        .profile-link {
            display: block;
            padding: 10px 15px;
            color: #333;
            text-decoration: none;
            transition: all 0.2s;
            border-radius: 5px;
        }
        
        .profile-link:hover {
            background: #f5f5f5;
        }
        
        .profile-link i {
            margin-right: 8px;
            color: #007bff;
        }
        
        /* Dark Theme Overrides */
        .dark-theme .profile-card {
            background: #333;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
        }
        
        .dark-theme .profile-header,
        .dark-theme .profile-stats,
        .dark-theme .profile-actions {
            border-color: #444;
        }
        
        .dark-theme .profile-info h3,
        .dark-theme .stat-value {
            color: #fff;
        }
        
        .dark-theme .profile-info p,
        .dark-theme .stat-label {
            color: #aaa;
        }
        
        .dark-theme .profile-link {
            color: #ddd;
        }
        
        .dark-theme .profile-link:hover {
            background: #444;
        }
        
        /* Animation pour les champs en mode édition */
        .editable {
            border: 2px solid #007bff !important;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
            animation: glow 1.5s infinite alternate;
        }
        
        @keyframes glow {
            from {
                box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
            }
            to {
                box-shadow: 0 0 10px rgba(0, 123, 255, 0.6);
            }
        }
        
        /* Animation pour les erreurs */
        .shake {
            animation: shake 0.5s;
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
            20%, 40%, 60%, 80% { transform: translateX(5px); }
        }
        
        /* Style d'erreur */
        .error {
            border-color: #dc3545 !important;
        }
        
        .error-message {
            display: none;
            color: #dc3545;
            margin-top: 5px;
            font-size: 14px;
        }
        
        /* Modification sur place */
        .form-control {
            transition: all 0.3s ease;
            background-color: #f9f9f9;
        }
        
        .form-control:focus {
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
            border-color: #007bff;
        }
        
        .form-control[readonly] {
            background-color: #f9f9f9;
            cursor: default;
            border: 1px solid #ddd;
        }
        
        .form-control:not([readonly]) {
            background-color: #fff;
            cursor: text;
        }
        
        .btn-container {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }
        
        /* Responsive design */
        @media (max-width: 992px) {
            .row {
                flex-direction: column;
            }
            
            .col-right {
                width: 100%;
                margin-top: 20px;
            }
        }
    </style>

    <script>
    document.addEventListener('DOMContentLoaded', function() {
    // Sidebar toggle
    const sidebarToggle = document.createElement('button');
    sidebarToggle.classList.add('sidebar-toggle');
    sidebarToggle.innerHTML = '<i class="fas fa-bars"></i>';
    document.querySelector('.main-header').prepend(sidebarToggle);
    
    sidebarToggle.addEventListener('click', function() {
        document.body.classList.toggle('sidebar-open');
    });
    
    // Sidebar collapse
    const sidebarCollapse = document.getElementById('sidebar-collapse');
    sidebarCollapse.addEventListener('click', function() {
        document.body.classList.toggle('sidebar-collapsed');
        setTimeout(() => {
            window.dispatchEvent(new Event('resize'));
        }, 300);
    });

    // User dropdown
    const avatarTrigger = document.getElementById('avatar-trigger');
    const userDropdown = document.getElementById('user-dropdown');
    
    avatarTrigger.addEventListener('click', function(e) {
        e.stopPropagation();
        userDropdown.classList.toggle('show');
    });
    
    document.addEventListener('click', function() {
        userDropdown.classList.remove('show');
    });
    
    // Toggle submenu
    const submenus = document.querySelectorAll('.has-submenu');
    submenus.forEach(menu => {
        menu.addEventListener('click', function(e) {
            // Fermer tous les autres sous-menus
            submenus.forEach(otherMenu => {
                if (otherMenu !== menu) {
                    const subId = otherMenu.id.replace('-menu', '-submenu');
                    const subMenu = document.getElementById(subId);
                    subMenu.classList.remove('show');
                    otherMenu.classList.remove('expanded');
                }
            });
            
            const subId = this.id.replace('-menu', '-submenu');
            const subMenu = document.getElementById(subId);
            subMenu.classList.toggle('show');
            this.classList.toggle('expanded');
            e.preventDefault();
        });
    });

    // Animations sur survol
    const navItems = document.querySelectorAll('.nav-item');
    navItems.forEach(item => {
        item.addEventListener('mouseenter', function() {
            if (!this.classList.contains('has-submenu')) {
                this.querySelector('i:first-child').classList.add('fa-beat');
            }
        });
        
        item.addEventListener('mouseleave', function() {
            this.querySelector('i:first-child').classList.remove('fa-beat');
        });
    });

    // Toggle du thème clair/sombre
    const themeToggle = document.getElementById('theme-toggle');
    themeToggle.addEventListener('click', function() {
        document.body.classList.toggle('dark-theme');
        if (document.body.classList.contains('dark-theme')) {
            themeToggle.innerHTML = '<i class="fas fa-sun"></i>';
            // Stocker la préférence
            localStorage.setItem('theme', 'dark');
        } else {
            themeToggle.innerHTML = '<i class="fas fa-moon"></i>';
            localStorage.setItem('theme', 'light');
        }
    });
    
    // Appliquer le thème sauvegardé
    if (localStorage.getItem('theme') === 'dark') {
        document.body.classList.add('dark-theme');
        themeToggle.innerHTML = '<i class="fas fa-sun"></i>';
    }

    // Variables globales pour stocker les valeurs originales et modifiées
    let originalValues = {};
    let currentValues = {}; // Nouvel objet pour stocker les valeurs actuelles
    let isEditMode = false;

    // Charger les valeurs du localStorage si disponibles
    loadSavedValues();

    // Bouton d'édition
    const editBtn = document.getElementById('edit-btn');
    const cancelBtn = document.getElementById('cancel-btn');
    const saveBtn = document.getElementById('save-btn');
    
    editBtn.addEventListener('click', toggleEditMode);
    cancelBtn.addEventListener('click', cancelChanges);
    saveBtn.addEventListener('click', saveChanges);
    
    // Actions email et téléphone
    document.getElementById('email-action').addEventListener('click', function(e) {
        e.preventDefault();
        const email = document.getElementById('email').value;
        if (email) {
            window.location.href = `mailto:${email}`;
        }
    });
    
    document.getElementById('phone-action').addEventListener('click', function(e) {
        e.preventDefault();
        const phone = document.getElementById('phone').value;
        if (phone) {
            window.location.href = `tel:${phone}`;
        }
    });
    
    // Toast notification
    const toast = document.getElementById('toast-success');
    const toastClose = document.querySelector('.toast-close');
    
    toastClose.addEventListener('click', function() {
        toast.classList.remove('show');
    });
    
    // Vérifier si un paramètre de succès est présent dans l'URL
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('success') && urlParams.get('success') === 'true') {
        // Afficher le toast de succès
        toast.classList.add('show');
        setTimeout(() => {
            toast.classList.remove('show');
        }, 5000);
        
        // Sauvegarder l'état actuel du formulaire dans le localStorage après une sauvegarde réussie
        saveFormState();
    }
    
    // Mettre à jour les initiales du profil en fonction du nom
    updateProfileInitials();
    
    // Suivre les changements dans les champs de formulaire
    const inputs = document.querySelectorAll(".form-control");
    inputs.forEach(input => {
        input.addEventListener('change', function() {
            if (isEditMode) {
                currentValues[input.id] = input.value;
                // Mettre à jour le localStorage à chaque changement
                saveFormState();
                
                // Mettre à jour l'affichage du profil en temps réel
                if (input.id === 'nom' || input.id === 'titre') {
                    updateProfileDisplay();
                }
            }
        });
        
        input.addEventListener('input', function() {
            if (isEditMode) {
                currentValues[input.id] = input.value;
            }
        });
    });
    
    function toggleEditMode() {
        if (!isEditMode) {
            // Activer le mode édition
            enterEditMode();
        } else {
            // Désactiver le mode édition
            exitEditMode();
        }
    }
    
    function enterEditMode() {
        const inputs = document.querySelectorAll(".form-control");
        
        // Sauvegarder les valeurs originales et rendre les champs éditables
        inputs.forEach((input) => {
            originalValues[input.id] = input.value;
            currentValues[input.id] = input.value; // Initialiser les valeurs actuelles
            input.readOnly = false;
            input.classList.add("editable");
        });
        
        // Activer le select de disponibilité
        document.getElementById('disponibilite').removeAttribute('readonly');
        
        // Afficher les boutons de sauvegarde et annulation
        document.getElementById("buttons").style.display = "flex";
        
        // Changer l'apparence du bouton éditer
        editBtn.querySelector(".icon").innerHTML = '<i class="fas fa-times"></i>';
        editBtn.querySelector(".btn-text").textContent = " Fermer";
        
        isEditMode = true;
    }
    
    function exitEditMode() {
        // Rétablir les valeurs modifiées et désactiver l'édition
        const inputs = document.querySelectorAll(".form-control");
        inputs.forEach((input) => {
            // Utiliser la valeur actuelle au lieu de l'originale
            input.value = currentValues[input.id] || originalValues[input.id] || "";
            input.readOnly = true;
            input.classList.remove("editable");
            input.classList.remove("error");
        });
        
        // Remettre le select en mode readonly
        document.getElementById('disponibilite').setAttribute('readonly', true);
        
        // Cacher les boutons de sauvegarde et annulation
         document.getElementById('coordonneesForm').submit();
        
        // Réinitialiser le bouton d'édition
        editBtn.querySelector(".icon").innerHTML = '<i class="fas fa-pen"></i>';
        editBtn.querySelector(".btn-text").textContent = " Modifier";
        
        isEditMode = false;
        
        // Mettre à jour l'affichage après la sortie du mode édition
        updateProfileDisplay();
    }
    
    function cancelChanges() {
        // Restaurer les valeurs originales
        const inputs = document.querySelectorAll(".form-control");
        inputs.forEach((input) => {
            input.value = originalValues[input.id] || "";
            currentValues[input.id] = originalValues[input.id] || ""; // Mettre à jour les valeurs actuelles
        });
        
        // Mettre à jour le localStorage avec les valeurs originales
        saveFormState();
        
        exitEditMode();
    }
    
    function saveChanges() {
        let valid = true;
        const inputs = document.querySelectorAll(".form-control");
        
        // Validation des champs
        inputs.forEach((input) => {
            if (input.value.trim() === "") {
                input.classList.add('error');
                input.classList.add('shake');
                setTimeout(() => input.classList.remove('shake'), 500);
                valid = false;
            } else {
                input.classList.remove('error');
                // Mettre à jour les valeurs actuelles
                currentValues[input.id] = input.value;
            }
        });
        
        if (!valid) return;
        
        // Sauvegarder les valeurs actuelles dans localStorage avant la soumission
        saveFormState();
        
        // Mettre à jour les données du profil dans la carte
        updateProfileDisplay();
        
        // Soumettre le formulaire avec AJAX pour éviter le rechargement de la page
        submitFormWithAjax();
    }
    
    function submitFormWithAjax() {
        const form = document.getElementById("coordonneesForm");
        const formData = new FormData(form);
        
        // Créer une requête AJAX
        const xhr = new XMLHttpRequest();
        xhr.open('POST', form.action, true);
        xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
        
        xhr.onload = function() {
            if (xhr.status === 200) {
                // Afficher le toast de succès
                toast.classList.add('show');
                setTimeout(() => {
                    toast.classList.remove('show');
                }, 5000);
                
                // Mettre à jour les valeurs originales pour correspondre aux nouvelles valeurs
                Object.keys(currentValues).forEach(key => {
                    originalValues[key] = currentValues[key];
                });
                
                // Sortir du mode édition
                exitEditMode();
                
                // Mettre à jour l'URL sans recharger la page
                window.history.replaceState({}, '', window.location.pathname + '?success=true');
            } else {
                // Gérer les erreurs
                alert('Une erreur est survenue lors de la sauvegarde. Veuillez réessayer.');
            }
        };
        
        xhr.onerror = function() {
            alert('Une erreur de connexion est survenue. Veuillez réessayer.');
        };
        
        xhr.send(formData);
    }
    
    function updateProfileDisplay() {
        // Mettre à jour le nom et le titre dans la carte de profil
        document.getElementById("profile-name").textContent = document.getElementById("nom").value;
        document.getElementById("profile-title").textContent = document.getElementById("titre").value;
        
        // Mettre à jour les initiales
        updateProfileInitials();
        
        // Mettre à jour le header utilisateur
        const userName = document.querySelector('.user-name');
        if (userName) {
            userName.textContent = document.getElementById("nom").value;
        }
        
        const userFullname = document.querySelector('.user-fullname');
        if (userFullname) {
            const nom = document.getElementById("nom").value;
            const prenom = document.getElementById("prenom") ? document.getElementById("prenom").value : "";
            userFullname.textContent = `${nom} ${prenom}`.trim();
        }
        
        const userInitials = document.querySelector('.user-avatar span');
        if (userInitials) {
            userInitials.textContent = getInitials(document.getElementById("nom").value);
        }
    }
    
    function updateProfileInitials() {
        const nom = document.getElementById("nom").value || "";
        const initials = getInitials(nom);
        document.getElementById("profile-initials").textContent = initials;
    }
    
    function getInitials(fullName) {
        const parts = fullName.split(' ');
        let initials = '';
        
        if (parts.length >= 2) {
            initials = parts[0].charAt(0) + parts[1].charAt(0);
        } else if (parts.length === 1 && parts[0].length > 0) {
            initials = parts[0].charAt(0);
        }
        
        return initials.toUpperCase();
    }
    
    function saveFormState() {
        // Sauvegarder l'état actuel du formulaire dans le localStorage
        const formState = {};
        document.querySelectorAll(".form-control").forEach((input) => {
            formState[input.id] = input.value;
        });
        
        localStorage.setItem('coordonneesFormState', JSON.stringify(formState));
    }
    
    function loadSavedValues() {
        // Charger les valeurs sauvegardées depuis le localStorage
        const savedState = localStorage.getItem('coordonneesFormState');
        if (savedState) {
            try {
                const formState = JSON.parse(savedState);
                const inputs = document.querySelectorAll(".form-control");
                
                inputs.forEach((input) => {
                    if (formState[input.id]) {
                        input.value = formState[input.id];
                        currentValues[input.id] = formState[input.id];
                        originalValues[input.id] = formState[input.id];
                    }
                });
                
                // Mettre à jour l'affichage du profil avec les valeurs chargées
                updateProfileDisplay();
            } catch (e) {
                console.error("Erreur lors du chargement des données sauvegardées:", e);
            }
        }
    }
});
    </script>
</body>
</html>
