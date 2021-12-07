/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ipn.mx.datavaccine.dao;

import com.ipn.mx.datavaccine.dto.VacunaDTO;
import com.ipn.mx.datavaccine.entidades.Publicacion;
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
    
    private static final String SQL_INSERT = "insert into Vacunas (nombreVacuna,Descripcion,Logo,Portada,Eficacia,Seguridad) values (?,?,?,?,?,?)";
    private static final String SQL_UPDATE = "update Vacunas set nombreVacuna = ?, Descripcion = ?, Logo = ?, Portada = ?, Eficacia = ?, Seguridad = ? where idVacuna = ?";
    private static final String SQL_DELETE = "delete from Vacunas where idVacuna = ?";
    private static final String SQL_READ = "select idVacuna, nombreVacuna, Descripcion, Logo, Portada, Eficacia, Seguridad from Vacunas where idVacuna = ?";
    private static final String SQL_READALL = "select idVacuna, nombreVacuna, Descripcion, Logo, Portada, Eficacia, Seguridad from Vacunas";
    
    private Connection conexion;
    
    private void conectar() {
        usrBD = "root";
        passBD = "n0m3l0s3";
        urlBD = "jdbc:mysql://localhost:3306/vacunadoo?serverTimezone=UTC";
        driverClassName = "com.mysql.cj.jdbc.Driver";
        try {
            Class.forName(driverClassName);
            conexion = DriverManager.getConnection(urlBD, usrBD, passBD);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void create(VacunaDTO dto) throws SQLException {
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
    
    public void update(VacunaDTO dto) throws SQLException {
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
    
    public void delete(VacunaDTO dto) throws SQLException {
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
    
    public VacunaDTO read(VacunaDTO dto) throws SQLException {
        conectar();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conexion.prepareStatement(SQL_READ);
            ps.setInt(1, dto.getEntidadVacuna().getIdVacuna());
            rs = ps.executeQuery();
            List resultados = obtenerResultados(rs);
            if (resultados.size() > 0) {
                return (VacunaDTO) resultados.get(0);
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
            VacunaDTO dto = new VacunaDTO();
            dto.getEntidadVacuna().setIdVacuna(rs.getInt("idVacuna"));
            dto.getEntidadVacuna().setNombreVacuna(rs.getString("nombreVacuna"));
            dto.getEntidadVacuna().setDescripcion(rs.getString("Descripcion"));
            dto.getEntidadVacuna().setLogo(rs.getString("Logo"));
            dto.getEntidadVacuna().setPortada(rs.getString("Portada"));
            dto.getEntidadVacuna().setEficacia(rs.getString("Eficacia"));
            dto.getEntidadVacuna().setSeguridad(rs.getString("Seguridad"));
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
    
    public List obtenerMensajes(int idVacuna) throws SQLException {
        conectar();
        PreparedStatement ps = null;
        ResultSet rs = null;
        List resultados = new ArrayList();
        
        try {
            ps = conexion.prepareStatement("select * from Publicaciones where idVacuna = ? order by Fecha desc;");
            ps.setInt(1, idVacuna);
            rs = ps.executeQuery();
            
            while(rs.next()) {
                Publicacion pubx = new Publicacion();
                pubx.setIdPublicacion(rs.getInt("idPublicacion"));
                pubx.setIdVacuna(rs.getInt("idVacuna"));
                pubx.setTitulo(rs.getString("Titulo"));
                pubx.setNombreUsuario(rs.getString("NombreUsuario"));
                pubx.setMensaje(rs.getString("Contenido"));
                pubx.setImagen(rs.getString("Imagen"));
                pubx.setFecha(rs.getDate("Fecha"));
                resultados.add(pubx);
            }
            
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conexion != null) {
                conexion.close();
            }
        }
        
        return resultados;
    }
    
    
    public boolean guardarPublicacion(Publicacion publicacionx) throws SQLException {
        conectar();
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        boolean guardado = false;

        try {
            ps = conexion.prepareStatement("call spGuardarMensaje(?, ?, ?, ?, ?, ?);");
            ps.setString(1, publicacionx.getNombreUsuario());
            ps.setString(2, publicacionx.getTitulo());
            ps.setString(3, publicacionx.getMensaje());
            ps.setString(4, publicacionx.getImagen());
            ps.setDate(5, publicacionx.getFecha());
            ps.setInt(6, publicacionx.getIdVacuna());
            rs = ps.executeQuery();

            if (rs.next()) {
                guardado = rs.getString("msj").equals("ok");
            }
            
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conexion != null) {
                conexion.close();
            }
        }
        
        return guardado;
    }
    
    
    public static void main(String[] args) {
        Vacunadao dao = new Vacunadao();
        
        VacunaDTO dto = new VacunaDTO();
//        dto.getEntidadVacuna().setNombreVacuna("prueba nueva base");
//        dto.getEntidadVacuna().setDescripcion("prueba nueva base");
//        dto.getEntidadVacuna().setLogo("Sin logoprueba nueva base");
//        dto.getEntidadVacuna().setPortada("Sin portadaprueba nueva base");
//        dto.getEntidadVacuna().setEficacia("Sin eficienciaprueba nueva base");
//        dto.getEntidadVacuna().setSeguridad("Sin seguridadprueba nueva base");
//        dto.getEntidadVacuna().setIdVacuna(8);
        try {
            dto.getEntidadVacuna().setIdVacuna(8);
            dto = dao.read(dto);
//            System.out.println(dto);
            dao.delete(dto);
//            System.out.println(dao.readall());
//            dao.update(dto);
        } catch (SQLException ex) {
            Logger.getLogger(Vacunadao.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
