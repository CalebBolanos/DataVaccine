/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ipn.mx.datavaccine.dao;

import com.ipn.mx.datavaccine.dto.UsuarioDTO;
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
 * @author Lalo
 */
public class UsuarioDAO {
    private static final String SQL_INSERT = "insert into Usuario (Nombre,ApellidoP,ApellidoM,Genero,Edad,Correo,Contrasena,Folio,Foto,Altura,Peso,Alergias,GrupoSanguineo) values (?,?,?,?,?,?,?,?,?,?,?,?,?)";
    private static final String SQL_UPDATE = "update Usuario set  Nombre = ?, ApellidoP = ?, ApellidoM =?, Genero=?, Edad=?, Correo=?, Contraseña=?, Folio=?, Foto=?, Altura=?, Peso=?, Alergias=?, GrupoSanguineo=? where idUsuario = ?";
    private static final String SQL_DELETE = "delete from Usuario where idUsuario = ?";
    private static final String SQL_READ = "select idUsuario,Nombre,ApellidoP,ApellidoM,Genero,Edad,Correo,Contrasena,Folio,Foto,Altura,Peso,Alergias,GrupoSanguineo from Usuario where idUsuario = ?";
    private static final String SQL_ALL = "select idUsuario,Nombre,ApellidoP,ApellidoM,Genero,Edad,Correo,Contrasena,Folio,Foto,Altura,Peso,Alergias,GrupoSanguineo from Usuario";

    private Connection conexion;
//base local
    private Connection conectar() {
       String user = "root";
       String pwd = "n0m3l0s3";
       String url = "jdbc:mysql://localhost:3306/vacunadoo?serverTimezone=UTC";
       String driverClassName = "com.mysql.cj.jdbc.Driver";
        try {
            Class.forName(driverClassName);
            conexion = DriverManager.getConnection(url, user, pwd);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conexion;
    }

    public void create(UsuarioDTO dto) throws SQLException {
        conectar();
        PreparedStatement ps = null;
        try {
            ps = conexion.prepareStatement(SQL_INSERT);
            ps.setString(1, dto.getEntidad().getNombreUsuario());
            ps.setString(2, dto.getEntidad().getPaterno());
            ps.setString(3, dto.getEntidad().getMaterno());
            ps.setString(4, dto.getEntidad().getGenero());
            ps.setInt(5, dto.getEntidad().getEdad());
            ps.setString(6, dto.getEntidad().getCorreo());
            ps.setString(7, dto.getEntidad().getContrasena());
            ps.setString(8, dto.getEntidad().getFolio());
            ps.setString(9, dto.getEntidad().getFoto());
            ps.setFloat(10, dto.getEntidad().getAltura());
            ps.setFloat(11, dto.getEntidad().getPeso());
            ps.setString(12, dto.getEntidad().getAlergias());
            ps.setString(13, dto.getEntidad().getGrupoSanguineo());
            
            
            
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

    public void update(UsuarioDTO dto) throws SQLException {
        conectar();
        PreparedStatement ps = null;
        try {
            ps = conexion.prepareStatement(SQL_UPDATE);
            ps.setString(1, dto.getEntidad().getNombreUsuario());
            ps.setString(2, dto.getEntidad().getPaterno());
            ps.setString(3, dto.getEntidad().getMaterno());
            ps.setString(4, dto.getEntidad().getGenero());
            ps.setInt(5, dto.getEntidad().getEdad());
            ps.setString(6, dto.getEntidad().getCorreo());
            ps.setString(7, dto.getEntidad().getContrasena());
            ps.setString(8, dto.getEntidad().getFolio());
            ps.setString(9, dto.getEntidad().getFoto());
            ps.setFloat(10, dto.getEntidad().getAltura());
            ps.setFloat(11, dto.getEntidad().getPeso());
            ps.setString(12, dto.getEntidad().getAlergias());
            ps.setString(13, dto.getEntidad().getGrupoSanguineo());
            ps.setInt(14, dto.getEntidad().getIdUsuario());
            ps.executeLargeUpdate();//ps.executeQuery();
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conexion != null) {
                conexion.close();
            }
        }
    }

    public void delete(UsuarioDTO dto) throws SQLException {
        conectar();
        PreparedStatement ps = null;
        try {
            ps = conexion.prepareStatement(SQL_DELETE);
            ps.setInt(1, dto.getEntidad().getIdUsuario());
            //ps.executeQuery();
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

    public List readALL() throws SQLException {
        conectar();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conexion.prepareStatement(SQL_ALL);
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

    public UsuarioDTO read(UsuarioDTO dto) throws SQLException {
        conectar();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conexion.prepareStatement(SQL_READ);
            ps.setInt(1, dto.getEntidad().getIdUsuario());
            rs = ps.executeQuery();
            List resultados = obtenerResultados(rs);
            if (resultados.size() > 0) {
                return (UsuarioDTO) resultados.get(0);
            } else {
                return null;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
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
        return null;
    }

    private List obtenerResultados(ResultSet rs) throws SQLException {
        List resultados = new ArrayList();
        while (rs.next()) {
            UsuarioDTO p = new UsuarioDTO();
            p.getEntidad().setIdUsuario(rs.getInt("idUsuario"));
            p.getEntidad().setNombreUsuario(rs.getString("Nombre"));
            p.getEntidad().setPaterno(rs.getString("Apellido Paterno"));
            p.getEntidad().setMaterno(rs.getString("Apellido Materno"));
            p.getEntidad().setGenero(rs.getString("Genero"));
            p.getEntidad().setEdad(rs.getInt("Edad"));
            p.getEntidad().setCorreo(rs.getString("Correo"));
            p.getEntidad().setContrasena(rs.getString("Contraseña"));
            p.getEntidad().setFolio(rs.getString("Folio"));
            p.getEntidad().setFoto(rs.getString("Foto"));
            p.getEntidad().setAltura(rs.getFloat("Altura"));
            p.getEntidad().setPeso(rs.getFloat("Peso"));
            p.getEntidad().setAlergias(rs.getString("Alergias"));
            p.getEntidad().setGrupoSanguineo(rs.getString("Grupo Sanguineo"));
            
            
            
            resultados.add(p);
        }
        return resultados;
    }

    public static void main(String[] args) {
        UsuarioDAO dao = new UsuarioDAO();
        UsuarioDTO dto = new UsuarioDTO();
       
        try {
            dao.create(dto);
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
