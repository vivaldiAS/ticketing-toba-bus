<template>
  <v-app>
    <div>
      <v-card-title> Jadwal Hari ini </v-card-title>
      <v-card v-for="item in todaySchedules" :key="item.schedule_id" class="mb-2">
        <v-row no-gutters>
          <v-col cols="auto">
            <v-avatar size="40" class="mt-2 ml-2">
              <img
                :src="require('@/assets/images/logos/logo-KBT.png').default"
                max-height="50px"
                max-width="100px"
                alt="avatar"
              />
            </v-avatar>
          </v-col>
          <v-col>
            <div class="d-flex justify-content-between">
              <v-card-title class="text-h6"
                >{{ item.derpature }} - {{ item.arrival }}</v-card-title
              >
              <v-btn
                v-if="item.schedules_status == 'in_progress'"
                rounded
                small
                color="warning"
                class="ml-3 status text-capitalize"
                style="color: white; font-weight: bold"
              >
                sedang berjalan
              </v-btn>
              <v-btn
                v-if="item.schedules_status == 'complete'"
                rounded
                small
                color="primary"
                class="ml-3 status text-capitalize"
                style="color: white; font-weight: bold"
              >
                Selesai
              </v-btn>
              <v-btn
                v-if="item.schedules_status == 'not_started'"
                rounded
                small
                color="info"
                class="ml-3 status text-capitalize"
                style="color: white; font-weight: bold"
              >
                Belum Berangkat
              </v-btn>
            </div>
            <div class="d-flex justify-content-between ml-5">
              <h6>{{ item.nomor_pintu }}</h6>
              <h6 class="text--primary ml-5">{{ item.type }}</h6>
            </div>
            <v-row no-gutters class="my-3">
              <v-col cols="12" class="detail">
                <div class="row">
                  <div class="col-md-3">
                    <v-icon left>{{ icons.mdiCalendarClock }}</v-icon>
                    {{ formatDate(item.tanggal) }}
                  </div>
                  <div class="col-md-2">
                    <v-icon left>{{ icons.mdiAccount }}</v-icon> {{ item.name }}
                  </div>
                  <div
                    class="col-md-2"
                    v-for="(count, id) in bookingCounts"
                    :key="id"
                    v-if="item.schedule_id == id"
                  >
                    <small color="secondary"
                      >Tersedia : {{ item.number_of_seats - count - 1 }} Kursi
                    </small>
                  </div>
                  <div
                    class="col-md-2"
                    v-if="!Object.keys(bookingCounts).includes(String(item.schedule_id))"
                  >
                    <small color="secondary"
                      >Tersedia : {{ item.number_of_seats - 1 }} Kursi
                    </small>
                  </div>
                  <div class="mt-2 ml-2">
                    <router-link
                      :to="{ name: 'penumpang-bus', params: { id: item.schedule_id } }"
                    >
                      Detail
                    </router-link>
                  </div>
                </div>
              </v-col>
            </v-row>
          </v-col>
        </v-row>
      </v-card>
    </div>
    <v-card-title> Jadwal Pengoperasian Mobil Bus Kamu </v-card-title>

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
