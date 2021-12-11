<%-- 
    Document   : inicio
    Created on : 24 nov. 2021, 12:24:39
    Author     : caleb
--%>
<%@page import="com.ipn.mx.datavaccine.dto.VacunaDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.ipn.mx.datavaccine.dto.UsuarioDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesionUsuario = request.getSession();
    if (sesionUsuario.getAttribute("correo") == null) {
        response.sendRedirect("../iniciarSesion.jsp");
        return;
    }
    String correo = (String) sesionUsuario.getAttribute("correo");
    UsuarioDTO dtoUsuario = (UsuarioDTO) sesionUsuario.getAttribute("dtoUsuario");
    List listaVacuna = (List) request.getAttribute("listaVacuna");
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
                    <v-img
                        class="mx-2"
                        src="../img/logo.png"
                        max-height="40"
                        max-width="40"
                        contain
                        ></v-img>
                    <v-toolbar-title>Inicio</v-toolbar-title>
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
                            <v-list-item href="configuracionCuenta">
                                <v-list-item-title>Configuración de la cuenta</v-list-item-title>
                            </v-list-item>
                            <v-list-item href="cerrarSesion">
                                <v-list-item-title>Cerrar Sesión</v-list-item-title>
                            </v-list-item>
                        </v-list>
                    </v-menu>
                </v-app-bar>

                <v-navigation-drawer v-model="drawer" fixed temporary>
                    <v-img src="../img/logo.png"></v-img>
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
                            <v-list-item href="inicio">
                                <v-list-item-icon>
                                    <v-icon>mdi-home</v-icon>
                                </v-list-item-icon>
                                <v-list-item-title>Inicio</v-list-item-title>
                            </v-list-item>

                            <v-list-item href="./vacunas/listaVacunas">
                                <v-list-item-icon>
                                    <v-icon>mdi-clipboard-list</v-icon>
                                </v-list-item-icon>
                                <v-list-item-title>Lista de Vacunas</v-list-item-title>
                            </v-list-item>

                            <v-list-item href="configuracionCuenta">
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
                                <h2>Accesos directos</h2>
                            </v-col>
                            <%
                                VacunaDTO vacunax;
                                for(int i=0; i<4; i++){
                                    vacunax = (VacunaDTO)listaVacuna.get(i);
                                    
                            %>
                            <v-col cols="12" lg="3" md="3" sm="3">
                                <v-card class="greeting-card">
                                    <v-row class="ma-0 pa-0">
                                        <v-col cols="8" >
                                            <v-card-title class="text-no-wrap pt-1 ps-2">
                                                <%=vacunax.getEntidadVacuna().getNombreVacuna()%>
                                            </v-card-title>
                                            <v-card-subtitle style="white-space:nowrap; word-break: normal; overflow: hidden; text-overflow: ellipsis;">
                                                <%=vacunax.getEntidadVacuna().getDescripcion()%>
                                            </v-card-subtitle>
                                            <v-card-text class="d-flex align-center mt-2 pb-2 ps-2">
                                                <div>
                                                    <v-btn small color="primary" href="./vacunas/vacuna?x=<%=vacunax.getEntidadVacuna().getIdVacuna()%>">
                                                        Ver más
                                                    </v-btn>
                                                </div>
                                            </v-card-text>
                                        </v-col>

                                        <v-col cols="4">
                                            <v-img contain height="108" max-width="83" class="greeting-card-trophy" src="<%=vacunax.getEntidadVacuna().getLogo()%>"></v-img>
                                        </v-col>
                                    </v-row>
                                </v-card>
                            </v-col>
                            <%
                                }
                            %>

                            <v-col cols="12" sm="12">
                                <v-sheet min-height="70vh" rounded="lg">
                                    <v-card>
                                        <v-card-title class="align-start">
                                            <span>Número total de personas que recibieron al menos una dosis de vacuna</span>

                                            <v-spacer></v-spacer>

                                            <v-btn icon small class="mt-n2 me-n3">
                                                <v-icon size="22">
                                                    mdi-chart-bar
                                                </v-icon>
                                            </v-btn>
                                        </v-card-title>

                                        <v-card-text>
                                            <iframe src="https://ourworldindata.org/grapher/people-vaccinated-covid?country=MEX" loading="lazy" style="width: 100%; height: 600px; border: 0px none;"></iframe>
                                        </v-card-text>
                                    </v-card>
                                </v-sheet>
                            </v-col>
                            <v-col cols="12" sm="12">
                                <v-sheet min-height="70vh" rounded="lg">
                                    <v-card>
                                        <v-card-title class="align-start">
                                            <span>Dosis diarias de vacuna COVID-19 administradas por cada 100 personas</span>

                                            <v-spacer></v-spacer>

                                            <v-btn icon small class="mt-n2 me-n3">
                                                <v-icon size="22">
                                                    mdi-chart-bar
                                                </v-icon>
                                            </v-btn>
                                        </v-card-title>
                                        <v-card-subtitle>
                                            Número de dosis diarias administradas (promedio de 7 días), dividido por la población total del país
                                        </v-card-subtitle>

                                        <v-card-text>
                                            <iframe src="https://ourworldindata.org/grapher/daily-covid-vaccination-doses-per-capita?country=~MEX" loading="lazy" style="width: 100%; height: 600px; border: 0px none;"></iframe>
                                        </v-card-text>
                                    </v-card>
                                </v-sheet>
                            </v-col>
                            <v-col>
                                <h2>Ultimas noticias</h2>
                            </v-col>
                            <template v-for="(articulo, i) in articulos">
                                <v-col sm="12" cols="12" :key="'a'+i">
                                    <v-card class="d-flex align-center">
                                        <div class="d-flex justify-space-between flex-wrap flex-md-nowrap flex-column flex-md-row">
                                            <div class="mx-auto">
                                                <v-img width="220" height="100%" :src="articulo.urlToImage"></v-img>
                                            </div>
                                            <v-divider :vertical="$vuetify.breakpoint.mdAndUp"></v-divider>
                                            <div>
                                                <v-card-title>
                                                    {{articulo.title}}
                                                </v-card-title>
                                                <v-card-text>
                                                    {{articulo.description}}
                                                </v-card-text>
                                                <v-card-text class="text--primary text-base">
                                                    <span>Fuente:</span> <span class="font-weight-bold">{{articulo.source.name}}</span>
                                                </v-card-text>
                                                <v-card-actions class="d-flex justify-space-between dense">
                                                    <v-btn text color="primary" dark :href="articulo.url" target="_blank">
                                                        <v-icon>mdi-newspaper-variant-multiple</v-icon>
                                                        <span class="ms-2">Leer noticia</span>
                                                    </v-btn> 
                                                </v-card-actions>
                                            </div>
                                        </div>
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
            group: 0,
            nombreUsuario: '<%=dtoUsuario.getEntidad().getNombreUsuario()+ " " + dtoUsuario.getEntidad().getPaterno()%>',
            correo: '<%=correo%>',
            imagenUsuario: 'https://themeselection.com/demo/materio-vuetify-vuejs-admin-template-free/demo/img/1.e2938115.png',

            //noticias
            newsApiUrl: '',
            nombreVacunaBusqueda: 'covid', //url encoded
            totalResultados: 0,
            articulos: [],
        }),

    methods: {
        obtenerNoticias() {
            this.newsApiUrl = 'https://newsapi.org/v2/top-headlines?country=mx&q=' + this.nombreVacunaBusqueda + '&apiKey=1234a106a9e147999185398c876a42fe';

            let request = new Request(this.newsApiUrl);

            fetch(request)
                    .then((response) => response.json())
                    .then((data) => {
                        this.totalResultados = data.totalResults;
                        data.articles.forEach(element => {
                            this.articulos.push(element);
                        });
                    })
                    .catch((error) => {
                        console.log(error)
                    })

        }
    },

    created() {
        this.obtenerNoticias();
    },
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