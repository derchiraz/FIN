<%-- 
    Document   : editOpportunite
    Created on : 13 avr. 2025, 22:43:23
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
    <title>Modifier une Opportunité</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/projet.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css ">
    <style>
    .membre-row {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-top: 10px;
    }

    .btn-remove {
        background-color: #e74c3c;
        color: white;
        border: none;
        padding: 6px 10px;
        border-radius: 5px;
        cursor: pointer;
    }

    .btn-remove:hover {
        background-color: #c0392b;
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
                        <a href="#" class="nav-item has-submenu " id="project-menu">
                            <i class="fas fa-project-diagram"></i>
                            <span>Projets</span>
                            <i class="fas fa-chevron-right submenu-icon"></i>
                        </a>
                        <ul class="submenu " id="project-submenu">
                            <li>
                                <a href="${pageContext.request.contextPath}/load-form-data?page=projet">
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
                        <a href="#" class="nav-item has-submenu active" id="opportunite-menu">
                            <i class="fas fa-lightbulb"></i>
                            <span>Opportunités</span>
                            <i class="fas fa-chevron-right submenu-icon"></i>
                        </a>
                        <ul class="submenu show" id="opportunite-submenu">
                            <li>
                                <a href="${pageContext.request.contextPath}/load-form-data?page=opportunite">
                                    <i class="fas fa-plus-circle"></i> Ajouter opportunité
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/opportunite/liste" class="active">
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
                        <a href="${pageContext.request.contextPath}/opportunite/liste">Liste des opportunités</a> / 
                        <span>Modifier une opportunité</span>
                    </div>
                    <div class="header-top">
                        <h1>Modifier une Opportunité</h1>
                        <div class="header-actions">
                            <button class="btn-action" onclick="location.href='${pageContext.request.contextPath}/opportunite/liste'">
                                <span class="icon"><i class="fas fa-list"></i></span> Liste des Opportunités
                            </button>
                            <button class="btn-action" onclick="location.href='${pageContext.request.contextPath}/opportunite/details?id=${opportunite.id}'">
                                <span class="icon"><i class="fas fa-eye"></i></span> Voir les détails
                            </button>
                        </div>
                    </div>
                    <div class="header-divider"></div>
                </div>
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                    </div>
                </c:if>
                <form action="${pageContext.request.contextPath}/opportunite/update" method="post" onsubmit="return validateForm(event)">
                    <input type="hidden" name="id" value="${opportunite.id}">
                    <div class="form-container">
                        <div class="form-section">
                            <h4 class="section-title">Informations sur le Client</h4>
                            <div class="input-group">
                                <label for="nom_entreprise">Nom entreprise</label>
                                <input type="text" id="nom_entreprise" name="nom_entreprise" class="form-control" 
                                      placeholder="Entrez le nom de l'entreprise" value="${opportunite.nom_entreprise}" required>
                            </div>
                            <div class="input-group">
                                <label for="nom_contact">Nom du contact principal</label>
                                <input type="text" id="nom_contact" name="nom_contact" class="form-control" 
                                      placeholder="Nom et prénom du contact" value="${opportunite.nom_contact}" required>
                            </div>
                            <div class="input-group">
                                <label for="telephone">Téléphone</label>
                                <input type="text" id="telephone" name="telephone" class="form-control" 
                                      placeholder="Numéro de téléphone" value="${opportunite.telephone}">
                            </div>
                            <div class="input-group">
                                <label for="email">Email</label>
                                <input type="email" id="email" name="email" class="form-control" 
                                      placeholder="Adresse email du contact" value="${opportunite.email}">
                            </div>
                            <div class="input-group">
                                <label for="adresse">Adresse</label>
                                <input type="text" id="adresse" name="adresse" class="form-control" 
                                      placeholder="Adresse complète" value="${opportunite.adresse}">
                            </div>
                        </div>
                        <div class="form-section">
                            <h4 class="section-title">Détails de l'Opportunité</h4>
                            <div class="input-group">
                                <label for="nom_opportunite">Nom opportunité</label>
                                <input type="text" id="nom_opportunite" name="nom_opportunite" class="form-control" 
                                      placeholder="Nom descriptif de l'opportunité" value="${opportunite.nom_opportunite}" required>
                            </div>
                            <div class="input-group">
                                <label for="description_opportunite">Description de l'opportunité</label>
                                <textarea id="description_opportunite" name="description_opportunite" class="form-control" 
                                         placeholder="Décrivez l'opportunité..." required>${opportunite.description_opportunite}</textarea>
                            </div>
                            <div class="input-group">
                                <label for="budget_estime">Budget estimé (DA)</label>
                                <input type="number" id="budget_estime" name="budget_estime" class="form-control" 
                                      placeholder="Montant..." value="${opportunite.budget_estime}" required>
                            </div>
                            <div class="input-group">
                                <label for="status">Status</label>
                                <select id="status" name="status" class="form-control" required>
                                    <option value="">Sélectionnez un status</option>
                                    <option value="enCours" ${opportunite.status == 'enCours' ? 'selected' : ''}>En cours</option>
                                    <option value="terminee" ${opportunite.status == 'terminee' ? 'selected' : ''}>Terminée</option>
                                    <option value="enAttente" ${opportunite.status == 'enAttente' ? 'selected' : ''}>En attente</option>
                                    <option value="cloturee" ${opportunite.status == 'cloturee' ? 'selected' : ''}>Clôturée</option>
                                </select>
                            </div>
                            
                            
                        </div>
                    </div>
                    <div class="form-container">
                        <div class="form-section">
                            <h4 class="section-title">Planification</h4>
                            <div class="input-group">
                                <label for="dateDebut">Date de début</label>
                                <div class="date-input-wrapper">
                                    <input type="date" id="dateDebut" name="dateDebut" class="form-control" 
                                           value="<fmt:formatDate value="${opportunite.dateDebut}" pattern="yyyy-MM-dd"/>" required>
                                </div>
                            </div>
                            <div class="input-group">
                                <label for="dateFin">Date de fin</label>
                                <div class="date-input-wrapper">
                                    <input type="date" id="dateFin" name="dateFin" class="form-control" 
                                           value="<fmt:formatDate value="${opportunite.dateFin}" pattern="yyyy-MM-dd"/>" required>
                                </div>
                            </div>
                            <div class="input-group">
                                <label for="objectifs_principaux">Objectifs principaux</label>
                                <textarea id="objectifs_principaux" name="objectifs_principaux" class="form-control" 
                                         placeholder="Objectifs de l'opportunité...">${opportunite.objectifs_principaux}</textarea>
                            </div>
                            <div id="error-message" class="error-message">
                                <i class="fas fa-exclamation-triangle"></i> La date de fin doit être après la date de début.
                            </div>
                        </div>
                        <div class="form-section">
                            <h4 class="section-title">Architecture</h4>
                            <div class="input-group">
                                <label for="description_architecture">Description de l'architecture</label>
                                <textarea id="description_architecture" name="description_architecture" class="form-control" 
                                         placeholder="Décrivez l'architecture technique...">${opportunite.description_architecture}</textarea>
                            </div>
                            <div class="file-upload">
                                <label for="fileInput" class="file-label">Joindre un fichier</label>
                                <input type="file" id="fileInput" name="file" class="form-control-file">
                                <small class="text-muted">Formats acceptés: PDF, DOC, DOCX, PPT, PPTX, XLS, XLSX</small>
                            </div>
                            
                        </div>
                    </div>
                    <div class="form-container">
                        <div class="form-section">
                            <h4 class="section-title">Suivi Interne</h4>
                            <!-- Responsable -->
                            <div class="input-group">
                                <label for="responsable">Responsable du projet</label>
                                <select id="responsable" name="responsable" class="form-control" required>
                                    <option value="">Choisir...</option>
                                    <c:forEach var="utilisateur" items="${utilisateurs}">
                                        <option value="${utilisateur.id}">${utilisateur.nom} ${utilisateur.prenom}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Membres dynamiques -->
                            <div id="membres-wrapper">
                                <label for="responsable">Membres du projet</label>
                                <div id="membre-template" style="display: none;">
                                <div class="membre-row input-group">
                                    <select name="membres" class="form-control">
                                        <option value="">Choisir...</option>
                                        <c:forEach var="utilisateur" items="${utilisateurs}">
                                            <option value="${utilisateur.id}">${utilisateur.nom} ${utilisateur.prenom}</option>
                                        </c:forEach>
                                    </select>
                                    <button type="button" class="btn-remove" onclick="removeMembre(this)">−</button>
                                </div>
                            </div>
                            </div>

                            <button type="button" class="btn-secondary" onclick="addMembre()">+ Ajouter un membre</button>
                        </div>
                    </div>
                    <div class="btn-container">
                        <button type="button" class="btn-secondary" onclick="history.back()">Annuler</button>
                        <button type="submit" class="btn-primary">
                            <i class="fas fa-save"></i> Mettre à jour
                        </button>
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
                <div class="toast-message">L'opportunité a été mise à jour avec succès.</div>
            </div>
            <button class="toast-close">
                <i class="fas fa-times"></i>
            </button>
        </div>
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Afficher le message de succès s'il existe
            <c:if test="${not empty successMessage}">
                document.getElementById('toast-success').classList.add('show');
                setTimeout(() => {
                    document.getElementById('toast-success').classList.remove('show');
                }, 5000);
            </c:if>
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
            // Masquer le message d'erreur par défaut
            const errorMessage = document.getElementById('error-message');
            if (errorMessage) {
                errorMessage.style.display = 'none';
            }
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
            // Toast notification
            const toast = document.getElementById('toast-success');
            const toastClose = document.querySelector('.toast-close');
            if (toastClose) {
                toastClose.addEventListener('click', function() {
                    toast.classList.remove('show');
                });
            }
            // Gestion des fichiers
            const fileInput = document.getElementById('fileInput');
            if (fileInput) {
                fileInput.addEventListener('change', function(event) {
                    let fileList = document.getElementById('fileList');
                    fileList.innerHTML = ''; // Vider la liste avant d'ajouter les nouveaux fichiers
                    Array.from(event.target.files).forEach((file, index) => {
                        let fileItem = document.createElement('div');
                        fileItem.classList.add('file-item');
                        fileItem.innerHTML = `
                            <span class="file-icon">📄</span>
                            <span class="file-name">${file.name}</span>
                            <button type="button" class="remove-file" onclick="removeFile(${index})">❌</button>
                        `;
                        fileList.appendChild(fileItem);
                    });
                });
            }
        });
        function removeFile(index) {
            let fileInput = document.getElementById('fileInput');
            if (fileInput && fileInput.files.length > 0) {
                let dataTransfer = new DataTransfer();
                Array.from(fileInput.files).forEach((file, i) => {
                    if (i !== index) {
                        dataTransfer.items.add(file);
                    }
                });
                fileInput.files = dataTransfer.files;
                // Rafraîchir la liste affichée
                document.getElementById('fileInput').dispatchEvent(new Event('change'));
            }
        }
        function validateForm(event) {
            const startDate = document.getElementById("date_debut").value;
            const endDate = document.getElementById("date_fin").value;
            const errorMessage = document.getElementById("error-message");
            const inputs = document.querySelectorAll("input[required], select[required], textarea[required]");
            let allFilled = true;
            inputs.forEach((input) => {
                if (input.value.trim() === "") {
                    allFilled = false;
                    input.classList.add('error');
                    // Ajouter animation de secouement
                    input.classList.add('shake');
                    setTimeout(() => input.classList.remove('shake'), 500);
                } else {
                    input.classList.remove('error');
                }
            });
            if (!allFilled) {
                event.preventDefault();
                return false;
            }
            if (endDate && startDate && startDate > endDate) {
                errorMessage.style.display = "block";
                // Ajouter animation
                errorMessage.classList.add('shake');
                setTimeout(() => errorMessage.classList.remove('shake'), 500);
                event.preventDefault();
                return false;
            } else {
                errorMessage.style.display = "none";
            }
            return true;
        }
        function addMembre() {
    const wrapper = document.getElementById("membres-wrapper");
    const template = document.querySelector("#membre-template .membre-row");

    // Cloner le contenu du modèle
    const newMembre = template.cloneNode(true);
    wrapper.appendChild(newMembre);
}

        function removeMembre(button) {
            const row = button.closest('.membre-row');
            row.remove();
        }

    </script>
</body>
</html>