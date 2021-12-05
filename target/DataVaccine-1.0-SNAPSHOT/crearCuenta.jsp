<%-- 
    Document   : crearCuenta
    Created on : 4 dic. 2021, 09:11:22
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
                <v-main class="grey lighten-2">
                    <v-container fluid fill-height>
                        <v-layout align-center justify-center>
                            <v-flex xs12 sm10 md6>
                                <form method="POST" action="ProcesarRegistro">
                                    <v-card class="elevation-0" rounded="lg">
                                        <v-card-title class="d-flex align-center justify-center py-7">
                                            <v-img src="./img/logo.png" max-height="70px" max-width="70px" alt="logo" contain class="me-3 "></v-img>

                                            <h2 class="text-2xl font-weight-semibold">
                                                DataVaccine
                                            </h2>
                                        </v-card-title>
                                        <v-card-text>
                                            <p class="title font-weight-semibold text--primary mb-2">
                                                Registrate en DataVaccine
                                            </p>
                                            <p class="mb-2">
                                                Llena el siguiente formulario para ingresar a la plataforma
                                            </p>
                                        </v-card-text>
                                        <v-card-text>
                                            <v-stepper v-model="e1">
                                                <v-stepper-header>
                                                    <v-stepper-step :complete="e1 > 1" step="1">
                                                        Datos de la cuenta
                                                    </v-stepper-step>

                                                    <v-divider></v-divider>

                                                    <v-stepper-step :complete="e1 > 2" step="2">
                                                        Datos personales
                                                    </v-stepper-step>

                                                    <v-divider></v-divider>

                                                    <v-stepper-step step="3">
                                                        Datos médicos
                                                    </v-stepper-step>
                                                </v-stepper-header>

                                                <v-stepper-items>
                                                    <!--Datos de la cuenta -->
                                                    <v-stepper-content step="1">
                                                        <v-text-field v-model="strCorreo" prepend-inner-icon="mdi-email" name="correo" label="Escribe tu correo electrónico" type="text" outlined class="mt-4" required :rules="[strCorreo => !!strCorreo || 'Este campo es requerido']"></v-text-field>
                                                        <v-text-field v-model="contrasena1" prepend-inner-icon="mdi-lock" name="contrasena" label="Escribe tu contraseña" outlined :append-icon="ver ? 'mdi-eye' : 'mdi-eye-off'" :type="ver ? 'text' : 'password'" @click:append="ver = !ver" required :rules="[contrasena1 => !!contrasena1 || 'Este campo es requerido']"
                                                                      /></v-text-field>
                                                        <v-text-field v-model="contrasena2" prepend-inner-icon="mdi-lock" name="contrasena2" label="Vuelve a escribir tu contraseña" outlined :append-icon="ver2 ? 'mdi-eye' : 'mdi-eye-off'" :type="ver ? 'text' : 'password'" @click:append="ver = !ver" required
                                                                      :rules="[contrasena1 == contrasena2 || 'Las contraseñas deben ser iguales']" /></v-text-field>

                                                        <v-btn color="primary" @click="e1 = 2">
                                                            Siguiente
                                                        </v-btn>
                                                    </v-stepper-content>
                                                    <!--Datos personales -->
                                                    <v-stepper-content step="2">
                                                        <v-text-field v-model="strNombre" prepend-inner-icon="mdi-account" name="nombre" label="Nombre(s)" type="text" outlined class="mt-4" required :rules="[strNombre => !!strNombre || 'Este campo es requerido']"></v-text-field>
                                                        <v-text-field v-model="strPaterno" prepend-inner-icon="mdi-account" name="paterno" label="Apellido Paterno" type="text" outlined required :rules="[strPaterno => !!strPaterno || 'Este campo es requerido']"></v-text-field>
                                                        <v-text-field v-model="strMaterno" prepend-inner-icon="mdi-account" name="materno" label="Apellido Materno" type="text" outlined required :rules="[strMaterno => !!strMaterno || 'Este campo es requerido']"></v-text-field>
                                                        <v-text-field v-model="intEdad" prepend-inner-icon="mdi-account" name="edad" label="Edad" type="number" outlined required suffix="años" :rules="reglasEdad"></v-text-field>
                                                        <v-radio-group v-model="genero" row name="genero">
                                                            <template v-slot:label>
                                                                <div>Genero:</div>
                                                            </template>
                                                            <v-radio label="Masculino" value="Masculino">
                                                            </v-radio>
                                                            <v-radio label="Femenino" value="Femenino">
                                                            </v-radio>
                                                        </v-radio-group>
                                                        <v-btn color="primary" @click="e1 = 3">
                                                            Siguiente
                                                        </v-btn>
                                                        <v-btn text @click="e1 =1">
                                                            Regresar
                                                        </v-btn>
                                                    </v-stepper-content> 
                                                    <!--Datos médicos -->
                                                    <v-stepper-content step="3">
                                                        <v-text-field v-model="strFolio" prepend-inner-icon="mdi-account" name="folio" label="Folio de registro MiVacuna (opcional)" type="text" outlined class="mt-4" ></v-text-field>
                                                        <v-text-field v-model="intAltura" prepend-inner-icon="mdi-human-male-height" name="altura" label="Altura" type="number" step=".01" outlined required suffix="m" :rules="[intAltura => !!intAltura || 'Este campo es requerido']"></v-text-field>
                                                        <v-text-field v-model="intPeso" prepend-inner-icon="mdi-weight-kilogram" name="peso" label="Peso" type="number" step=".01" outlined class="mt-4" required suffix="kg" :rules="[intPeso => !!intPeso || 'Este campo es requerido']"></v-text-field>
                                                        <v-combobox
                                                            v-model="grupoSanguineo"
                                                            :items="itemsGrupoSanguineo"
                                                            label="Grupo sanguíneo"
                                                            name="grupoSanguineo"
                                                            outlined
                                                            required
                                                        ></v-combobox>
                                                        <v-combobox
                                                            v-model="alergias"
                                                            :items="itemsAlergias"
                                                            label="Alergias (opcional)"
                                                            name="alergias"
                                                            outlined
                                                            multiple
                                                            chips
                                                            ></v-combobox>
                                                        <v-btn color="primary" type="submit" color="primary">
                                                            Registrarse
                                                        </v-btn>
                                                        <v-btn text @click="e1 =2">
                                                            Regresar
                                                        </v-btn>
                                                    </v-stepper-content>
                                                </v-stepper-items>
                                            </v-stepper>
                                            <!-- <v-card-actions>
                                            <v-spacer></v-spacer>
                                            <v-btn type="submit" block color="primary">Iniciar Sesion</v-btn>
                                            <v-spacer></v-spacer>
                                        </v-card-actions> -->
                                            <span class="d-flex align-center justify-center flex-wrap mt-3">
                                                <span class="me-2">
                                                    ¿Ya tienes una cuenta?
                                                </span>
                                                <a href="iniciarSesion.jsp" style="color:#FF5023">Iniciar Sesión</a>
                                            </span>
                                        </v-card-text>
                                    </v-card>
                                </form>
                            </v-flex>
                        </v-layout>
                    </v-container>
                </v-main>
            </v-app>
        </div>
        <script>
            new Vue({
                el: '#app',
                data: () => ({
                        ver: false,
                        ver2: false,
                        e1: 1,
                        strCorreo: '',
                        contrasena1: '',
                        contrasena2: '',

                        strNombre: '',
                        strPaterno: '',
                        strMaterno: '',
                        intEdad: null,
                        reglasEdad: [
                            v => !!v || "Este campo es requerido",
                            v => (v && v >= 18) || "Debes de tener al menos 18 años",
                        ],
                        genero: null,

                        strFolio: '',
                        intAltura: null,
                        intPeso: null,
                        grupoSanguineo: '',
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
                        alergias: [],
                        itemsAlergias: [
                          'Programming',
                          'Design',
                          'Vue',
                          'Vuetify',
                        ],
                    }),
                computed: {
                    passwordConfirmationRule() {
                        return () => (this.contrasena1 === this.contrasena1) || 'Las contraseñas deben ser iguales'
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