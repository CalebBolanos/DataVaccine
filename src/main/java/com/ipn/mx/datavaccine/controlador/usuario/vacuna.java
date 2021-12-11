/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ipn.mx.datavaccine.controlador.usuario;

import com.ipn.mx.datavaccine.dao.UsuarioDAO;
import com.ipn.mx.datavaccine.dao.Vacunadao;
import com.ipn.mx.datavaccine.dto.UsuarioDTO;
import com.ipn.mx.datavaccine.dto.VacunaDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author caleb
 */
@WebServlet(name = "vacuna", urlPatterns = {"/usr/vacunas/vacuna"})
public class vacuna extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession sesion = request.getSession();
        if (sesion.getAttribute("correo") == null) {
            response.sendRedirect("../../iniciarSesion.jsp");
            return;
        }

        try {
            String vacuna = new String(request.getParameter("x").getBytes(), "UTF-8");

            if (vacuna.equals("")) {
                response.sendRedirect("../listaVacunas");
            }
            //parte en donde se obtiene info de la vacuna
            Vacunadao daoVacuna = new Vacunadao();
            VacunaDTO dtoVacuna = new VacunaDTO();

            dtoVacuna.getEntidadVacuna().setIdVacuna(Integer.parseInt(vacuna));

            dtoVacuna = daoVacuna.read(dtoVacuna);
            
            //parte en donde se obtienen los mensajes del foro
            List mensajesForo = daoVacuna.obtenerMensajes(Integer.parseInt(vacuna));
            
//            for(int i = 0; i<mensajesForo.size(); i++){
//                System.out.println(mensajesForo.get(i));
//            }
            
            //parte en donde se obtienen las reacciones adversas
            
            
            UsuarioDAO daoUsuario = new UsuarioDAO();
            UsuarioDTO dtoUsuario = (UsuarioDTO) sesion.getAttribute("dtoUsuario");
            
            List resultadosReacciones = daoUsuario.calcularReaccionesAdversas(dtoUsuario);
            
            for(int i = 0; i<resultadosReacciones.size(); i++){
                System.out.println(resultadosReacciones.get(i));
            }
            
            //hacer switch de vacuna y en funcion a las vacunas que existan dentro de la base de datos obtener su info
            request.setAttribute("nombreVacuna", dtoVacuna.getEntidadVacuna().getNombreVacuna());
            request.setAttribute("datosVacuna", dtoVacuna);
            request.setAttribute("mensajesForo", mensajesForo);
            request.setAttribute("reaccionesAdversas", resultadosReacciones);

            RequestDispatcher rd = request.getRequestDispatcher("vacunax.jsp");
            rd.forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(vacuna.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
