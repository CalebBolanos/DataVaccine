<%-- 
    Document   : configuracionCuenta
    Created on : 25 nov. 2021, 09:07:41
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
                        <v-avatar class="hidden-sm-and-down" color="accent darken-1 shrink" size="32">
                            <v-icon dark>
                                mdi-account-circle
                            </v-icon>
                        </v-avatar>
                      </v-btn>
                    </template>

                            <v-list>
                                <v-list-item>
                                    <v-list-item-content>
                                        <v-list-item-title class="text-h6">
                                            Nombre de usuario
                                        </v-list-item-title>
                                        <v-list-item-subtitle>
                                            correo@dominio.com
                                        </v-list-item-subtitle>
                                    </v-list-item-content>
                                </v-list-item>

                                <v-divider></v-divider>
                                <v-list-item @click="">
                                    <v-list-item-title>Información de la cuenta</v-list-item-title>
                                </v-list-item>
                                <v-list-item @click="">
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
                                <v-list-item>
                                    <v-list-item-icon>
                                        <v-icon>mdi-home</v-icon>
                                    </v-list-item-icon>
                                    <v-list-item-title>Inicio</v-list-item-title>
                                </v-list-item>

                                <v-list-item>
                                    <v-list-item-icon>
                                        <v-icon>mdi-clipboard-list</v-icon>
                                    </v-list-item-icon>
                                    <v-list-item-title>Lista de Vacunas</v-list-item-title>
                                </v-list-item>

                                <v-list-item>
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
                                            <v-tab-item>
                                                <v-card flat class="pa-3 mt-2">
                                                    <v-card-text class="d-flex">
                                                        <v-avatar rounded size="120" class="me-6">
                                                            <v-img src="../img/logo_full.png"></v-img>
                                                        </v-avatar>

                                                        <!-- upload photo -->
                                                        <div>
                                                            <v-btn color="primary" class="me-3 mt-5" @click="">
                                                                <v-icon class="d-sm-none">
                                                                    mdl-account
                                                                </v-icon>
                                                                <span class="d-none d-sm-block">Upload new photo</span>
                                                            </v-btn>

                                                            <input ref="refInputEl" type="file" accept=".jpeg,.png,.jpg,GIF" :hidden="true" />

                                                            <v-btn color="error" outlined class="mt-5">
                                                                Reset
                                                            </v-btn>
                                                            <p class="text-sm mt-5">
                                                                Allowed JPG, GIF or PNG. Max size of 800K
                                                            </p>
                                                        </div>
                                                    </v-card-text>

                                                    <v-card-text>
                                                        <v-form class="multi-col-validation mt-6">
                                                            <v-row>
                                                                <v-col md="6" cols="12">
                                                                    <v-text-field label="Username" dense outlined></v-text-field>
                                                                </v-col>

                                                                <v-col md="6" cols="12">
                                                                    <v-text-field label="Name" dense outlined></v-text-field>
                                                                </v-col>

                                                                <v-col cols="12" md="6">
                                                                    <v-text-field label="E-mail" dense outlined></v-text-field>
                                                                </v-col>

                                                                <v-col cols="12" md="6">
                                                                    <v-text-field dense label="Role" outlined></v-text-field>
                                                                </v-col>

                                                                <v-col cols="12" md="6">
                                                                    <v-select dense outlined label="Status" :items="status"></v-select>
                                                                </v-col>

                                                                <v-col cols="12" md="6">
                                                                    <v-text-field dense outlined label="Company"></v-text-field>
                                                                </v-col>

                                                                <!-- alert -->
                                                                <v-col cols="12">
                                                                    <v-alert color="warning" text class="mb-0">
                                                                        <div class="d-flex align-start">
                                                                            <v-icon color="warning">
                                                                                mdl-warning
                                                                            </v-icon>

                                                                            <div class="ms-3">
                                                                                <p class="text-base font-weight-medium mb-1">
                                                                                    Your email is not confirmed. Please check your inbox.
                                                                                </p>
                                                                                <a href="javascript:void(0)" class="text-decoration-none warning--text">
                                                                                    <span class="text-sm">Resend Confirmation</span>
                                                                                </a>
                                                                            </div>
                                                                        </div>
                                                                    </v-alert>
                                                                </v-col>

                                                                <v-col cols="12">
                                                                    <v-btn color="primary" class="me-3 mt-4">
                                                                        Save changes
                                                                    </v-btn>
                                                                    <v-btn color="secondary" outlined class="mt-4" type="reset" @click.prevent="resetForm">
                                                                        Cancel
                                                                    </v-btn>
                                                                </v-col>
                                                            </v-row>
                                                        </v-form>
                                                    </v-card-text>
                                                </v-card>
                                            </v-tab-item>

                                            <v-tab-item>
                                                <v-card flat class="mt-5">
                                                    <v-form>
                                                        <div class="px-3">
                                                            <v-card-text class="pt-5">
                                                                <v-row>
                                                                    <v-col cols="12" sm="8" md="6">
                                                                        <!-- current password -->
                                                                        <v-text-field v-model="currentPassword" :type="isCurrentPasswordVisible ? 'text' : 'password'" :append-icon="isCurrentPasswordVisible ? 'mdl-account':'mdl-account'" label="Current Password" outlined dense @click:append="isCurrentPasswordVisible = !isCurrentPasswordVisible"></v-text-field>

                                                                        <!-- new password -->
                                                                        <v-text-field v-model="newPassword" :type="isNewPasswordVisible ? 'text' : 'password'" :append-icon="isNewPasswordVisible ? 'mdl-account':'mdl-account'" label="New Password" outlined dense hint="Make sure it's at least 8 characters." persistent-hint @click:append="isNewPasswordVisible = !isNewPasswordVisible"></v-text-field>

                                                                        <!-- confirm password -->
                                                                        <v-text-field v-model="cPassword" :type="isCPasswordVisible ? 'text' : 'password'" :append-icon="isCPasswordVisible ? 'mdl-account':'mdl-account'" label="Confirm New Password" outlined dense class="mt-3" @click:append="isCPasswordVisible = !isCPasswordVisible"></v-text-field>
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
                                                                    Save changes
                                                                </v-btn>
                                                                <v-btn color="secondary" outlined class="mt-3">
                                                                    Cancel
                                                                </v-btn>
                                                            </v-card-text>
                                                        </div>
                                                    </v-form>
                                                </v-card>
                                            </v-tab-item>

                                            <v-tab-item>
                                                <v-card flat class="pa-3 mt-2">
                                                    <v-form class="multi-col-validation">
                                                        <v-card-text class="pt-5">
                                                            <v-row>
                                                                <v-col cols="12">
                                                                    <v-textarea outlined rows="3" label="Bio"></v-textarea>
                                                                </v-col>

                                                                <v-col cols="12" md="6">
                                                                    <v-text-field outlined dense label="Birthday"></v-text-field>
                                                                </v-col>

                                                                <v-col cols="12" md="6">
                                                                    <v-text-field outlined dense label="Phone"></v-text-field>
                                                                </v-col>

                                                                <v-col cols="12" md="6">
                                                                    <v-text-field outlined dense label="Website"></v-text-field>
                                                                </v-col>

                                                                <v-col cols="12" md="6">
                                                                    <v-select outlined dense label="Country" :items="['USA','UK','AUSTRALIA','BRAZIL']"></v-select>
                                                                </v-col>

                                                                <v-col cols="12" md="6">
                                                                    <v-select outlined dense multiple chips small-chips label="Languages" :items="['English','Spanish','French','German']"></v-select>
                                                                </v-col>

                                                                <v-col cols="12" md="6">
                                                                    <p class="text--primary mt-n3 mb-2">
                                                                        Gender
                                                                    </p>
                                                                    <v-radio-group row class="mt-0" hide-details>
                                                                        <v-radio value="male" label="Male">
                                                                        </v-radio>
                                                                        <v-radio value="female" label="Female">
                                                                        </v-radio>
                                                                        <v-radio value="other" label="Other">
                                                                        </v-radio>
                                                                    </v-radio-group>
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
                        tab: '',
                        tabs: [{
                            title: 'Cuenta',
                        }, {
                            title: 'Contraseña',
                        }, {
                            title: 'Datos médicos',
                        }, ],
                        status: ['Active', 'Inactive', 'Pending', 'Closed'],
                        isCurrentPasswordVisible: false,
                        isNewPasswordVisible: false,
                        currentPassword: false,
                        isCPasswordVisible: false,
                        newPassword: false,
                        cPassword: false,
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