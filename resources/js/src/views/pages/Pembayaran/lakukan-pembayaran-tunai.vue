<template>
  <div>
    <v-card v-for="item in schedule" :key="item.id">
      <v-card-title>Lakukan Pembayaran ke Loket {{ item.derpature }}</v-card-title>
      <div class="container mt-3 text-center">
        <h2>{{ item.derpature }} -> {{ item.arrival }}</h2>
        <h5>{{ formatHour(item.tanggal) }}</h5>
        <h5>{{ formatDate(item.tanggal) }}</h5>
        <h5>{{ (item.harga * selectedSeat.length) | toRupiah }}</h5>

        <v-container class="grey lighten-5">
          <v-row no-gutters>
            <v-col cols="12" sm="4">
              <v-card class="pa-2" outlined tile>
                <h5>Nama</h5>
                <h6>{{ passengerData.name }}</h6>
              </v-card>
            </v-col>
            <v-col cols="12" sm="4">
              <v-card class="pa-2" outlined tile>
                <h5>Nomor Handphone</h5>
                <h6>{{ passengerData.number_phone }}</h6>
              </v-card>
            </v-col>
            <v-col cols="12" sm="4">
              <v-card class="pa-2" outlined tile>
                <h5>No. Tempat duduk</h5>
                <h6>{{ selectedSeat }}</h6>
              </v-card>
            </v-col>
          </v-row>
        </v-container>

        <v-col cols="12" md="3">
          <label for="loket">Loket Pemberangkatan</label>
        </v-col>

        <v-col>
          <v-text-field
            id="loket"
            v-model="passengerData.alamatJemput"
            outlined
            dense
            required
            hide-details
            readonly
          ></v-text-field>
        </v-col>

        <h3>Silakan lakukan pembayaran ke loket {{ item.derpature }} sebesar {{ (item.harga * selectedSeat.length) | toRupiah }}</h3>
        <h4>Waktu tersisa untuk pembayaran:</h4>
        <h1>{{ hours }}:{{ minutes }}:{{ seconds }}</h1>
        
        <!-- Tampilkan data pembayaran -->
        <div v-if="method && status && expiredDate">
          <h4>Expired Date: {{ expiredDate }}</h4>
        </div>
      </div>
    </v-card>
  </div>
</template>

<script>
import axios from "axios";
import moment from "moment";
import "moment/locale/id";
import { mapState } from "vuex";

export default {
  data() {
    return {
      schedule: [],
      hours: "00",
      minutes: "00",
      seconds: "00",
      countdownInterval: null,
      // Tambahkan data untuk menampung informasi pembayaran
      method: "",
      status: "",
      expiredDate: "",
    };
  },
  computed: {
    ...mapState(["selectedSeat"]),
    passengerData() {
      return this.$store.state.passengerData;
    },
    id_schedule() {
      return this.$store.state.busData.id_schedule;
    },
    harga() {
      return this.$store.state.busData.harga;
    },
    userRole() {
      return this.$store.state.userRole;
    },
  },
  mounted() {
    this.getSchedule();
    const bookingData = JSON.parse(localStorage.getItem("bookingData"));
    console.log("Booking Data:", bookingData);
    if (bookingData) {
      const paymentId = bookingData.payment_id;
      this.getPaymentData(paymentId);
    }
  },
  beforeDestroy() {
    clearInterval(this.countdownInterval);
  },
  filters: {
    toRupiah(value) {
      const formatter = new Intl.NumberFormat("id-ID", {
        style: "currency",
        currency: "IDR",
        minimumFractionDigits: 0,
      });
      return formatter.format(value);
    },
  },
  methods: {
    formatDate(date) {
      moment.locale("id");
      return moment(date).format("dddd, Do MMMM YYYY");
    },
    formatHour(date) {
      moment.locale("id");
      return moment(date).format("HH:mm");
    },
    getSchedule() {
      const access_token = localStorage.getItem("access_token");
      let uri = `/api/schedule/show/${this.id_schedule}`;
      axios
        .get(uri, {
          headers: {
            Authorization: `Bearer ${access_token}`,
          },
        })
        .then((response) => {
          this.schedule = response.data.data;
          if (this.schedule.length > 0) {
            this.startCountdown();
          }
        })
        .catch((error) => {
          console.error("Error fetching schedule", error);
        });
    },
    getPaymentData(paymentId) {
      const access_token = localStorage.getItem("access_token");
      let uri = `/api/payments/${paymentId}`;
      axios
        .get(uri, {
          headers: {
            Authorization: `Bearer ${access_token}`,
          },
        })
        .then((response) => {
          const paymentData = response.data.payment;
          this.method = paymentData.method;
          this.status = paymentData.status;
          this.expiredDate = moment(paymentData.expired_date); // Ubah expiredDate menjadi objek moment
          this.startCountdown(); // Pindahkan pemanggilan startCountdown() ke sini
        })
        .catch((error) => {
          console.error("Error fetching payment data", error);
        });
    },
    startCountdown() {
      const bookingTime = moment();
      // Pastikan ada item jadwal yang tersedia
      if (this.schedule.length > 0 && this.expiredDate) {
        const departureTime = moment(this.schedule[0].tanggal);
        const expiredTime = moment(this.expiredDate); // Ambil expired_date dari respons pembayaran

        // Tentukan waktu maksimum countdown
        const maxCountdownTime = moment.min(departureTime.subtract(1, "hours"), expiredTime);

        // Pastikan maxCountdownTime memiliki nilai yang valid
        if (maxCountdownTime.isValid()) {
          this.updateCountdown(maxCountdownTime.diff(moment()));

          this.countdownInterval = setInterval(() => {
            const remainingTime = maxCountdownTime.diff(moment());
            if (remainingTime <= 0) {
              clearInterval(this.countdownInterval);
              this.hours = "00";
              this.minutes = "00";
              this.seconds = "00";
            } else {
              this.updateCountdown(remainingTime);
            }
          }, 1000);
        } else {
          console.error("Invalid maxCountdownTime:", maxCountdownTime);
        }
      }
    },

    updateCountdown(duration) {
      const durationMoment = moment.duration(duration);
      const hours = durationMoment.hours();
      const minutes = durationMoment.minutes();
      const seconds = durationMoment.seconds();

      if (!isNaN(hours) && !isNaN(minutes) && !isNaN(seconds)) {
        this.hours = String(hours).padStart(2, "0");
        this.minutes = String(minutes).padStart(2, "0");
        this.seconds = String(seconds).padStart(2, "0");
      } else {
        // Jika nilai tidak valid, beri nilai default "00"
        this.hours = "00";
        this.minutes = "00";
        this.seconds = "00";
      }
    },
  },
};
</script>

<style scoped>
.custom-button {
  width: 80%;
}
</style>
