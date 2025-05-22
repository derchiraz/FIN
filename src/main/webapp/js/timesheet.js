/**
 * Timesheet.js - Corrections pour la gestion des timesheets
 */

// Variables globales
let contextPath;
document.addEventListener('DOMContentLoaded', function() {
    // Récupérer le chemin de contexte
    const contextPathInput = document.getElementById('contextPath');
    if (contextPathInput) {
        contextPath = contextPathInput.value;
    }
    
    // Initialisation du timesheet
    updateWeekDisplay();
    calculateTotals();
    loadSavedData(); // Charger les données sauvegardées

    // Sidebar toggle et autres initialisations UI (code existant)
    const sidebarToggle = document.createElement('button');
    sidebarToggle.classList.add('sidebar-toggle');
    sidebarToggle.innerHTML = '<i class="fas fa-bars"></i>';
    const mainHeader = document.querySelector('.main-header');
    if (mainHeader) {
        mainHeader.prepend(sidebarToggle);
    }

    if (sidebarToggle) {
        sidebarToggle.addEventListener('click', function() {
            document.body.classList.toggle('sidebar-open');
        });
    }
     document.querySelectorAll('.hours-input').forEach(input => {
        input.addEventListener('change', function() {
            saveCurrentData();
        });
    });
    
    // Sauvegarde avant navigation
    document.querySelectorAll('.btn-nav, #current-week').forEach(navButton => {
        navButton.addEventListener('click', function() {
            saveCurrentData();
        });
    });
    

    // Reste du code existant...
});

/**
 * Charge les données du timesheet pour la semaine actuelle depuis le stockage local
 * et depuis les attributs data- des éléments de la page
 */
function loadSavedTimesheetData() {
    // 1. Chargement depuis les attributs data-* pour les données initiales fournies par le serveur
    const rows = document.querySelectorAll('#timesheetBody tr');
    rows.forEach(row => {
        const projectSelect = row.querySelector('.project-input');
        const roleSelect = row.querySelector('.role-input');
        
        if (projectSelect && projectSelect.value) {
            // Un projet est sélectionné, mettre à jour les noms des champs
            updateProjectDetails(projectSelect);
            
            // Vérifier si le rôle a une valeur par défaut (depuis le serveur)
            if (roleSelect.getAttribute('data-default-value')) {
                roleSelect.value = roleSelect.getAttribute('data-default-value');
            }
        }
        
        // Pour chaque ligne, vérifier si des valeurs par défaut sont définies dans des attributs data-*
        const inputs = row.querySelectorAll('.hours-input');
        inputs.forEach(input => {
            const defaultValue = input.getAttribute('data-default-value');
            if (defaultValue) {
                input.value = defaultValue;
            }
        });
    });
    
    // 2. Recalculer les totaux après chargement des données
    calculateTotals();
}

// Navigue vers une date spécifique
function navigateToDate(dateStr) {
    if (!dateStr) return;
    
    // Mise à jour immédiate de l'affichage avant redirection
    const weekSelector = document.getElementById('weekSelector');
    if (weekSelector) {
        weekSelector.value = dateStr;
        updateWeekDisplay(); // Met à jour l'affichage immédiatement
    }
    
    // Construit l'URL avec le bon chemin contextuel
    let baseUrl;
    if (contextPath && contextPath !== '/') {
        baseUrl = contextPath + '/timesheet/view';
    } else {
        baseUrl = '/timesheet/view';
    }
    
    // Redirection avec la nouvelle date
    window.location.href = baseUrl + '?dateDebut=' + dateStr;
}

// Initialise le sélecteur de semaine pour afficher le lundi de la semaine courante
function initializeWeekSelector() {
    const weekSelector = document.getElementById('weekSelector');
    if (!weekSelector) return;

    // Vérifie d'abord si une date est présente dans l'URL ou définie comme valeur par défaut
    const urlParams = new URLSearchParams(window.location.search);
    const dateParam = urlParams.get('dateDebut');
    const dateDebutField = document.querySelector('input[name="dateDebut"]');
    
    if (dateParam) {
        // Date fournie dans l'URL
        weekSelector.value = dateParam;
        if (dateDebutField) {
            dateDebutField.value = dateParam;
        }
    } else if (dateDebutField && dateDebutField.value) {
        // Date fournie par le serveur via un champ caché
        weekSelector.value = dateDebutField.value;
    } else {
        // Aucune date fournie, utiliser la date courante
        const today = new Date();
        // Définir au lundi de la semaine courante
        const firstDayOfWeek = new Date(today);
        const day = firstDayOfWeek.getDay();
        const diff = firstDayOfWeek.getDate() - day + (day === 0 ? -6 : 1);
        firstDayOfWeek.setDate(diff);

        const dateString = firstDayOfWeek.toISOString().split('T')[0];
        weekSelector.value = dateString;
        
        // Mettre à jour le champ caché dateDebut
        if (dateDebutField) {
            dateDebutField.value = dateString;
        }
    }
}

/**
 * Naviguer vers la semaine courante
 */
function goToCurrentWeek() {
    // Obtenir la date du lundi de la semaine courante
    const today = new Date();
    const day = today.getDay();
    const diff = today.getDate() - day + (day === 0 ? -6 : 1); // Ajuster quand aujourd'hui est dimanche
    const monday = new Date(today.setDate(diff));
    
    // Format YYYY-MM-DD
    const formattedDate = monday.toISOString().split('T')[0];
    
    // Redirection vers l'URL avec la date du lundi
    if (contextPath) {
        window.location.href = contextPath + '/timesheet/view?dateDebut=' + formattedDate;
    } else {
        window.location.href = '/timesheet/view?dateDebut=' + formattedDate;
    }
}
// Updates the entire week display
function updateWeekDisplay() {
    const weekSelector = document.getElementById('weekSelector');
    if (!weekSelector) return;
    const selectedDate = new Date(weekSelector.value);
    const weekStart = new Date(selectedDate);
    const day = weekStart.getDay();
    const diff = weekStart.getDate() - day + (day === 0 ? -6 : 1);
    weekStart.setDate(diff);
    updateHeaderDates(weekStart);
    updateTableDates(weekStart);
    updateWeekRange(weekStart);
}
// Updates the day headers (e.g., "01 Lun")
function updateHeaderDates(weekStart) {
    const headers = document.querySelectorAll('.day-header');
    const days = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
    headers.forEach((header, index) => {
        const date = new Date(weekStart);
        date.setDate(date.getDate() + index);
        header.textContent = `${date.getDate().toString().padStart(2, '0')} ${days[index]}`;
    });
}
// Updates the week range display
function updateWeekRange(weekStart) {
    const weekRange = document.getElementById('weekRange');
    if (!weekRange) return;
    const weekEnd = new Date(weekStart);
    weekEnd.setDate(weekEnd.getDate() + 6);
    const startMonth = weekStart.getMonth() + 1;
    const endMonth = weekEnd.getMonth() + 1;
    const startDay = weekStart.getDate();
    const endDay = weekEnd.getDate();
    weekRange.textContent = `${startDay.toString().padStart(2, '0')}/${startMonth.toString().padStart(2, '0')} - ${endDay.toString().padStart(2, '0')}/${endMonth.toString().padStart(2, '0')}/${weekEnd.getFullYear()}`;
}
// Fonction modifiée pour conserver les valeurs lors des changements de date
function updateTableDates(weekStart) {
    const rows = document.querySelectorAll('#timesheetBody tr');
    rows.forEach(row => {
        const inputs = row.querySelectorAll('.hours-input');
        inputs.forEach((input, index) => {
            const date = new Date(weekStart);
            date.setDate(date.getDate() + index);
            
            // IMPORTANT: Conserver la valeur actuelle avant de mettre à jour l'attribut
            const currentValue = input.value;
            
            input.setAttribute('data-date', date.toISOString().split('T')[0]);
            input.placeholder = 'hh:mm';
            
            // IMPORTANT: S'assurer que la valeur n'est pas perdue lors de la mise à jour
            if (currentValue) {
                input.value = currentValue;
            }
        });
    });
    calculateTotals();
}

/**
 * Gets the Monday of the currently selected week from the weekSelector.
 */
function getWeekStart() {
    const weekSelector = document.getElementById('weekSelector');
    const selectedDate = weekSelector ? new Date(weekSelector.value) : new Date();
    const weekStart = new Date(selectedDate);
    const day = weekStart.getDay(); // 0 for Sunday, 1 for Monday, ..., 6 for Saturday
    const diff = weekStart.getDate() - day + (day === 0 ? -6 : 1); // Adjust to Monday
    weekStart.setDate(diff);
    return weekStart;
}
// Fonction modifiée pour conserver les valeurs lors des changements de projet
function updateProjectDetails(select) {
    const row = select.closest('tr');
    if (!row) return;
    // Rename the time inputs to include the project ID
    const projectId = select.value;
    if (projectId) {
        const inputs = row.querySelectorAll('.hours-input');
        const days = ['lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi', 'dimanche'];
        inputs.forEach((input, index) => {
            if (projectId) {
                // IMPORTANT: Sauvegarder la valeur actuelle
                const currentValue = input.value;
                input.name = days[index] + '_' + projectId;
                // IMPORTANT: Restaurer la valeur
                input.value = currentValue;
            } else {
                input.name = days[index];
            }
        });
    }
}
// Ajoutez cette fonction pour sauvegarder les données en mémoire locale
function saveCurrentData() {
    const timesheetData = {
        weekStart: document.getElementById('weekSelector').value,
        rows: []
    };
    
    const rows = document.querySelectorAll('#timesheetBody tr');
    rows.forEach(row => {
        const projectSelect = row.querySelector('.project-input');
        const roleSelect = row.querySelector('.role-input');
        const inputs = row.querySelectorAll('.hours-input');
        
        const rowData = {
            projectId: projectSelect ? projectSelect.value : '',
            role: roleSelect ? roleSelect.value : '',
            hours: []
        };
        
        inputs.forEach(input => {
            rowData.hours.push(input.value || '');
        });
        
        timesheetData.rows.push(rowData);
    });
    
    // Sauvegarder dans localStorage
    localStorage.setItem('timesheetData', JSON.stringify(timesheetData));
}
// Ajoutez cette fonction pour charger les données depuis la mémoire locale
function loadSavedData() {
    const savedData = localStorage.getItem('timesheetData');
    if (!savedData) return;
    
    try {
        const timesheetData = JSON.parse(savedData);
        const currentWeek = document.getElementById('weekSelector').value;
        
        // Ne charger que si c'est la même semaine
        if (timesheetData.weekStart === currentWeek) {
            const rows = document.querySelectorAll('#timesheetBody tr');
            
            // S'il n'y a pas assez de lignes, en ajouter
            while (rows.length < timesheetData.rows.length) {
                addNewRow();
            }
            
            // Mettre à jour les données dans chaque ligne
            const updatedRows = document.querySelectorAll('#timesheetBody tr');
            timesheetData.rows.forEach((rowData, rowIndex) => {
                if (rowIndex < updatedRows.length) {
                    const row = updatedRows[rowIndex];
                    const projectSelect = row.querySelector('.project-input');
                    const roleSelect = row.querySelector('.role-input');
                    const inputs = row.querySelectorAll('.hours-input');
                    
                    if (projectSelect && rowData.projectId) {
                        projectSelect.value = rowData.projectId;
                        updateProjectDetails(projectSelect);
                    }
                    
                    if (roleSelect && rowData.role) {
                        roleSelect.value = rowData.role;
                    }
                    
                    inputs.forEach((input, index) => {
                        if (index < rowData.hours.length) {
                            input.value = rowData.hours[index];
                        }
                    });
                }
            });
            
            calculateTotals();
        }
    } catch (e) {
        console.error('Erreur lors du chargement des données sauvegardées', e);
    }
}

// Ajoute une nouvelle ligne au tableau timesheet
function addNewRow() {
    const tbody = document.getElementById('timesheetBody');
    if (!tbody) return;

    const newRow = document.createElement('tr');
    
    // Obtenir la liste des projets du premier select
    const projectSelect = document.querySelector('select.project-input');
    let optionsHtml = '<option value="">Sélectionner un projet</option>';
    
    if (projectSelect) {
        Array.from(projectSelect.options).forEach(option => {
            if (option.value) {
                optionsHtml += `<option value="${option.value}" ${option.dataset.status ? `data-status="${option.dataset.status}"` : ''} ${option.dataset.progress ? `data-progress="${option.dataset.progress}"` : ''}>${option.text}</option>`;
            }
        });
    }
    
    // Récupérer le début de semaine pour les attributs data-date
    const weekStart = getWeekStart();
    
    // Préparer les champs pour les 7 jours
    let daysInputsHtml = '';
    const days = ['lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi', 'dimanche'];
    
    days.forEach((day, index) => {
        const date = new Date(weekStart);
        date.setDate(date.getDate() + index);
        const dateStr = date.toISOString().split('T')[0];
        
        daysInputsHtml += `<td><input type="text" name="${day}" class="hours-input" data-date="${dateStr}" placeholder="hh:mm" pattern="^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$" onchange="updateHours(this)" maxlength="5"></td>`;
    });
    
    newRow.innerHTML = `
        <td>
            <div class="row-actions">
                <button type="button" class="delete-row-btn" onclick="deleteRow(this)">
                    <i class="fas fa-minus"></i>
                </button>
                <select name="projetId" class="project-input" onchange="updateProjectDetails(this)">
                    ${optionsHtml}
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
        ${daysInputsHtml}
        <td class="row-total">00:00</td>
    `;
    
    tbody.appendChild(newRow);
    
    // Animation pour ajouter une ligne
    newRow.classList.add('row-added');
    setTimeout(() => {
        newRow.classList.remove('row-added');
    }, 500);
    
    // Mettre à jour les dates et calculer les totaux
    calculateTotals();
}

// Supprime une ligne du tableau timesheet
function deleteRow(button) {
    const row = button.closest('tr');
    if (!row) return;

    const allRows = document.querySelectorAll('#timesheetBody tr');
    if (allRows.length > 1) {
        // Animation pour supprimer une ligne
        row.classList.add('row-removed');
        setTimeout(() => {
            row.remove();
            calculateTotals();
        }, 300);
    } else {
        // Animation de secousse pour indiquer l'impossibilité de supprimer la dernière ligne
        row.classList.add('shake');
        setTimeout(() => {
            row.classList.remove('shake');
        }, 500);
    }
     setTimeout(() => {
        const newInputs = document.querySelectorAll('#timesheetBody tr:last-child .hours-input');
        newInputs.forEach(input => {
            input.addEventListener('change', function() {
                saveCurrentData();
            });
        });
        saveCurrentData();
    }, 350);

}


// Met à jour les heures dans un champ d'entrée et déclenche le recalcul des totaux
function updateHours(input) {
    const timePattern = /^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$/;
    if (input.value && !timePattern.test(input.value)) {
        input.value = '';
        input.classList.add('input-error');
        setTimeout(() => {
            input.classList.remove('input-error');
        }, 500);
    }
    calculateTotals();
    saveCurrentData(); // Sauvegarder après modification
}
    
    
// Calcule et met à jour tous les totaux
function calculateTotals() {
    const tbody = document.getElementById('timesheetBody');
    if (!tbody) return;

    const rows = tbody.getElementsByTagName('tr');
    const columnTotals = Array(7).fill(0);

    // Calculer les totaux des lignes et accumuler les totaux des colonnes
    Array.from(rows).forEach(row => {
        let rowTotal = 0;
        const inputs = row.getElementsByClassName('hours-input');
        Array.from(inputs).forEach((input, index) => {
            if (input.value) {
                const [hours, minutes] = input.value.split(':').map(Number);
                const decimalHours = hours + minutes / 60;
                rowTotal += decimalHours;
                columnTotals[index] += decimalHours;
            }
        });
        const formattedRowTotal = formatHours(rowTotal);
        const rowTotalElement = row.querySelector('.row-total');
        if (rowTotalElement) {
            rowTotalElement.textContent = formattedRowTotal;
        }
    });

    // Mettre à jour les totaux des colonnes dans le pied de tableau
    const columnTotalElements = document.getElementsByClassName('column-total');
    Array.from(columnTotalElements).forEach((element, index) => {
        if (element) {
            element.textContent = formatHours(columnTotals[index]);
        }
    });

    // Calculer le total général
    let grandTotal = 0;
    columnTotals.forEach(total => {
        grandTotal += total;
    });
    
    const formattedGrandTotal = formatHours(grandTotal);
    const grandTotalElement = document.querySelector('.grand-total');
    if (grandTotalElement) {
        grandTotalElement.textContent = formattedGrandTotal;
    }
}

// Formate un nombre décimal d'heures en chaîne "hh:mm"
function formatHours(hours) {
    const wholeHours = Math.floor(hours);
    const minutes = Math.round((hours - wholeHours) * 60);
    
    // Gestion du cas où les minutes arrondies = 60
    let adjustedHours = wholeHours;
    let adjustedMinutes = minutes;
    
    if (minutes === 60) {
        adjustedHours += 1;
        adjustedMinutes = 0;
    }
    
    return `${adjustedHours.toString().padStart(2, '0')}:${adjustedMinutes.toString().padStart(2, '0')}`;
}


// Réinitialiser le timesheet
function resetTimesheet() {
    if (confirm("Voulez-vous vraiment réinitialiser toutes les données de cette semaine?")) {
        const inputs = document.querySelectorAll('.hours-input');
        inputs.forEach(input => {
            input.value = '';
        });
        calculateTotals();
    }
}

// Sauvegarder le timesheet
function saveTimesheet() {
    const form = document.getElementById('timesheet-form');
    if (form) {
        form.submit();
    }
}

// Soumettre le timesheet pour validation
function submitTimesheet() {
    const form = document.getElementById('timesheet-form');
    if (form) {
        // Ajouter un paramètre pour indiquer la soumission plutôt que la sauvegarde
        const submitInput = document.createElement('input');
        submitInput.type = 'hidden';
        submitInput.name = 'action';
        submitInput.value = 'submit';
        form.appendChild(submitInput);
        
        form.submit();
    }
}