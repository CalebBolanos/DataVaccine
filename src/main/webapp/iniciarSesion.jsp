<%-- 
    Document   : iniciarSesion
    Created on : 23 nov. 2021, 13:13:41
    Author     : caleb
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/@mdi/font@6.x/css/materialdesignicons.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/vuetify@2.x/dist/vuetify.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/vue@2.x/dist/vue.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/vuetify@2.x/dist/vuetify.js"></script>
    </head>
    <body>
        <div id="app">
            <v-app>
                <v-content>
                    <v-container fluid fill-height>
                        <v-layout align-center justify-center>
                            <v-flex xs12 sm8 md4>
                                <form method="POST" action="ProcesarInicioSesion">
                                    <v-card class="elevation-12">
                                        <v-toolbar dark color="primary">
                                            <v-toolbar-title>Iniciar Sesión</v-toolbar-title>
                                        </v-toolbar>
                                        <v-card-text>
                                            <v-text-field
                                                prepend-icon="mdi-account-circle"
                                                name="usuario"
                                                label="Usuario"
                                                type="text"
                                                ></v-text-field>
                                            <v-text-field
                                                id="password"
                                                prepend-icon="mdi-lock"
                                                name="contrasena"
                                                label="Contraseña"
                                                type="password"
                                                ></v-text-field>
                                            </v-form>
                                            <v-card-actions>
                                                <v-spacer></v-spacer>
                                                <v-btn type="submit" color="primary" >Iniciar Sesion</v-btn>
                                                <v-spacer></v-spacer>
                                            </v-card-actions>
                                            ¿Aun no estas registrado? <a href="crearCuenta" style="color:#FF5023">Crea una cuenta aqui</a>
                                        </v-card-text>
                                    </v-card>
                                </form>
                            </v-flex>
                        </v-layout>
                    </v-container>
                </v-content>
            </v-app>
        </div>
        <script>
            new Vue({
                el: '#app',
                vuetify: new Vuetify({
                    theme: {
                        themes: {
                            light: {
                                primary: '#060537',
                                secondary: '#2C2A87',
                                accent: '#FF5023',
                                error: '#FF5252',
                                info: '#2196F3',
                                success: '#4CAF50',
                                warning: '#FFC107',
                            },
                        },
                    },
                }),
            })
        </script>
    </body>
</html>
