package com.eadn.controller;

import com.eadn.entity.Ressource;
import com.eadn.service.RessourceService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.text.SimpleDateFormat;

@WebServlet("/ressource/update")
public class UpdateRessourceServlet  extends HttpServlet {

    @Inject
    private RessourceService service;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Long id = Long.parseLong(req.getParameter("id"));
            Ressource r = service.findById(id);

            if (r != null) {
                r.setCode(req.getParameter("code"));
                r.setNom(req.getParameter("nom"));
                r.setIdentite(req.getParameter("identite"));
                r.setQualification(req.getParameter("qualification"));
                r.setNationalite(req.getParameter("nationalite"));
                r.setGenre(req.getParameter("genre"));
                r.setPoste(req.getParameter("poste"));
                r.setTelephone(req.getParameter("telephone"));
                r.setEmail(req.getParameter("email"));
                r.setSalaire(Double.parseDouble(req.getParameter("salaire")));
                r.setBranche(req.getParameter("branche"));
                r.setAdresse(req.getParameter("adresse"));
                r.setContrat(req.getParameter("contrat"));

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                r.setDateNaissance(sdf.parse(req.getParameter("dateNaissance")));
                r.setDateDebut(sdf.parse(req.getParameter("dateDebut")));
                r.setDateFin(sdf.parse(req.getParameter("dateFin")));

                service.update(r);
            }

            resp.sendRedirect(req.getContextPath() + "/views/listeRessources.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "Erreur lors de la mise à jour.");
            req.getRequestDispatcher("/views/editRessource.jsp").forward(req, resp);
        }
    }
}
