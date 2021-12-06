<%-- 
    Document   : configuracionCuenta
    Created on : 25 nov. 2021, 09:07:41
    Author     : caleb
--%>

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
                    <v-toolbar-title>Configuración de la cuenta</v-toolbar-title>
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
                                <v-list-item-title>Información de la cuenta</v-list-item-title>
                            </v-list-item>
                        </v-list-item-group>
                    </v-list>
                </v-navigation-drawer>

                <v-main class="grey lighten-2">
                    <v-container>
                        <v-row>
                            <v-col cols="12">
                                <v-card id="account-setting-card">
                                    <!-- tabs -->
                                    <v-tabs v-model="tab" show-arrows>
                                        <v-tab v-for="tab in tabs" :key="tab.icon">
                                            <v-icon size="20" class="me-3">

                                            </v-icon>
                                            <span>{{ tab.title }}</span>
                                        </v-tab>
                                    </v-tabs>

                                    <!-- tabs item -->
                                    <v-tabs-items v-model="tab">
                                        <!-- cuenta -->
                                        <v-tab-item>
                                            <v-card flat class="pa-3 mt-2">
                                                <v-card-text class="d-flex">
                                                    <v-avatar rounded size="120" class="me-6">
                                                        <v-img :src="imagenUsuario"></v-img>
                                                    </v-avatar>

                                                    <!-- upload photo -->
                                                    <div>
                                                        <v-btn color="primary" class="me-3 mt-5" @click="">
                                                            <v-icon class="d-sm-none">
                                                                mdl-account
                                                            </v-icon>
                                                            <span class="d-none d-sm-block">Subir nueva foto</span>
                                                        </v-btn>

                                                        <input ref="refInputEl" type="file" accept=".jpeg,.png,.jpg,GIF" :hidden="true" />

                                                        <v-btn color="error" outlined class="mt-5">
                                                            Eliminar foto actual
                                                        </v-btn>
                                                        <p class="text-sm mt-5">
                                                            Formatos permitidos: JPG, GIF o PNG. Tamaño máximo de 800K
                                                        </p>
                                                    </div>
                                                </v-card-text>

                                                <v-card-text>
                                                    <form method="POST" action="ProcesarRegistro">
                                                        <v-row>
                                                            <v-col cols="12" md="6">
                                                                <v-text-field readonly v-model="strCorreo" prepend-inner-icon="mdi-email" name="correo" label="Correo electrónico" type="text" outlined class="mt-4" required :rules="[strCorreo => !!strCorreo || 'Este campo es requerido']"></v-text-field>
                                                            </v-col>
                                                            <v-col cols="12" md="6">
                                                                <v-text-field v-model="strNombre" prepend-inner-icon="mdi-account" name="nombre" label="Nombre(s)" type="text" outlined class="mt-4" required :rules="[strNombre => !!strNombre || 'Este campo es requerido']"></v-text-field>
                                                            </v-col>
                                                            <v-col cols="12" md="6">
                                                                <v-text-field v-model="strPaterno" prepend-inner-icon="mdi-account" name="paterno" label="Apellido Paterno" type="text" outlined required :rules="[strPaterno => !!strPaterno || 'Este campo es requerido']"></v-text-field>
                                                            </v-col>
                                                            <v-col cols="12" md="6">
                                                                <v-text-field v-model="strMaterno" prepend-inner-icon="mdi-account" name="materno" label="Apellido Materno" type="text" outlined required :rules="[strMaterno => !!strMaterno || 'Este campo es requerido']"></v-text-field>
                                                            </v-col>
                                                            <v-col cols="12" md="6">
                                                                <v-text-field v-model="intEdad" prepend-inner-icon="mdi-account" name="edad" label="Edad" type="number" outlined required suffix="años" :rules="reglasEdad"></v-text-field>
                                                            </v-col>
                                                            <v-col cols="12" md="6">
                                                                <v-radio-group v-model="genero" row name="genero">
                                                                    <template v-slot:label>
                                                                        <div>Genero:</div>
                                                                    </template>
                                                                    <v-radio label="Masculino" value="Masculino">
                                                                    </v-radio>
                                                                    <v-radio label="Femenino" value="Femenino">
                                                                    </v-radio>
                                                                </v-radio-group>
                                                            </v-col>

                                                            <v-col cols="12">
                                                                <v-btn color="primary" class="me-3 mt-4">
                                                                    Guardar cambios
                                                                </v-btn>
                                                                <v-btn color="secondary" outlined class="mt-4" @click="resetearDatosCuenta">
                                                                    Cancelar
                                                                </v-btn>
                                                            </v-col>
                                                        </v-row>
                                                    </form>
                                                </v-card-text>
                                            </v-card>
                                        </v-tab-item>
                                        <!-- cambio de contraseña -->
                                        <v-tab-item>
                                            <v-card flat class="mt-5">
                                                <form method="POST" action="ProcesarRegistro">
                                                    <div class="px-3">
                                                        <v-card-text class="pt-5">
                                                            <v-row>
                                                                <v-col cols="12" sm="8" md="6">
                                                                    <v-text-field v-model="contrasenaAntigua" prepend-inner-icon="mdi-lock" name="contrasena" label="Escribe tu contraseña actual" outlined :append-icon="verContra ? 'mdi-eye' : 'mdi-eye-off'" :type="verContra ? 'text' : 'password'" @click:append="verContra = !verContra" required :rules="[contrasena1 => !!contrasena1 || 'Este campo es requerido']"
                                                                                  /></v-text-field>
                                                                    <v-text-field v-model="contrasena1" prepend-inner-icon="mdi-lock" name="contrasena" label="Escribe tu nueva contraseña" outlined :append-icon="ver ? 'mdi-eye' : 'mdi-eye-off'" :type="ver ? 'text' : 'password'" @click:append="ver = !ver" required :rules="[contrasena1 => !!contrasena1 || 'Este campo es requerido']"
                                                                                  /></v-text-field>
                                                                    <v-text-field v-model="contrasena2" prepend-inner-icon="mdi-lock" name="contrasena2" label="Vuelve a escribir tu nueva contraseña" outlined :append-icon="ver2 ? 'mdi-eye' : 'mdi-eye-off'" :type="ver ? 'text' : 'password'" @click:append="ver = !ver" required
                                                                                  :rules="[contrasena1 == contrasena2 || 'Las contraseñas deben ser iguales']" /></v-text-field>
                                                                </v-col>

                                                                <v-col cols="12" sm="4" md="6" class="d-none d-sm-flex justify-center position-relative">
                                                                    <v-img contain max-width="170" src="../img/logo.png" class="security-character"></v-img>
                                                                </v-col>
                                                            </v-row>
                                                        </v-card-text>
                                                    </div>

                                                    <!-- divider -->
                                                    <v-divider></v-divider>

                                                    <div class="pa-3">

                                                        <!-- action buttons -->
                                                        <v-card-text>
                                                            <v-btn color="primary" class="me-3 mt-3">
                                                                Cambiar contraseña
                                                            </v-btn>
                                                        </v-card-text>
                                                    </div>
                                                </form>
                                            </v-card>
                                        </v-tab-item>
                                        <!-- datos medicos-->
                                        <v-tab-item>
                                            <v-card flat class="pa-3 mt-2">
                                                <v-form class="multi-col-validation">
                                                    <v-card-text class="pt-5">
                                                        <v-row>
                                                            <v-col cols="12" md="6">
                                                                <v-text-field v-model="strFolio" prepend-inner-icon="mdi-account" name="folio" label="Folio de registro MiVacuna (opcional)" type="text" outlined class="mt-4" ></v-text-field>
                                                            </v-col>

                                                            <v-col cols="12" md="6">
                                                                <v-text-field v-model="intAltura" prepend-inner-icon="mdi-human-male-height" name="altura" label="Altura" type="number" step=".01" outlined required suffix="m" :rules="[intAltura => !!intAltura || 'Este campo es requerido']"></v-text-field>
                                                            </v-col>

                                                            <v-col cols="12" md="6">
                                                                <v-text-field v-model="intPeso" prepend-inner-icon="mdi-weight-kilogram" name="peso" label="Peso" type="number" step=".01" outlined class="mt-4" required suffix="kg" :rules="[intPeso => !!intPeso || 'Este campo es requerido']"></v-text-field>
                                                            </v-col>

                                                            <v-col cols="12" md="6">
                                                                <v-combobox
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
                                                                    v-model="alergias"
                                                                    :items="itemsAlergias"
                                                                    label="Alergias (opcional)"
                                                                    name="alergias"
                                                                    outlined
                                                                    multiple
                                                                    chips
                                                                    ></v-combobox>
                                                            </v-col>

                                                            <v-col cols="12" md="6">

                                                            </v-col>
                                                        </v-row>
                                                    </v-card-text>

                                                    <v-card-text>
                                                        <v-btn color="primary" class="me-3 mt-3">
                                                            Save changes
                                                        </v-btn>
                                                        <v-btn outlined class="mt-3" color="secondary" type="reset" @click.prevent="resetForm">
                                                            Cancel
                                                        </v-btn>
                                                    </v-card-text>
                                                </v-form>
                                            </v-card>
                                        </v-tab-item>
                                    </v-tabs-items>
                                </v-card>
                            </v-col>
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
            group: 2,
            nombreUsuario: '<%=dtoUsuario.getEntidad().getNombreUsuario()+ " " + dtoUsuario.getEntidad().getPaterno()%>',
            correo: '<%=correo%>',
            imagenUsuario: 'https://themeselection.com/demo/materio-vuetify-vuejs-admin-template-free/demo/img/1.e2938115.png',

            tab: '',
            tabs: [{
                    title: 'Cuenta',
                }, {
                    title: 'Contraseña',
                }, {
                    title: 'Datos médicos',
                }, ],

            strCorreo: '<%=dtoUsuario.getEntidad().getCorreo()%>',
            contrasenaAntigua: '',
            contrasena1: '',
            contrasena2: '',
            verContra: false,
            ver: false,
            ver2: false,

            strNombre: '<%=dtoUsuario.getEntidad().getNombreUsuario()%>',
            strPaterno: '<%=dtoUsuario.getEntidad().getPaterno()%>',
            strMaterno: '<%=dtoUsuario.getEntidad().getMaterno()%>',
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

            status: ['Active', 'Inactive', 'Pending', 'Closed'],
            isCurrentPasswordVisible: false,
            isNewPasswordVisible: false,
            currentPassword: false,
            isCPasswordVisible: false,
            newPassword: false,
            cPassword: false,
        }),
    methods: {
        resetearDatosCuenta() {
            this.strNombre = 'Caleb'
            this.strPaterno = 'Bolaños'
            this.strMaterno = 'Ramos'
            this.intEdad = 20
            this.genero = 'Masculino'
        }
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