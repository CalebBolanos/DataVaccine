/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ipn.mx.datavaccine.controlador.usuario;

import com.ipn.mx.datavaccine.dao.Vacunadao;
import com.ipn.mx.datavaccine.dto.UsuarioDTO;
import com.ipn.mx.datavaccine.entidades.Publicacion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(name = "ProcesarPublicacion", urlPatterns = {"/usr/vacunas/ProcesarPublicacion"})
public class ProcesarPublicacion extends HttpServlet {

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
        try {
            processRequest(request, response);
            java.util.Date date = new java.util.Date();
            java.sql.Date sqlDate = new Date(date.getTime());
            
            HttpSession sesionUsuario = request.getSession();
            UsuarioDTO dtoUsuario = (UsuarioDTO) sesionUsuario.getAttribute("dtoUsuario");
            
            Publicacion publicacion = new Publicacion();
            
            publicacion.setIdVacuna(Integer.parseInt(request.getParameter("idVacuna")));
            publicacion.setNombreUsuario(dtoUsuario.getEntidad().getNombreUsuario());
            publicacion.setTitulo(request.getParameter("titulo"));
            publicacion.setMensaje(request.getParameter("mensaje"));
            publicacion.setImagen("");
            publicacion.setFecha(sqlDate);
            
            Vacunadao daoVacuna = new Vacunadao();
            
            if(daoVacuna.guardarPublicacion(publicacion)){
                response.sendRedirect("vacuna?x="+request.getParameter("idVacuna")+"&link=2");
            }else{
                response.sendRedirect("../listaVacunas");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProcesarPublicacion.class.getName()).log(Level.SEVERE, null, ex);
        }
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
