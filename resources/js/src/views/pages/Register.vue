<template>
  <div class="auth-wrapper auth-v1">
    <div class="auth-inner">
      <v-card class="auth-card">
        <!-- logo -->
        <v-card-title class="d-flex align-center justify-center py-7">
          <router-link to="/" class="d-flex align-center">
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
          <h3 class="mb-2 text-center">Kepuasan Penumpang adalah Kebahagian Kami</h3>
        </v-card-text>

        <!-- regis form -->
        <v-card-text>
          <v-form>
            <v-row>
              <v-col cols="12" md="12">
                <v-text-field
                  v-model="user.name"
                  :prepend-inner-icon="icons.mdiAccountOutline"
                  label="Nama Lengkap"
                  outlined
                  dense
                  placeholder="Nama Lengkap"
                  :error-messages="errors.name"
                ></v-text-field>
              </v-col>
              <v-col cols="12" md="6">
                <v-text-field
                  v-model="user.email"
                  :prepend-inner-icon="icons.mdiEmailOutline"
                  label="Email"
                  type="email"
                  outlined
                  dense
                  placeholder="Email"
                  :error-messages="errors.email"
                ></v-text-field>
              </v-col>
              <v-col cols="12" md="6">
                <v-text-field
                  v-model="user.phone_number"
                  :prepend-inner-icon="icons.mdiCellphone"
                  label="Nomor Handphone"
                  outlined
                  dense
                  type="number"
                  placeholder="Nomor Handphone"
                  :error-messages="errors.phone_number"
                ></v-text-field>
              </v-col>

              <v-col cols="12" md="6">
                <v-select
                  v-model="user.gender"
                  :items="['Laki-laki', 'Perempuan']"
                  :prepend-inner-icon="icons.mdiHumanMaleFemale"
                  label="Jenis Kelamin"
                  outlined
                  dense
                  placeholder="Jenis Kelamin"
                  :error-messages="errors.gender"
                ></v-select>
              </v-col>

              <v-col cols="12" md="6">
                <v-text-field
                  v-model="user.address"
                  :prepend-inner-icon="icons.mdiMapMarker"
                  label="Alamat"
                  outlined
                  dense
                  type="text"
                  placeholder="Alamat"
                  :error-messages="errors.address"
                ></v-text-field>
              </v-col>

              <v-col cols="12" md="6">
                <v-text-field
                  v-model="user.password"
                  :prepend-inner-icon="icons.mdiLockOutline"
                  label="Password"
                  outlined
                  dense
                  type="password"
                  placeholder="password"
                  :error-messages="errors.password"
                ></v-text-field>
              </v-col>

              <v-col cols="12" md="6">
                <v-text-field
                  v-model="user.confirm_password"
                  :prepend-inner-icon="icons.mdiLockOutline"
                  label="Konfirmasi Password"
                  outlined
                  dense
                  type="password"
                  placeholder="Konfirmasi password"
                  :error-messages="errors.confirm_password"
                ></v-text-field>
              </v-col>
            </v-row>

            <v-btn block color="primary" class="mt-6" @click.prevent="registrasi">
              Sign Up
            </v-btn>
          </v-form>
        </v-card-text>

        <!-- create new account  -->
        <v-card-text class="d-flex align-center justify-center flex-wrap mt-2">
          <span class="me-2"> Sudah punya akun?</span>
          <router-link :to="{ name: 'pages-login' }"> Masuk disini </router-link>
        </v-card-text>
      </v-card>
    </div>
  </div>
</template>
<script>
import {
  mdiFacebook,
  mdiTwitter,
  mdiGithub,
  mdiGoogle,
  mdiEyeOutline,
  mdiEyeOffOutline,
  mdiAccountOutline,
  mdiEmailOutline,
  mdiCellphone,
  mdiLockOutline,
  mdiHumanMaleFemale,
  mdiMapMarker,
} from "@mdi/js";
import { ref } from "@vue/composition-api";
import axios from "axios";
export default {
  setup() {
    const isPasswordVisible = ref(false);
    const errors = ref({});
    const user = [
      "name",
      "email",
      "phone_number",
      "address",
      "gender",
      "password",
      "confirm_password",
    ];

    const socialLink = [
      {
        icon: mdiFacebook,
        color: "#4267b2",
        colorInDark: "#4267b2",
      },
      {
        icon: mdiTwitter,
        color: "#1da1f2",
        colorInDark: "#1da1f2",
      },
      {
        icon: mdiGithub,
        color: "#272727",
        colorInDark: "#fff",
      },
      {
        icon: mdiGoogle,
        color: "#db4437",
        colorInDark: "#db4437",
      },
    ];
    return {
      isPasswordVisible,
      user: {},
      errors,

      icons: {
        mdiEyeOutline,
        mdiEyeOffOutline,
        mdiAccountOutline,
        mdiEmailOutline,
        mdiCellphone,
        mdiHumanMaleFemale,
        mdiLockOutline,
        mdiMapMarker,
      },
    };
  },
  methods: {
    registrasi() {
      axios
        .post("/api/registrasi", {
          name: this.user.name,
          email: this.user.email,
          phone_number: this.user.phone_number,
          address: this.user.address,
          gender: this.user.gender,
          password: this.user.password,
          confirm_password: this.user.confirm_password,
        })
        .then((response) => {
          this.registrationSuccess = true;
          this.notificationMessage = "Registrasi berhasil!";
          this.$router.push({
            name: "pages-login",
          });
        })
        .catch((error) => {
          if (error.response.status === 422) {
            this.errors = error.response.data.data;
            this.errors_general = error.response.data.message;
            console.log(this.errors);
          }
        });
    },
  },
};
</script>

<style lang="scss">
@import "~@resources/sass/preset/pages/auth.scss";
.v-messages.error--text {
  color: red; /* Customize the error message text color */
}
.alert_error {
  color: red;
  align-items: center;
}
</style>
