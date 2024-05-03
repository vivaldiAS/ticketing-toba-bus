<template>
  <v-app>
    <v-row>
      <v-container>
        <v-img height="400px" :src="require('@/assets/images/logos/KBT-BG.jpg').default">
          <v-card-title>
            <v-btn small color="primary" class="btn-pesan-ticket"> Pesan E-Ticket </v-btn>
          </v-card-title>
          <v-card-title class="text-title">
            <h5 class="white--text">Pelayanan terbaik untuk perjalanan kamu</h5>
          </v-card-title>
        </v-img>
      </v-container>
    </v-row>
    <v-container>
      <v-row style="justify-content: flex-end">
        <v-col>
          <v-text-field
            v-model="selectedDate"
            type="date"
            label="Pilih tanggal"
            placeholder="Pilih Tanggal"
            clearable
            hide-details
          />
        </v-col>
        <v-col
          ><v-select
            v-model="selectedRoute"
            :items="route"
            id="id"
            item-value="id"
            item-text="derpatures"
            placeholder="Pilih Rute"
            clearable
            hide-details
          ></v-select
        ></v-col>
        <v-col
          ><v-select
            v-model="selectedType"
            :items="['Ekonomi', 'Eksekutif']"
            placeholder="Pilih Type"
            clearable
            hide-details
          ></v-select
        ></v-col>
      </v-row>
    </v-container>
    <!-- <v-slide-group class="pa-4" multiple show-arrows>
      <v-slide-item v-for="n in 10" :key="n" v-slot="{ active, toggle }">
        <v-card :color="active ? 'secondary' : 'grey lighten-1'" class="ma-4" height="200" width="150" @click="toggle">
          <v-row class="fill-height" align="center" justify="center">
            <v-scale-transition>
              <v-icon v-if="active" color="white" size="48" v-text="'mdi-close-circle-outline'"></v-icon>
            </v-scale-transition>
          </v-row>
        </v-card>
      </v-slide-item>
    </v-slide-group> -->
    <h3 class="mt-4 mb-4">Operasional Mobil Bus e-KBT</h3>

    <v-card v-if="filterSchedules().length < 1">
      <h3 class="text-center py-4">Maaf, tidak ada jadwal yang tersedia saat ini.</h3>
    </v-card>
    <v-card v-for="item in filterSchedules()" :key="item.schedule_id" class="mb-2">
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
            <v-card-title class="text-h6" width="100%"
              >{{ item.derpature }} - {{ item.arrival }}</v-card-title
            >
            <div class="text-h6 harga" style="color: #ff4c51">
              {{ item.harga | toRupiah }}
            </div>
          </div>
          <div class="d-flex justify-content-between ml-5 type">
            <h6>{{ item.nomor_pintu }}</h6>
            <h6 class="text--primary ml-5">{{ item.type }}</h6>
          </div>
          <v-row no-gutters class="my-3">
            <v-col cols="12" class="detail">
              <div class="row list-detail">
                <div class="col-md-3">
                  <v-icon left>{{ icons.mdiCalendarClock }}</v-icon>
                  {{ formatDate(item.tanggal) }}
                </div>
                <div class="col-md-2">
                  <v-icon left>{{ icons.mdiAccount }}</v-icon> {{ item.name }}
                </div>
                <div
                  class="col-md-3"
                  v-for="(count, id) in bookingCounts"
                  :key="id"
                  v-if="item.schedule_id == id"
                >
                  <h3
                    v-if="count + 1 == item.number_of_seats"
                    style="color: #ff4c51; opacity: 70%"
                  >
                    PENUH
                  </h3>
                  <small v-else color="secondary"
                    >Tersedia : {{ item.number_of_seats - count - 1 }} Kursi
                  </small>
                </div>
                <div
                  class="col-md-3"
                  v-if="!Object.keys(bookingCounts).includes(String(item.schedule_id))"
                >
                  <small color="secondary"
                    >Tersedia : {{ item.number_of_seats - 1 }} Kursi
                  </small>
                </div>

                <v-row class="col-md-4 btn-pesan">
                  <v-btn
                    color="secondary"
                    @click="selectBus(item.schedule_id, item.harga)"
                    style="color: white; font-weight: bold"
                  >
                    Pesan
                  </v-btn>
                </v-row>
              </div>
            </v-col>
          </v-row>
        </v-col>
      </v-row>
    </v-card>
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
    };
  },
  data() {
    return {
      schedules: [],
      bookingCounts: {},
      route: [],
      busData: {
        id_schedule: "",
        harga: "",
      },
      selectedDate: null,
      selectedRoute: null,
      selectedType: null,
    };
  },

  methods: {
    ...mapActions(["setSelectedSeat"]),
    selectBus(id_schedule, harga) {
      // set data bus yang dipilih ke state Vuex
      this.$store.dispatch("setBusData", { id_schedule, harga });

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
        .get("/api/schedule/show/all", {
          headers: {
            Authorization: `Bearer ${access_token}`,
          },
        })
        .then((response) => {
          this.schedules = response.data.data.slice(0, 5);
          this.st = response.data.total;
          this.bookingCounts = this.countBookings(response.data.total);

          console.log(this.schedules);
          console.log(this.st);
        })
        .catch((error) => {
          console.log(error);
        });
    },
    filterSchedules() {
      let filteredSchedules = this.schedules;

      if (this.selectedDate) {
        filteredSchedules = filteredSchedules.filter(
          (schedule) =>
            moment(schedule.tanggal).format("YYYY-MM-DD") ===
            moment(this.selectedDate).format("YYYY-MM-DD")
        );
      }

      if (this.selectedRoute) {
        console.selectedRoute;
        filteredSchedules = filteredSchedules.filter(
          (schedule) => schedule.id === this.selectedRoute
        );
      }
      if (this.selectedType) {
        console.log(this.selectedType);
        filteredSchedules = filteredSchedules.filter(
          (schedule) => schedule.type === this.selectedType
        );
      }
      return filteredSchedules;
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
    const access_token = localStorage.getItem("access_token");

    this.getSchedule();
    axios
      .get("api/routes/show/all", {
        headers: {
          Authorization: `Bearer ${access_token}`,
        },
      })
      .then((response) => {
        this.route = response.data.data.map((item) => {
          return {
            id: item.id,
            derpatures: item.derpature + " - " + item.arrival,
            derpature: item.derpature + " - " + item.arrival,
            // derpature: item.derpature,
            // arrival: item.arrival,
          };
        });
        // console.log(this.route)
      })
      .catch((error) => {
        console.log(error);
      });
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
};
</script>
<style scoped>
.harga {
  padding: 17px;
  margin-left: auto;
}

.btn-pesan {
  display: flex;
  justify-content: flex-end;
}
.detail {
  font-size: 12px;
}
.list-detail {
  text-align: left;
  margin-left: 10px;
}
.text-title {
  position: absolute;
  margin-left: 60%;
}

@media only screen and (max-width: 480px) {
  .list-detail {
    text-align: left;
    margin-left: 10px;
  }
  .btn-pesan {
    display: flex;
    justify-content: flex-start;
    margin-bottom: 20px;
  }
  .btn-pesan-ticket {
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
  .harga {
    position: absolute;
    margin-top: 30px;
  }
  .type {
    margin-top: 28px;
  }
}

@media only screen and (min-width: 481px) and (max-width: 960px) {
  .detail {
    font-size: 12px;
  }
  .list-detail {
    text-align: left;
    margin-left: 10px;
  }

  .btn-pesan {
    position: absolute;
    left: 5px;
  }
  .btn-pesan-ticket {
    margin-top: 160px;
    height: 15px;
    padding-left: 30px;
    width: 240px;
    height: 50px;
  }

  .text-title {
    position: absolute;
    text-align: center;
  }
}
</style>
