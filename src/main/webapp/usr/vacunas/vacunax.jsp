<%-- 
    Document   : vacunax
    Created on : 25 nov. 2021, 12:32:32
    Author     : caleb
--%>
<%@page import="com.ipn.mx.datavaccine.entidades.ReaccionAdversa"%>
<%@page import="com.ipn.mx.datavaccine.entidades.Publicacion"%>
<%@page import="java.util.List"%>
<%@page import="com.ipn.mx.datavaccine.dto.VacunaDTO"%>
<%@page import="com.ipn.mx.datavaccine.dto.UsuarioDTO"%>
<%
    HttpSession sesionUsuario = request.getSession();
    if (sesionUsuario.getAttribute("correo") == null) {
        response.sendRedirect("../../iniciarSesion.jsp");
        return;
    }
    String correo = (String) sesionUsuario.getAttribute("correo");
    String vacuna = (String) request.getAttribute("nombreVacuna");
    int link = request.getParameter("link") == null ? 0 : Integer.parseInt(request.getParameter("link"));
    System.out.println("link:" + link);
    UsuarioDTO dtoUsuario = (UsuarioDTO) sesionUsuario.getAttribute("dtoUsuario");
    VacunaDTO dtoVacuna = (VacunaDTO) request.getAttribute("datosVacuna");

    List mensajesForo = (List) request.getAttribute("mensajesForo");
    List reaccionesAdversas = (List)request.getAttribute("reaccionesAdversas");

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
                    <v-img
                        class="mx-2"
                        src="../../img/logo.png"
                        max-height="40"
                        max-width="40"
                        contain
                        ></v-img>
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
                                                    <a href="https://mivacuna.salud.gob.mx/index.php" target="_blank">
                                                        <v-chip class="ma-2" color="primary">
                                                            Registrate en mivacuna.salud.gob.mx
                                                        </v-chip>
                                                    </a>

                                                    <iframe width="100%" height="450" style="border:0" loading="lazy" allowfullscreen src="https://www.google.com/maps/embed/v1/search?q=vacuna+en+ciudad+de+mexico&key=AIzaSyAeA4a5P0FRHqnXWzOYZWc7CAZgPkOsnXY"></iframe>
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
                                        <h2>Calcular probabilidad de contraer una reaccion adversa (efectos secundarios)</h2>
                                    </v-col>
                                    <v-col cols="12">
                                        <v-card>
                                            <v-card-text>
                                                <h3>Con base en la información que proporcionaste al registrate, puedes calcular la probabilidad de contraer una reacción adversa si te inyectan una dosis de {{nombreVacuna}}. 
                                                    Los datos con los que se haran los calculos son los siguientes:</h3>

                                                <v-row class="pt-7">
                                                    <v-col cols="12" md="6">
                                                        <v-text-field readonly v-model="intEdad" prepend-inner-icon="mdi-account" name="edad" label="Edad" type="number" outlined required suffix="años" :rules="reglasEdad"></v-text-field>
                                                    </v-col>
                                                    <v-col cols="12" md="6">
                                                        <v-radio-group readonly v-model="genero" row name="genero">
                                                            <template v-slot:label>
                                                                <div>Genero:</div>
                                                            </template>
                                                            <v-radio label="Masculino" value="Masculino">
                                                            </v-radio>
                                                            <v-radio label="Femenino" value="Femenino">
                                                            </v-radio>
                                                        </v-radio-group>
                                                    </v-col>

                                                    <v-col cols="12" md="6">
                                                        <v-text-field readonly v-model="intAltura" prepend-inner-icon="mdi-human-male-height" name="altura" label="Altura" type="number" step=".01" outlined required suffix="m" :rules="[intAltura => !!intAltura || 'Este campo es requerido']"></v-text-field>
                                                    </v-col>

                                                    <v-col cols="12" md="6">
                                                        <v-text-field readonly v-model="intPeso" prepend-inner-icon="mdi-weight-kilogram" name="peso" label="Peso" type="number" step=".01" outlined required suffix="kg" :rules="[intPeso => !!intPeso || 'Este campo es requerido']"></v-text-field>
                                                    </v-col>

                                                    <v-col cols="12" md="6">
                                                        <v-combobox
                                                            readonly
                                                            v-model="grupoSanguineo"
                                                            :items="itemsGrupoSanguineo"
                                                            label="Grupo sanguíneo"
                                                            name="grupoSanguineo"
                                                            outlined
                                                            required
                                                            ></v-combobox>
                                                    </v-col>

                                                    <v-col cols="12" md="6">
                                                        <v-combobox
                                                            readonly
                                                            v-model="alergias"
                                                            :items="itemsAlergias"
                                                            label="Alergias (opcional)"
                                                            name="alergias"
                                                            outlined
                                                            multiple
                                                            chips
                                                            ></v-combobox>
                                                    </v-col>
                                                </v-row>
                                            </v-card-text>
                                            <v-card-actions>
                                            <v-btn block color="primary" @click="mostrarResultados = !mostrarResultados">
                                                Calcular probabilidad
                                            </v-btn>
                                            </v-card-actions>
                                            <v-expand-transition >
                                                <div v-show="mostrarResultados" >
                                                    <v-divider></v-divider>
                                                    <v-card-text >
                                                        Los sintomas que probablemente podrias llegar a presentar son los siguientes:
                                                        <bar-chart :renderizar="mostrarResultados" :height="550"></bar-chart>
                                                    </v-card-text>
                                                </div>
                                            </v-expand-transition>
                                        </v-card>
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
                                                    <form method="POST" action="ProcesarPublicacion">
                                                        <v-divider></v-divider>
                                                        <v-text-field v-model="strTitulo" name="titulo" label="Título" type="text" outlined class="mt-4" required :rules="[v => !!v || 'Este campo es requerido']"></v-text-field>
                                                        <v-textarea v-model="strMensaje" outlined name="mensaje" label="Escribe el mensaje que quieres comentar"></v-textarea>
                                                        <input id="idVacuna" name="idVacuna" type="hidden" value="<%=dtoVacuna.getEntidadVacuna().getIdVacuna()%>">
                                                        <v-btn block color="primary" type="submit"> Subir comentario </v-btn>
                                                    </form>
                                                </div>

                                            </v-expand-transition>

                                    </v-col>
                                    <%
                                        Publicacion publicacionx;
                                        for (int i = 0; i < mensajesForo.size(); i++) {
                                            publicacionx = (Publicacion) mensajesForo.get(i);

                                    %>
                                    <v-col cols="12">

                                        <v-card>
                                            <v-card-title class="">
                                                <v-list-item class="grow">
                                                    <v-list-item-avatar color="primary">
                                                        <v-img
                                                            alt=""
                                                            src="https://themeselection.com/demo/materio-vuetify-vuejs-admin-template-free/demo/img/1.e2938115.png"
                                                            ></v-img>
                                                    </v-list-item-avatar>

                                                    <v-list-item-content>
                                                        <v-list-item-title><%=publicacionx.getNombreUsuario() + " - " + publicacionx.getTitulo()%></v-list-item-title>
                                                        <v-list-item-subtitle><%=publicacionx.getFecha().toString()%></v-list-item-subtitle>
                                                    </v-list-item-content>
                                                </v-list-item>
                                            </v-card-title>
                                            <v-card-text class="pl-8 pr-8">
                                                <%=publicacionx.getMensaje()%>
                                            </v-card-text>
                                        </v-card>
                                    </v-col>
                                    <%
                                        }
                                    %>
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
Vue.component('bar-chart', {
    extends: VueChartJs.Bar,
    props:{
        renderizar: Boolean
    },
        
    data: () => ({
            chartdata: {
                labels: [
                    <%
                        ReaccionAdversa reaccionx;
                        for (int i = 0; i < reaccionesAdversas.size(); i++) {
                           reaccionx = (ReaccionAdversa) reaccionesAdversas.get(i);
                           
                           
                    %>
                        <%="'"+reaccionx.getNombre()+"', "%>
                    <%
                        }
                    %>
                ],
                datasets: [{
                        label: 'Sintoma',
                        backgroundColor: 'rgba(255, 79, 35, 0.7)',
                        data: [
                            <%
                                for (int i = 0; i < reaccionesAdversas.size(); i++) {
                                   reaccionx = (ReaccionAdversa) reaccionesAdversas.get(i);

                            %>
                                <%=reaccionx.getPorcentajeProbabilidad()+", "%>
                            <%
                                }
                            %>
                            //200, 350, 120, 155, 228, 310, 400, 210
                        ]
                    }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    yAxes: [{
                            ticks: {
                                beginAtZero: true
                            }
                        }]
                }
            },

        }),

    mounted() {
        //this.renderChart(this.chartdata, this.options)
        console.log('a')
    },
    
    watch: {
        renderizar: function (newVal, oldVal) {
          this.renderChart(this.chartdata, this.options)
          console.log('b')
      }
  }  

})
    
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

            nombreUsuario: '<%=dtoUsuario.getEntidad().getNombreUsuario() + " " + dtoUsuario.getEntidad().getPaterno()%>',
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
            intEdad: <%=dtoUsuario.getEntidad().getEdad()%>,
            reglasEdad: [
                v => !!v || "Este campo es requerido",
                v => (v && v >= 18) || "Debes de tener al menos 18 años",
            ],
            genero: '<%=dtoUsuario.getEntidad().getGenero()%>',

            strFolio: '',
            intAltura: <%=dtoUsuario.getEntidad().getAltura()%>,
            intPeso: <%=dtoUsuario.getEntidad().getPeso()%>,
            grupoSanguineo: '<%=dtoUsuario.getEntidad().getGrupoSanguineo()%>',
            itemsGrupoSanguineo: [
                'A-',
                'A+',
                'B-',
                'B+',
                'O-',
                'O+',
                'AB-',
                'AB+',
            ],
            alergias: [<%=dtoUsuario.getEntidad().getAlergias()%>],
            itemsAlergias: [
                'Alergia 1',
                'Alergia 2',
                'Alergia 3',
                'Alergia 4',
            ],
            mostrarResultados: false,
            
                    

            //foro
            show: false,
            strTitulo: '',
            strMensaje: '',

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