<template>
  <div class="auth-wrapper auth-v1">
    <div class="auth-inner">
      <v-card class="auth-card">
        <!-- logo -->
        <v-form ref="form" @submit.prevent="submitPassword">
          <div class="body1">
            <h3 class="judul" color="primary">Atur Ulang Password</h3>
            <div class="email-container">
              <v-text-field
                :type="isPasswordNewVisible ? 'text' : 'password'"
                v-model="password"
                label="Password baru"
                class="mb-1 mt-3"
                placeholder="********"
                :append-icon="
                  isPasswordNewVisible ? icons.mdiEyeOffOutline : icons.mdiEyeOutline
                "
                :error-messages="errors.password"
                @click:append="isPasswordNewVisible = !isPasswordNewVisible"
              ></v-text-field>
              <v-text-field
                :type="isPasswordVisible ? 'text' : 'password'"
                v-model="password_confirmation"
                label="Konfirmasi Password"
                class="mb-1 mt-3"
                placeholder="********"
                :append-icon="
                  isPasswordVisible ? icons.mdiEyeOffOutline : icons.mdiEyeOutline
                "
                :error-messages="errors.password_confirmation"
                @click:append="isPasswordVisible = !isPasswordVisible"
              ></v-text-field>
            </div>
            <div class="text-center mt-3">
              <div class="text-center">
                <v-btn class="mt-2" color="primary" type="submit"> Simpan </v-btn>
              </div>
            </div>
          </div>
        </v-form>
      </v-card>
    </div>
  </div>
</template>

<script>
import {
  mdiKeyVariant,
  mdiCogOutline,
  mdiPowerStandby,
  mdiPencil,
  mdiEyeOutline,
  mdiEyeOffOutline,
  mdiClose,
} from "@mdi/js";
import { ref } from "@vue/composition-api";
import axios from "axios";
import Swal from "sweetalert2";
import VueOtp2 from "vue-otp-2";
export default {
  setup() {
    const email = ref("");
    const isPasswordNewVisible = ref(false);
    const isPasswordVisible = ref(false);
    const errors = ref({});

    return {
      email,
      isPasswordNewVisible,
      isPasswordVisible,
      icons: {
        mdiKeyVariant,
        mdiCogOutline,
        mdiPowerStandby,
        mdiPencil,
        mdiEyeOutline,
        mdiEyeOffOutline,
        mdiClose,
      },
      passwordConfirm: "",
      passwordNew: "",
      errors,
    };
  },
  data() {
    return {
      email: "",
      errors: {},
      isLoading: false,
    };
  },
  mounted() {},
  methods: {
    submitPassword() {
      const email = this.$route.params.email;

      axios
        .post(`/api/reset/update-password/${email}`, {
          password: this.password,
          password_confirmation: this.password_confirmation,
        })
        .then((response) => {
          console.log(response.data);
          Swal.fire({
            icon: "success",
            title: response.data.message,
          });
          this.$router.push("/");
        })
        .catch((error) => {
          this.errors = error.response.data.data;
          this.errors_general = error.response.data.message;
          console.log(this.errors);
        });
    },
  },
};
</script>

<style lang="scss" scoped>
@import "~@resources/sass/preset/pages/auth.scss";

.body1 {
  padding: 40px;
}
.judul {
  margin-bottom: 40px;
  text-align: center;
}
.body {
  margin-bottom: 40px;
  text-align: center;
}
.btn-kirim {
  width: 50%;
  text-align: center;
  margin-top: 20px;
  margin-bottom: 30px;
}
.otp-input {
  width: 40px;
  height: 40px;
  padding: 5px;
  margin: 0 10px;
  font-size: 20px;
  border-radius: 4px;
  border: 1px solid rgba(0, 0, 0, 0.3);
  text-align: center;
  &.error {
    border: 1px solid red !important;
  }
}
.otp-input::-webkit-inner-spin-button,
.otp-input::-webkit-outer-spin-button {
  -webkit-appearance: none;
  margin: 0;
}
</style>
