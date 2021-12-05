<%-- 
    Document   : listaVacunas
    Created on : 25 nov. 2021, 08:45:07
    Author     : caleb
--%> 

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesionUsuario = request.getSession();
    if (sesionUsuario.getAttribute("correo") == null) {
        response.sendRedirect("../../iniciarSesion.jsp");
        return;
    }
    String correo = (String) sesionUsuario.getAttribute("correo");
%>
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.min.js"></script>
        <script src="https://unpkg.com/vue-chartjs/dist/vue-chartjs.min.js"></script>
    </head>

    <body>
        <div id="app">
            <v-app>
                <v-app-bar app dark style=" background-color: rgba(6, 5, 55, 0.85) !important; backdrop-filter: saturate(180%) blur(20px) !important;">
                    <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
                    <v-toolbar-title>Lista de Vacunas</v-toolbar-title>
                    <v-spacer></v-spacer>

                    <v-menu left bottom offset-y rounded="lg">
                        <template v-slot:activator="{ on, attrs }">
                            <v-btn icon v-bind="attrs" v-on="on">
                                <v-avatar color="accent darken-1 shrink" size="32">
                                    <v-img
                                        alt=""
                                        :src="imagenUsuario"
                                        ></v-img>
                                </v-avatar>
                            </v-btn>
                        </template>

                        <v-list>
                            <v-list-item>
                                <v-list-item-content>
                                    <v-list-item-title class="text-h6">
                                        {{nombreUsuario}}
                                    </v-list-item-title>
                                    <v-list-item-subtitle>
                                        {{correo}}
                                    </v-list-item-subtitle>
                                </v-list-item-content>
                            </v-list-item>

                            <v-divider></v-divider>
                            <v-list-item href="../configuracionCuenta">
                                <v-list-item-title>Configuración de la cuenta</v-list-item-title>
                            </v-list-item>
                            <v-list-item href="../cerrarSesion">
                                <v-list-item-title>Cerrar Sesión</v-list-item-title>
                            </v-list-item>
                        </v-list>
                    </v-menu>
                </v-app-bar>

                <v-navigation-drawer v-model="drawer" fixed temporary>
                    <v-img src="../../img/logo.png"></v-img>
                    <v-list-item>
                        <v-list-item-content>
                            <v-list-item-title class="text-h6">
                                DataVaccine
                            </v-list-item-title>
                            <v-list-item-subtitle>
                                Menú de navegación
                            </v-list-item-subtitle>
                        </v-list-item-content>
                    </v-list-item>

                    <v-divider></v-divider>
                    <v-list nav dense>
                        <v-list-item-group v-model="group" active-class="accent--text text--accent-4">
                            <v-list-item href="../inicio">
                                <v-list-item-icon>
                                    <v-icon>mdi-home</v-icon>
                                </v-list-item-icon>
                                <v-list-item-title>Inicio</v-list-item-title>
                            </v-list-item>

                            <v-list-item  href="listaVacunas">
                                <v-list-item-icon>
                                    <v-icon>mdi-clipboard-list</v-icon>
                                </v-list-item-icon>
                                <v-list-item-title>Lista de Vacunas</v-list-item-title>
                            </v-list-item>

                            <v-list-item href="../configuracionCuenta">
                                <v-list-item-icon>
                                    <v-icon>mdi-account</v-icon>
                                </v-list-item-icon>
                                <v-list-item-title>Configuración de la cuenta</v-list-item-title>
                            </v-list-item>
                        </v-list-item-group>
                    </v-list>
                </v-navigation-drawer>

                <v-main class="grey lighten-2">
                    <v-container>
                        <v-row>
                            <v-col cols="12">
                                <h2>Todas las vacunas disponibles</h2>
                            </v-col>
                            <v-col cols="12">
                                <v-text-field label="Buscar vacuna" outlined clearable dense></v-text-field>
                            </v-col>
                            <template v-for="n in 14">
                                <v-col cols="4" :key="n">
                                    <v-card class="greeting-card">
                                        <v-row class="ma-0 pa-0">
                                            <v-col cols="8">
                                                <v-card-title class="text-no-wrap pt-1 ps-2">
                                                    Vacuna {{n}}
                                                </v-card-title>
                                                <v-card-subtitle class="text-no-wrap ps-2">
                                                    Descripción
                                                </v-card-subtitle>
                                                <v-card-text class="d-flex align-center mt-2 pb-2 ps-2">
                                                    <div>
                                                        <p class="text-xl font-weight-semibold primary--text mb-2">
                                                            10 comentarios
                                                        </p>

                                                        <v-btn small color="primary" href="vacuna?x=Pfizer">
                                                            Ver más
                                                        </v-btn>
                                                    </div>
                                                </v-card-text>
                                            </v-col>

                                            <v-col cols="4">
                                                <!--<v-img contain height="180" width="159" :src="require(`@/assets/images/misc/triangle-${$vuetify.theme.dark ? 'dark':'light'}.png`)" class="greeting-card-bg"></v-img>-->
                                                <v-img contain height="108" max-width="83" class="greeting-card-trophy" src="../../img/logo.png"></v-img>
                                            </v-col>
                                        </v-row>
                                    </v-card>
                                </v-col>
                            </template>
                        </v-row>
                    </v-container>
                </v-main>
            </v-app>

        </div>
        <script>
new Vue({
    el: '#app',
    data: () => ({
            drawer: false,
            group: 1,

            nombreUsuario: 'Nombre de usuario',
            correo: '<%=correo%>',
            imagenUsuario: 'https://themeselection.com/demo/materio-vuetify-vuejs-admin-template-free/demo/img/1.e2938115.png',
        }),
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