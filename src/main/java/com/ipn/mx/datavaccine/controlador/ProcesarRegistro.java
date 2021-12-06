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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProcearRegistro</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProcearRegistro at " + request.getContextPath() + "</h1>");
            out.println(request.getParameter("correo"));
            out.println(request.getParameter("contrasena"));
            out.println(request.getParameter("contrasena2"));
            out.println(request.getParameter("nombre"));
            out.println(request.getParameter("paterno"));
            out.println(request.getParameter("materno"));
            out.println(request.getParameter("edad"));
            out.println(request.getParameter("genero"));
            out.println(request.getParameter("folio"));
            out.println(request.getParameter("altura"));
            out.println(request.getParameter("peso"));
            out.println(request.getParameter("grupoSanguineo"));
            out.println(request.getParameter("alergias"));
            
            UsuarioDAO daoUsuario = new UsuarioDAO();
            UsuarioDTO dtoUsuario = new UsuarioDTO();
            
            dtoUsuario.getEntidad().setNombreUsuario(request.getParameter("nombre"));
            dtoUsuario.getEntidad().setPaterno(request.getParameter("paterno"));
            dtoUsuario.getEntidad().setMaterno(request.getParameter("materno"));
            dtoUsuario.getEntidad().setGenero(request.getParameter("genero"));
            dtoUsuario.getEntidad().setEdad(Integer.parseInt(request.getParameter("edad")));
            dtoUsuario.getEntidad().setCorreo(request.getParameter("correo"));
            dtoUsuario.getEntidad().setContrasena(request.getParameter("contrasena"));
            dtoUsuario.getEntidad().setFolio(request.getParameter("folio"));
            dtoUsuario.getEntidad().setAltura(Float.parseFloat(request.getParameter("altura")));
            dtoUsuario.getEntidad().setPeso(Float.parseFloat(request.getParameter("peso")));
            dtoUsuario.getEntidad().setAlergias(request.getParameter("grupoSanguineo"));
            dtoUsuario.getEntidad().setGrupoSanguineo(request.getParameter("alergias"));
            
            System.out.println(dtoUsuario.getEntidad().toString());
            
            try {
                daoUsuario.create(dtoUsuario);
                //request.setAttribute("msj", "Cuenta registrada con exito, ahora puedes iniciar sesion");
                response.sendRedirect("iniciarSesion.jsp");
                
            } catch (SQLException ex) {
                Logger.getLogger(ProcesarRegistro.class.getName()).log(Level.SEVERE, null, ex);
            }

            

            out.println("</body>");
            out.println("</html>");
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
