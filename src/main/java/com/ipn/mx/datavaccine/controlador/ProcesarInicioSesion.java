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
import javax.servlet.http.HttpSession;

/**
 *
 * @author caleb
 */
@WebServlet(name = "ProcesarInicioSesion", urlPatterns = {"/ProcesarInicioSesion"})
public class ProcesarInicioSesion extends HttpServlet {

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
        response.sendRedirect("index.html");
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

        if (!request.getParameter("usuario").equals("") && !request.getParameter("contrasena").equals("")) {
            String correoUsuario = new String(request.getParameter("usuario").getBytes(), "UTF-8");
            String contrasena = new String(request.getParameter("contrasena").getBytes(), "UTF-8");

            System.out.println(correoUsuario);
            System.out.println(contrasena);

            //en esta parte hacer la consulta del dao y dto para obtener todos los datos del usuario
            UsuarioDAO daoUsuario = new UsuarioDAO();
            UsuarioDTO dtoUsuario = new UsuarioDTO();

            dtoUsuario.getEntidad().setCorreo(request.getParameter("usuario"));
            dtoUsuario.getEntidad().setContrasena(request.getParameter("contrasena"));

            try {
                int idUsuario = daoUsuario.iniciarSesion(dtoUsuario);
                if (idUsuario > 0) {
                    dtoUsuario.getEntidad().setIdUsuario(idUsuario);
                    dtoUsuario = daoUsuario.read(dtoUsuario);
                    
                    
                    System.out.println(dtoUsuario);
                    
                    HttpSession sesion = request.getSession();

                    sesion.setAttribute("correo", correoUsuario);
                    sesion.setAttribute("dtoUsuario", dtoUsuario);

                    response.sendRedirect("./usr/inicio");
                } else {
                    response.sendRedirect("iniciarSesion.jsp?msg=o");
                }
            } catch (SQLException ex) {
                Logger.getLogger(ProcesarInicioSesion.class.getName()).log(Level.SEVERE, null, ex);
            }

        } else {
            response.sendRedirect("iniciarSesion.jsp?msg=a");
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
