<template>
  <div class="auth-wrapper auth-v1">
    <div class="auth-inner">
      <v-card class="auth-card">
        <!-- logo -->
        <v-form ref="form" v-if="isOTP">
          <div class="body1">
            <h3 class="judul" color="primary">Masukkan Kode 4 Digit</h3>
            <p class="body">
              Masukkan 4 digit kode verifikasi yang dikirim ke email terdaftar Anda.
            </p>
            <div class="otp-container">
              <vue-otp2
                ref="otpInput"
                :length="4"
                :input-style="{
                  width: '30px',
                  height: '50px',
                  borderRadius: '4px',
                  textAlign: 'center',
                  fontSize: '18px',
                }"
                @onComplete="onOtpInput"
              />
            </div>
            <div class="text-center mt-3">
              <span v-if="!isResending">
                Tidak menerima OTP?
                <span color="primary" style="font-weight: bold" @click="submitAgain"
                  >Kirim ulang</span
                >
                <span v-if="countdown !== '00:00'">({{ countdown }})</span>
              </span>
              <span style="color: #ff4c51" v-else>
                Kirim ulang dalam <span>{{ countdown }}</span>
              </span>
            </div>
            <p color="info" class="text-center" @click="back">Kembali</p>
          </div>
        </v-form>
        <v-form ref="form" @submit.prevent="submitEmail" v-else>
          <div class="body1">
            <h3 class="judul" color="primary">Lupa Password</h3>
            <p class="body">
              Masukkan alamat email yang terkait dengan akun Anda dan kami akan
              mengirimkan tautan untuk mengatur ulang kata sandi Anda
            </p>
            <v-text-field
              v-model="email"
              outlined
              label="Email"
              placeholder="john@example.com"
              :error-messages="errors.email"
              class="mb-1"
            ></v-text-field>
            <center>
              <v-btn
                type="submit"
                color="primary"
                class="mt-6 btn-kirim"
                :loading="isLoading"
              >
                <template v-if="!isLoading"> Kirim </template>
                <template v-if="isLoading">
                  <v-progress-circular
                    indeterminate
                    size="24"
                    color="white"
                  ></v-progress-circular>
                </template>
              </v-btn>
            </center>
          </div>
        </v-form>
      </v-card>
    </div>
  </div>
</template>

<script>
import { ref } from "@vue/composition-api";
import axios from "axios";
import Swal from "sweetalert2";
import VueOtp2 from "vue-otp-2";
export default {
  components: {
    VueOtp2,
  },
  setup() {
    const email = ref("");
    const otpCode = ref("");
    return {
      email,
      otpCode,
      isOTP: false,
      countdown: "01:00", // Initial countdown time in mm:ss format
      isResending: false, // Flag to indicate if the OTP is currently being resent
      timer: null, // Variable to store the timer ID
    };
  },
  data() {
    return {
      email: "",
      errors: {},
      isLoading: false,
    };
  },
  mounted() {
    this.startCountdown();
  },
  methods: {
    submitEmail() {
      this.isLoading = true;
      axios
        .post("api/reset-password", {
          email: this.email,
        })
        .then((response) => {
          //Check email if registered
          console.log(response.data.message);
          console.log(this.otpCode);
          Swal.fire({
            icon: "success",
            title: "Berhasil",
            text: "Berhasil mengirimkan OTP ",
            confirmButtonText: "Ok",
            confirmButtonColor: "#d33",
          });
          this.isLoading = false;
          this.isOTP = true;
        })
        .catch((error) => {
          if (error.response.status === 422) {
            this.errors = error.response.data.data;
            this.errors_general = error.response.data.message;
            console.log(this.errors);
          }
          Swal.fire({
            icon: "error",
            title: "Gagal",
            text: this.errors,
            confirmButtonText: "Ok",
            confirmButtonColor: "#d33",
          });
          this.isLoading = false;
          this.isOTP = false;
          Swal.fire({
            icon: "error",
            title: "Gagal",
            text: "Email tidak terdaftar",
            confirmButtonText: "Ok",
            confirmButtonColor: "#d33",
          });
          this.isLoading = false;
        });
    },
    submitAgain() {
      axios
        .post("api/reset-password", {
          email: this.email,
        })
        .then((response) => {
          //Check email if registered
          console.log(response.data.message);
          console.log(this.otpCode);
          Swal.fire({
            icon: "success",
            title: "Berhasil",
            text: "Berhasil mengirimkan OTP ",
            confirmButtonText: "Ok",
            confirmButtonColor: "#d33",
          });
        });
        this.startCountdown();
    },
    back() {
      this.isOTP = false;
    },
    onOtpInput(value) {
      const enteredOtpValueArray = this.$refs.otpInput.otp;
      const enteredOtpValue = enteredOtpValueArray.join("");
      console.log("Entered OTP:", enteredOtpValue);
      this.otpCode = enteredOtpValue;
      if (this.otpCode.length === 4) {
        this.submitOtp();
      }
    },
    submitOtp() {
      axios
        .post("api/getOtp", {
          email: this.email,
          otp: this.otpCode,
        })
        .then((response) => {
          this.msg = response.data;
          console.log(this.msg);
          Swal.fire({
            icon: "success",
            title: "Berhasil",
            text: "OTP sesuai.",
            confirmButtonText: "Ok",
            confirmButtonColor: "#307475",
          });
          this.$router.push(`/reset-password/${this.email}`);
        })
        .catch((error) => {
          if (error.response.status === 422) {
            this.errors = error.response.data.data;
            this.errors_general = error.response.data.message;
            console.log(this.errors);
          }
          Swal.fire({
            icon: "error",
            title: "Gagal",
            text: this.errors_general,
            confirmButtonText: "Ok",
            confirmButtonColor: "#d33",
          });
          console.log(error);
        });
    },
    resendOTP() {
      this.startCountdown();
    },
    startCountdown() {
      let remainingSeconds = 60; // Set the initial number of seconds for the countdown
      this.isResending = true; // Set the flag to true to show the "Tunggu sebentar..." message
      this.timer = setInterval(() => {
        const minutes = Math.floor(remainingSeconds / 60);
        const seconds = remainingSeconds % 60;
        this.countdown = `${minutes
          .toString()
          .padStart(2, "0")}:${seconds.toString().padStart(2, "0")}`;

        remainingSeconds--;

        if (remainingSeconds < 0) {
          this.stopCountdown();
        }
      }, 1000);
    },
    stopCountdown() {
      clearInterval(this.timer);
      this.countdown = "00:00"; // Set the countdown to 00:00 when the timer is stopped
      this.isResending = false; // Set the flag to false to show the "Kirim ulang" link again
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
