/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ipn.mx.datavaccine.vacunadao;

import com.ipn.mx.datavaccine.vacunadto.Vacunadto;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author edgargarcia
 */
public class Vacunadao {
    
    private String usrBD;
    private String passBD;
    private String urlBD;
    private String driverClassName;
    
    private static final String SQL_INSERT = "insert into Vacunas (nombreVacuna,Descripcion,Logo,Portada,Eficacia,Seguridad,idForo) values (?,?,?,?,?,?,?)";
    private static final String SQL_UPDATE = "update Vacunas set nombreVacuna = ?, Descripcion = ?, Logo = ?, Portada = ?, Eficacia = ?, Seguridad = ? where idVacuna = ?";
    private static final String SQL_DELETE = "delete from Vacunas where idVacuna = ?";
    private static final String SQL_READ = "select idVacuna, nombreVacuna, Descripcion, Logo, Portada, Eficacia, Seguridad, idForo from Vacunas where idVacuna = ?";
    private static final String SQL_READALL = "select idVacuna, nombreVacuna, Descripcion, Logo, Portada, Eficacia, Seguridad, idForo from Vacunas";
    
    private Connection conexion;
    
    private void conectar() {
        usrBD = "root";
        passBD = "12345678";
        urlBD = "jdbc:mysql://localhost:3306/vacunadoo?serverTimezone=UTC";
        driverClassName = "com.mysql.cj.jdbc.Driver";
        try {
            Class.forName(driverClassName);
            conexion = DriverManager.getConnection(urlBD, usrBD, passBD);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void create(Vacunadto dto) throws SQLException {
        conectar();
        PreparedStatement ps = null;
        try {
            ps = conexion.prepareStatement(SQL_INSERT);
            ps.setString(1, dto.getEntidadVacuna().getNombreVacuna());
            ps.setString(2, dto.getEntidadVacuna().getDescripcion());
            ps.setString(3, dto.getEntidadVacuna().getLogo());
            ps.setString(4, dto.getEntidadVacuna().getPortada());
            ps.setString(5, dto.getEntidadVacuna().getEficacia());
            ps.setString(6, dto.getEntidadVacuna().getSeguridad());
            ps.setInt(7, dto.getEntidadVacuna().getIdForo());
            ps.executeLargeUpdate();
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conexion != null) {
                conexion.close();
            }
        }
    }
    
    public void update(Vacunadto dto) throws SQLException {
        conectar();
        PreparedStatement ps = null;
        try {
            ps = conexion.prepareStatement(SQL_UPDATE);
            ps.setString(1, dto.getEntidadVacuna().getNombreVacuna());
            ps.setString(2, dto.getEntidadVacuna().getDescripcion());
            ps.setString(3, dto.getEntidadVacuna().getLogo());
            ps.setString(4, dto.getEntidadVacuna().getPortada());
            ps.setString(5, dto.getEntidadVacuna().getEficacia());
            ps.setString(6, dto.getEntidadVacuna().getSeguridad());
            ps.setInt(7, dto.getEntidadVacuna().getIdVacuna());
            ps.executeLargeUpdate();
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conexion != null) {
                conexion.close();
            }
        }
    }
    
    public void delete(Vacunadto dto) throws SQLException {
        conectar();
        PreparedStatement ps = null;
        try {
            ps = conexion.prepareStatement(SQL_DELETE);
            ps.setInt(1, dto.getEntidadVacuna().getIdVacuna());
            ps.executeLargeUpdate();
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conexion != null) {
                conexion.close();
            }
        }
    }
    
    public Vacunadto read(Vacunadto dto) throws SQLException {
        conectar();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conexion.prepareStatement(SQL_READ);
            ps.setInt(1, dto.getEntidadVacuna().getIdVacuna());
            rs = ps.executeQuery();
            List resultados = obtenerResultados(rs);
            if (resultados.size() > 0) {
                return (Vacunadto) resultados.get(0);
            } else {
                return null;
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conexion != null) {
                conexion.close();
            }
        }
    }
    
    private List obtenerResultados(ResultSet rs) throws SQLException {
        List resultados = new ArrayList();
        while (rs.next()) {
            Vacunadto dto = new Vacunadto();
            dto.getEntidadVacuna().setIdVacuna(rs.getInt("idVacuna"));
            dto.getEntidadVacuna().setNombreVacuna(rs.getString("nombreVacuna"));
            dto.getEntidadVacuna().setDescripcion(rs.getString("Descripcion"));
            dto.getEntidadVacuna().setLogo(rs.getString("Logo"));
            dto.getEntidadVacuna().setPortada(rs.getString("Portada"));
            dto.getEntidadVacuna().setEficacia(rs.getString("Eficacia"));
            dto.getEntidadVacuna().setSeguridad(rs.getString("Seguridad"));
            dto.getEntidadVacuna().setIdForo(rs.getInt("idForo"));
            resultados.add(dto);
        }
        return resultados;
    }
    
    public List readall() throws SQLException {
        conectar();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conexion.prepareStatement(SQL_READALL);
            rs = ps.executeQuery();
            List resultados = obtenerResultados(rs);
            if (resultados.size() > 0) {
                return resultados;
            } else {
                return null;
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conexion != null) {
                conexion.close();
            }
        }
    }
    
    public static void main(String[] args) {
        Vacunadao dao = new Vacunadao();
        
        Vacunadto dto = new Vacunadto();
//        dto.getEntidadVacuna().setNombreVacuna("Pfizeraaa21");
//        dto.getEntidadVacuna().setDescripcion("Prueba21");
//        dto.getEntidadVacuna().setLogo("Sin logo21");
//        dto.getEntidadVacuna().setPortada("Sin portada21");
//        dto.getEntidadVacuna().setEficacia("Sin eficiencia21");
//        dto.getEntidadVacuna().setSeguridad("Sin seguridad21");
//        dto.getEntidadVacuna().setIdForo(1);

        try {
            dto.getEntidadVacuna().setIdVacuna(1);
//            dto = dao.read(dto);
//            System.out.println(dto);
            dao.delete(dto);
            System.out.println(dao.readall());
            
        } catch (SQLException ex) {
            Logger.getLogger(Vacunadao.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
