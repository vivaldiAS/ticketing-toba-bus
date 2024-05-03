<template>
  <div class="auth-wrapper auth-v1">
    <div class="auth-inner">
      <v-card class="auth-card">
        <!-- logo -->
        <v-card-title class="d-flex align-center justify-center py-7">
          <router-link :to="{ name: 'pages-login' }" class="d-flex align-center">
            <v-img
              :src="require('@/assets/images/logos/logo-KBT.png').default"
              max-height="120px"
              max-width="120px"
              alt="logo"
              contain
              class="me-3"
            ></v-img>
          </router-link>
        </v-card-title>

        <!-- title -->
        <v-card-text>
          <p class="text-1xl font-weight-semibold text--primary mb-2 text-center">
            Welcome to E-KBT
          </p>
          <p class="mb-2 text-center">Kepuasan Penumpang adalah Kebahagian Kami</p>
        </v-card-text>
        <v-card-text>
          <v-form ref="form" @submit.prevent="login">
            <v-text-field
              v-model="email"
              outlined
              label="Email"
              placeholder="john@example.com"
              hide-details
              :error-messages="errors.email"
              class="mb-1"
            ></v-text-field>
            <label class="text-danger" v-if="errors.email" type="error" dismissible>
              Email tidak boleh kosong!
            </label>

            <v-text-field
              v-model="password"
              outlined
              :type="isPasswordVisible ? 'text' : 'password'"
              label="Password"
              class="mb-1 mt-3"
              :error-messages="errors.password"
              placeholder="********"
              :append-icon="
                isPasswordVisible ? icons.mdiEyeOffOutline : icons.mdiEyeOutline
              "
              hide-details
              @click:append="isPasswordVisible = !isPasswordVisible"
            ></v-text-field>
            <label class="text-danger" v-if="errors.password" type="error" dismissible>
              Password tidak boleh kosong!
            </label>

            <div class="d-flex align-center justify-space-between flex-wrap">
              <v-checkbox
                label="Ingat saya"
                hide-details
                class="me-3 mt-1"
                v-model="rememberMe"
              ></v-checkbox>

              <!-- forgot link -->
              <router-link :to="{ name: 'pages-forgot-password' }">
                Lupa Password?
              </router-link>
            </div>

            <v-btn type="submit" block color="primary" class="mt-6" :loading="isLoading">
              <template v-if="!isLoading"> Login </template>
              <template v-if="isLoading">
                <v-progress-circular
                  indeterminate
                  size="24"
                  color="white"
                ></v-progress-circular>
              </template>
            </v-btn>
          </v-form>
        </v-card-text>

        <!-- create new account  -->
        <v-card-text class="d-flex align-center justify-center flex-wrap mt-2">
          <span class="me-2"> Belum memiliki akun?</span>
          <router-link :to="{ name: 'pages-register' }"> Daftar sekarang</router-link>
        </v-card-text>
      </v-card>
    </div>
  </div>
</template>

<script>
import { mdiEyeOutline, mdiEyeOffOutline } from "@mdi/js";
import { ref } from "@vue/composition-api";
import axios from "axios";
import Swal from "sweetalert2";

export default {
  setup() {
    const isPasswordVisible = ref(false);
    const email = ref("");
    const password = ref("");
    const rememberMe = ref(false);

    return {
      isPasswordVisible,
      email,
      password,
      rememberMe,
      icons: {
        mdiEyeOutline,
        mdiEyeOffOutline,
      },
    };
  },
  data() {
    return {
      registrationSuccess: false,
      errors: {},
      isLoading: false,
    };
  },
  methods: {
    login() {
      this.isLoading = true;

      const data = {
        email: this.email,
        password: this.password,
      };

      if (this.rememberMe) {
        data.remember_me = true;
      }

      axios
        .post("/api/login", data)
        .then((response) => {
          if (this.rememberMe) {
            // Save user data to localStorage when "Ingat saya" is checked
            const userData = {
              access_token: response.data.access_token,
              expires_at: response.data.expires_at,
            };
            localStorage.setItem("user_data", JSON.stringify(userData));
          }

          const token = response.data.access_token;
          localStorage.setItem("access_token", token);
          this.$store.dispatch("updateUserRole", token);
          localStorage.setItem("expires_at", response.data.expires_at);
          this.$router.push("/dashboard");
        })
        .catch((error) => {
          if (error.response.status === 422) {
            this.errors = error.response.data.errors;
            Swal.fire({
              icon: "error",
              title: "Login Gagal",
              text: this.errors.account
                ? this.errors.account[0]
                : "Email dan Password tidak boleh kosong!",
              confirmButtonText: "Ok",
              confirmButtonColor: "#d33",
            });
          } else if (error.response.status === 401) {
            this.errors = error.response.data.errors;
            Swal.fire({
              icon: "error",
              title: "Login gagal",
              text: this.errors.credentials
                ? this.errors.credentials[0]
                : "Email atau Password salah!",
              confirmButtonText: "Ok",
              confirmButtonColor: "#d33",
            });
          } else {
            this.errors = { general: ["Something went wrong. Please try again later."] };
          }
          this.isLoading = false;
        });
    },
    checkSavedUserData() {
      const userDataString = localStorage.getItem("user_data");
      if (userDataString) {
        const userData = JSON.parse(userDataString);
        const expirationDate = new Date(userData.expires_at);
        if (expirationDate > new Date()) {
          // Token is still valid, automatically log in the user
          this.$store.dispatch("updateUserRole", userData.access_token);
          this.$router.push("/dashboard");
        } else {
          // Token has expired, remove saved user data
          localStorage.removeItem("user_data");
        }
      }
    },
  },
  mounted() {
    this.checkSavedUserData();
  },
};
</script>

<style lang="scss">
@import "~@resources/sass/preset/pages/auth.scss";
</style>
