/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ipn.mx.datavaccine.controlador;

import com.ipn.mx.datavaccine.dao.UsuarioDAO;
import com.ipn.mx.datavaccine.dto.UsuarioDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author caleb
 */
@WebServlet(name = "ProcesarRegistro", urlPatterns = {"/ProcesarRegistro"})
public class ProcesarRegistro extends HttpServlet {

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
        //response.sendRedirect("crearCuenta.jsp");
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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            request.setCharacterEncoding("UTF-8");
            
            
            UsuarioDAO daoUsuario = new UsuarioDAO();
            UsuarioDTO dtoUsuario = new UsuarioDTO();
            
            dtoUsuario.getEntidad().setNombreUsuario(request.getParameter("nombre"));
            dtoUsuario.getEntidad().setPaterno(request.getParameter("paterno"));
            dtoUsuario.getEntidad().setMaterno(request.getParameter("materno"));
            dtoUsuario.getEntidad().setGenero(request.getParameter("genero"));
            dtoUsuario.getEntidad().setEdad(Integer.parseInt(request.getParameter("edad")));
            dtoUsuario.getEntidad().setCorreo(request.getParameter("correo"));
            dtoUsuario.getEntidad().setContrasena(request.getParameter("contrasena"));
            dtoUsuario.getEntidad().setFolio(request.getParameter("folio").equals("") ? null : request.getParameter("folio"));
            dtoUsuario.getEntidad().setAltura(Float.parseFloat(request.getParameter("altura")));
            dtoUsuario.getEntidad().setPeso(Float.parseFloat(request.getParameter("peso")));
            dtoUsuario.getEntidad().setAlergias(request.getParameter("alergias"));
            dtoUsuario.getEntidad().setGrupoSanguineo(request.getParameter("grupoSanguineo"));
            
            
            
            System.out.println(dtoUsuario.getEntidad().toString());
            
            try {
                daoUsuario.create(dtoUsuario);
                //request.setAttribute("msj", "Cuenta registrada con exito, ahora puedes iniciar sesion");
                response.sendRedirect("iniciarSesion.jsp");
                
            } catch (SQLException ex) {
                Logger.getLogger(ProcesarRegistro.class.getName()).log(Level.SEVERE, null, ex);
            }

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
