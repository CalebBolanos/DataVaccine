<%-- 
    Document   : vacunax
    Created on : 25 nov. 2021, 12:32:32
    Author     : caleb
--%>
<%@page import="com.ipn.mx.datavaccine.dto.VacunaDTO"%>
<%@page import="com.ipn.mx.datavaccine.dto.UsuarioDTO"%>
<%
    HttpSession sesionUsuario = request.getSession();
    if (sesionUsuario.getAttribute("correo") == null) {
        response.sendRedirect("../../iniciarSesion.jsp");
        return;
    }
    String correo = (String) sesionUsuario.getAttribute("correo");
    String vacuna = (String)request.getAttribute("nombreVacuna");
    int link = request.getParameter("link") == null ? 0 : Integer.parseInt(request.getParameter("link"));
    System.out.println("link:"+ link);
    UsuarioDTO dtoUsuario = (UsuarioDTO) sesionUsuario.getAttribute("dtoUsuario");
    VacunaDTO dtoVacuna = (VacunaDTO)request.getAttribute("datosVacuna");
%>
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.min.js"></script>
        <script src="https://unpkg.com/vue-chartjs/dist/vue-chartjs.min.js"></script>
    </head>

    <body>
        <div id="app">
            <v-app>
                <v-app-bar app dark style=" background-color: rgba(6, 5, 55, 0.85) !important; backdrop-filter: saturate(180%) blur(20px) !important;">
                    <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
                    <v-toolbar-title>{{nombreVacuna}}</v-toolbar-title>
                    <template v-slot:extension>
                        <v-tabs
                            centered
                            class="ml-n9"
                            v-model="link" show-arrows
                            >
                            <v-tab
                                v-for="link in links"
                                :key="link"
                                >
                                {{ link }}
                            </v-tab>
                        </v-tabs>
                    </template>
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
                                <v-list-item-title>Información de la cuenta</v-list-item-title>
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

                            <v-list-item href="listaVacunas">
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
                    <v-tabs-items v-model="link">


                        <!-- INFORMACION GENERAL -->
                        <v-tab-item class="grey lighten-2">
                            <v-container>
                                <v-row>
                                    <v-col cols="12">
                                        <v-card class="greeting-card">
                                            <v-parallax contain height="350" v-bind:src="linkImagenPortada"></v-parallax>

                                            <v-row class="ma-0 pa-0">
                                                <v-col cols="8">
                                                    <v-card-title class="text-no-wrap pt-1 ps-2">
                                                        {{nombreVacuna}}
                                                    </v-card-title>
                                                    <v-card-subtitle class=" ps-2">
                                                        {{resumenVacuna}}
                                                    </v-card-subtitle>
                                                </v-col>
                                                <v-col cols="4">
                                                    <!--<v-img contain height="180" width="159" :src="require(`@/assets/images/misc/triangle-${$vuetify.theme.dark ? 'dark':'light'}.png`)" class="greeting-card-bg"></v-img>-->
                                                    <v-img contain height="90" class="greeting-card-trophy" :src="linkImagenLogo"></v-img>
                                                </v-col>
                                            </v-row>
                                        </v-card>
                                    </v-col>
                                    <v-col cols="12">
                                        <v-expansion-panels multiple v-model="panel">
                                            <v-expansion-panel>
                                                <v-expansion-panel-header>
                                                    <h3>Eficacia</h3>
                                                </v-expansion-panel-header>
                                                <v-expansion-panel-content>
                                                    {{infoEficacia}}
                                                </v-expansion-panel-content>
                                            </v-expansion-panel>

                                            <v-expansion-panel>
                                                <v-expansion-panel-header>
                                                    <h3>Efectos secundarios</h3>
                                                </v-expansion-panel-header>
                                                <v-expansion-panel-content>
                                                    {{infoEfectosSecundarios}}
                                                </v-expansion-panel-content>
                                            </v-expansion-panel>

                                            <v-expansion-panel>
                                                <v-expansion-panel-header>
                                                    <h3>Seguridad</h3>
                                                </v-expansion-panel-header>
                                                <v-expansion-panel-content>
                                                    {{infoSeguridad}}
                                                </v-expansion-panel-content>
                                            </v-expansion-panel>

                                            <v-expansion-panel>
                                                <v-expansion-panel-header>
                                                    <h3>¿Cómo obtener la vacuna?</h3>
                                                </v-expansion-panel-header>
                                                <v-expansion-panel-content>
                                                    Si tienes 18 años o más, ya te puedes vacunar, siguiendo este enlace:
                                                    <a href="https://mivacuna.salud.gob.mx/index.php">
                                                        <v-chip class="ma-2" color="primary">
                                                            Registrate en mivacuna.salud.gob.mx
                                                        </v-chip>
                                                    </a>

                                                    <iframe width="100%" height="450" style="border:0" loading="lazy" allowfullscreen src="https://www.google.com/maps/embed/v1/search?q=vacuna&key=AIzaSyAeA4a5P0FRHqnXWzOYZWc7CAZgPkOsnXY"></iframe>
                                                </v-expansion-panel-content>
                                            </v-expansion-panel>
                                        </v-expansion-panels>
                                    </v-col>

                                </v-row>
                            </v-container>
                        </v-tab-item>


                        <!-- CALCULAR PROBABILIDAD -->
                        <v-tab-item class="grey lighten-2">
                            <v-container>
                                <v-row>
                                    <v-col cols="12">

                                    </v-col>
                                </v-row>
                            </v-container>
                        </v-tab-item>
                        <!-- FORO -->
                        <v-tab-item class="grey lighten-2">
                            <v-container>
                                <v-row>
                                    <v-col cols="12">
                                        <v-card elevation="0" class="mx-auto" color="grey lighten-2">
                                            <v-card-actions>
                                                <h2>Comentarios acerca de la experiencia de vacunación</h2>

                                                <v-spacer></v-spacer>

                                                <v-btn color="accent" @click="show = !show">
                                                    <span v-if="!show">Comentar</span>
                                                    <span v-else>Cancelar</span>
                                                </v-btn>
                                            </v-card-actions>
                                            <v-expand-transition>
                                                <div v-show="show">
                                                    <v-divider></v-divider>

                                                    <v-textarea outlined class="mt-4" label="Escribe el mensaje que quieres comentar"></v-textarea>
                                                    <v-btn block color="primary"> Subir comentario </v-btn>
                                                </div>
                                            </v-expand-transition>

                                    </v-col>
                                    <template v-for="n in 14">
                                        <v-col cols="12">

                                            <v-card>
                                                <v-card-title class="">
                                                    <v-list-item class="grow">
                                                        <v-list-item-avatar color="primary">
                                                            <v-img
                                                                alt=""
                                                                src="https://avataaars.io/?avatarStyle=Transparent&topType=ShortHairShortCurly&accessoriesType=Prescription02&hairColor=Black&facialHairType=Blank&clotheType=Hoodie&clotheColor=White&eyeType=Default&eyebrowType=DefaultNatural&mouthType=Default&skinColor=Light"
                                                                ></v-img>
                                                        </v-list-item-avatar>

                                                        <v-list-item-content>
                                                            <v-list-item-title>Nombre Persona </v-list-item-title>
                                                            <v-list-item-subtitle>3 de Noviembre de 2021</v-list-item-subtitle>
                                                        </v-list-item-content>
                                                    </v-list-item>
                                                </v-card-title>
                                                <v-card-text class="pl-8 pr-8">
                                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur faucibus dolor id feugiat convallis. Curabitur dictum mi quis felis venenatis, sit amet lacinia metus maximus. Maecenas aliquam ipsum at rhoncus feugiat. Suspendisse auctor placerat nisi et consectetur. Duis aliquam libero at lacus dictum, tincidunt vehicula lorem volutpat. Nunc nec dui a lorem consequat faucibus ac at ex. Integer nec leo eros. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nam at tortor ac dolor aliquet scelerisque.
                                                </v-card-text>
                                            </v-card>
                                        </v-col>
                                    </template>
                                </v-row>
                            </v-container>
                        </v-tab-item>
                        <!-- NOTICIAS -->
                        <v-tab-item class="grey lighten-2">
                            <v-container>
                                <v-row>
                                    <template v-for="(articulo, i) in articulos">
                                        <v-col sm="12" cols="12" :key="i">
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
                        </v-tab-item>
                        <!-- INFORMACION GENERAL 
                    <v-tab-item>

                    </v-tab-item>
                        -->
                    </v-tabs-items>


                </v-main>
            </v-app>

        </div>
        <script>
new Vue({
    el: '#app',
    data: () => ({
            //interfaz
            drawer: false,
            group: 1,
            link: <%=link%>,
            links: [
                'Información General',
                'Calcular probabilidad',
                'Foros',
                'Noticias',
            ],
            
            nombreUsuario: '<%=dtoUsuario.getEntidad().getNombreUsuario()+ " " + dtoUsuario.getEntidad().getPaterno()%>',
            correo: '<%=correo%>',
            imagenUsuario: 'https://themeselection.com/demo/materio-vuetify-vuejs-admin-template-free/demo/img/1.e2938115.png',

            //informacion general
            nombreVacuna: '<%=vacuna%>',
            resumenVacuna: `<%=dtoVacuna.getEntidadVacuna().getDescripcion()%>`,
            infoEficacia: `<%=dtoVacuna.getEntidadVacuna().getEficacia()%>`,
            infoEfectosSecundarios: 'faltan',
            infoSeguridad: `<%=dtoVacuna.getEntidadVacuna().getSeguridad()%>`,
            linkImagenPortada: `<%=dtoVacuna.getEntidadVacuna().getPortada()%>`,
            linkImagenLogo: `<%=dtoVacuna.getEntidadVacuna().getLogo()%>`,
            panel: [0, 1, 2],

            //calcular probabilidad

            //foro
            show: false,

            //noticias
            newsApiUrl: '',
            nombreVacunaBusqueda: '<%=vacuna%>', //url encoded
            totalResultados: 0,
            articulos: [],

        }),

    methods: {
        obtenerNoticias() {
            this.newsApiUrl = 'https://newsapi.org/v2/everything?q=' + this.nombreVacunaBusqueda + '&from=2021-11-20&language=es&apiKey=1234a106a9e147999185398c876a42fe';

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