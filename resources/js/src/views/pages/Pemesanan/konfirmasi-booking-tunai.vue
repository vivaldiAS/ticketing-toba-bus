<template>
  <v-app>
    <v-container>
      <v-row>
        <v-col
          v-for="item in schedules"
          :key="item.id"
          cols="12"
          md="6"
          lg="4"
        >
          <v-card class="mb-3">
            <v-card-title class="bold-text">
              Jadwal ID: {{ item.id }}
            </v-card-title>
            <v-card-subtitle class="bold-text">
              Tanggal: {{ formatDate(item.tanggal) }}
            </v-card-subtitle>
            <v-card-text>
              <p>Plat: {{ item.police_number }}</p>
              <p>Nomor: {{ item.nomor_pintu }}</p>
              <p>Harga: {{ item.harga | toRupiah }}</p>
              <p>Status: {{ item.status }}</p>
              <p>Loket: {{ item.nama_loket }}</p>
            </v-card-text>
            <v-card-actions>
              <v-btn @click="viewDetails(item.id)" color="primary">Lihat</v-btn>
            </v-card-actions>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </v-app>
</template>

<script>
import axios from 'axios';
import moment from 'moment';
import 'moment/locale/id';

export default {
  data() {
    return {
      schedules: []
    };
  },
  filters: {
    toRupiah(value) {
      const formatter = new Intl.NumberFormat('id-ID', {
        style: 'currency',
        currency: 'IDR',
        minimumFractionDigits: 0
      });
      return formatter.format(value);
    }
  },
  methods: {
    formatDate(date) {
      moment.locale('id');
      return moment(date).format('dddd, Do MMMM YYYY, HH:mm');
    },
    getSchedules() {
      const access_token = localStorage.getItem('access_token');
      axios
        .get('/api/konfirmasi-booking-tunai', {
          headers: {
            Authorization: `Bearer ${access_token}`
          }
        })
        .then(response => {
          this.schedules = response.data;
        })
        .catch(error => {
          console.error(error);
        });
    },
    viewDetails(id) {
      // Implementasi fungsi untuk melihat detail lebih lanjut dari jadwal
      // Misalnya, pindah ke halaman detail atau buka dialog
      this.$router.push({ name: 'pesananTunaiOnline', params: { id } });
    }
  },
  mounted() {
    this.getSchedules();
  }
};
</script>

<style scoped>
.card {
  margin: 1rem 0;
}
.bold-text {
  font-weight: bold;
}
</style>
