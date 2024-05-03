<template>
  <v-app>
    <v-card-title>
     Jadwal Pengoperasian Mobil Bus Kamu
    </v-card-title>
    <v-data-table
      :headers="headers"
      :items="schedules"
      :items-per-page="10"
      class="elevation-1"
    >
      <template v-slot:[`item.tanggal`]="{ item }">
        {{ formatDate(item.tanggal) }}
      </template>
      <template #item.detail="{ item }">
        <router-link :to="{ name: 'penumpang-bus', params: { id: item.schedule_id } }">
          Detail
        </router-link>
      </template>
    </v-data-table>
  </v-app>
</template>
<script>
import axios from "axios";
import moment from "moment";
import "moment/locale/id";
import { mapActions } from "vuex";
import { mdiCalendarClock, mdiAccountGroup, mdiAccount } from "@mdi/js";
export default {
  setup() {
    return {
      icons: {
        mdiCalendarClock,
        mdiAccountGroup,
        mdiAccount,
      },
      headers: [
        { text: "Tanggal", value: "tanggal" },
        { text: "Keberangkatan", value: "derpature" },
        { text: "Kedatangan", value: "arrival" },
        { text: "Jumlah Kursi", value: "number_of_seats" },
        { text: "Detail", value: "detail" },
      ],
    };
  },
  data() {
    return {
      schedules: [],
      bookingCounts: {},
      dateFilter: null,
      routeFilter: null,
    };
  },
  methods: {
    ...mapActions(["setSelectedSeat"]),
    selectBus(idSchedulues) {
      // set data bus yang dipilih ke state Vuex
      this.$store.dispatch("setBusData", idSchedulues);

      // pindah ke komponen selanjutnya (pilih tempat duduk)
      this.$router.push("/costumize-pemesanan");
    },
    isSelected(seatNumber) {
      // check apakah tempat duduk sudah dipilih sebelumnya
      return this.$store.state.selectedSeat === seatNumber;
    },
    formatDate(date) {
      moment.locale("id");
      return moment(date).format("dddd, Do MMMM YYYY, hh:mm:ss");
    },

    getSchedule() {
      const access_token = localStorage.getItem("access_token");

      axios
        .get("/api/schedules/driver", {
          headers: {
            Authorization: `Bearer ${access_token}`,
          },
        })
        .then((response) => {
          this.schedules = response.data.data;
          console.log(this.schedules);
          this.st = response.data.total;
          this.bookingCounts = this.countBookings(response.data.total);

          console.log(this.schedules);
          console.log(this.st);
        })
        .catch((error) => {
          console.log(error);
        });
    },
    countBookings(bookings) {
      const count = {};
      bookings.forEach((booking) => {
        if (count[booking.schedules_id]) {
          count[booking.schedules_id]++;
        } else {
          count[booking.schedules_id] = 1;
        }
      });
      return count;
    },
  },
  mounted() {
    this.getSchedule();
  },
  computed: {
    todaySchedules() {
      const today = moment().format("YYYY-MM-DD");

      console.log(today);
      return this.schedules.filter(
        (item) => moment(item.tanggal).format("YYYY-MM-DD") === today
      );
    },
  },
};
</script>

<style scoped>
@media only screen and (max-width: 480px) {
  .btn-pesan {
    margin-top: 160px;
    height: 15px;
    padding-left: 30px;
    width: 120px;
    font-size: 10px;
    height: 50px;
  }

  .text-title {
    position: absolute;
    text-align: center;
  }
}

@media only screen and (min-width: 481px) {
  .btn-pesan {
    margin-top: 160px;
    height: 15px;
    padding-left: 30px;
    width: 240px;
    height: 50px;
  }

  .text-title {
    position: absolute;
    margin-left: 60%;
  }

  .status {
    position: absolute;
    top: -15px;
    right: 10px;
    /*  transform: rotate(38deg); */
    /* Mengatur rotasi button */
  }

  /* Mengatur jarak dari kanan card */
  .harga {
    position: absolute;
    right: 150px;
  }
}
</style>
