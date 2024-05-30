<template>
  <v-app>
    <v-card>
      <v-card-title>Pilih nomor kursi</v-card-title>
      <div v-for="item in schedule" :key="item.id">
        <v-container class="note">
          <v-row class="text-center" style="display: flex; justify-content: center;">
            <v-col cols="2" sm="4">
              <v-icon x-large>{{ icons.mdiSofaSingleOutline }}</v-icon>
              <h4>Tersedia</h4>
            </v-col>
            <v-col cols="2" sm="4">
              <v-icon x-large>{{ icons.mdiSofaSingle }}</v-icon>
              <h4>Dipilih</h4>
            </v-col>
            <v-col cols="2" sm="4">
              <div class="booked">
                <v-icon x-large>{{ icons.mdiSofaSingleOutline }}</v-icon>
              </div>
              <h5>Tidak tersedia</h5>
            </v-col>
          </v-row>
        </v-container>
        <div class="chair">
          <v-container v-if="item.type === 'Ekonomi'" class="grey text-center">
            <v-row no-gutters>
              <v-col v-for="n in +item.number_of_seats" :key="n" cols="4" sm="4">
                <div
                  v-if="n !== 3"
                  :class="[
                    'pa- text-center text-no-wrap rounded',
                    {
                      'style': isSelectedChair(n),
                      'booked': isBookedChair(n),
                    },
                  ]"
                  @click="!isBookedChair(n) && toggleChairSelection(n)"
                >
                  <v-icon x-large>{{ isSelectedChair(n) ? icons.mdiSofaSingle : icons.mdiSofaSingleOutline }}</v-icon>
                  <h4>{{ n }}</h4>
                </div>
                <div v-else>
                  <h4>
                    <v-icon x-large>{{ icons.mdiSteering }}</v-icon>
                  </h4>
                </div>
              </v-col>
            </v-row>
          </v-container>
          <v-container v-else class="grey text-center">
            <v-row no-gutters>
              <v-col v-for="n in +item.number_of_seats + 4" :key="n" :cols="getColSize(n)">
                <div v-if="n === 3">
                  <v-icon x-large>{{ icons.mdiSteering }}</v-icon>
                </div>
                <div v-else-if="n === 2 || n === 4 || n === 9 || n === 13"></div>
                <div
                  v-else
                  :class="[
                    'pa- text-center text-no-wrap rounded',
                    {
                      'style': isSelectedChair(n),
                      'booked': isBookedChair(n),
                    },
                  ]"
                  @click="!isBookedChair(n) && toggleChairSelection(n)"
                >
                  <v-icon x-large>{{ isSelectedChair(n) ? icons.mdiSofaSingle : icons.mdiSofaSingleOutline }}</v-icon>
                  <h4>{{ getDisplayedSeatNumber(n) }}</h4>
                </div>
              </v-col>
            </v-row>
          </v-container>
        </div>

        <div class="check" v-if="selectedSeat.length > 0">
          <v-container class="grey text-center">
            <v-card class="mb-3">
              <v-row>
                <v-col cols="4" md="4" sm="4">
                  <div class="pa-2" tile>
                    <h3>Seat Dipilih</h3>
                    <h5>{{ selectedSeat.join(', ') }}</h5>
                  </div>
                </v-col>

                <v-col cols="4" md="4" sm="4">
                  <div class="pa-2">
                    <v-btn
                      class="mx-2"
                      fab
                      dark
                      color="secondary"
                      @click="submitData"
                    >
                      <v-icon dark>{{ icons.mdiChevronRight }}</v-icon>
                    </v-btn>
                  </div>
                </v-col>

                <v-col cols="4" md="4" sm="4">
                  <div class="pa-2" tile>
                    <h3>Total Harga</h3>
                    <h5>{{ totalHarga | toRupiah }}</h5>
                  </div>
                </v-col>
              </v-row>
            </v-card>
          </v-container>
        </div>
      </div>
    </v-card>
    <v-snackbar v-model="snackbar.show" :timeout="snackbar.timeout" :color="snackbar.color">
      {{ snackbar.message }}
      <template v-slot:action>
        <v-btn text @click="closeSnackbar">OK</v-btn>
      </template>
    </v-snackbar>
  </v-app>
</template>

<script>
import axios from "axios";
import { mapState, mapActions } from "vuex";
import {
  mdiSofaSingleOutline,
  mdiSofaSingle,
  mdiChevronRight,
  mdiSteering,
} from "@mdi/js";

export default {
  setup() {
    return {
      icons: {
        mdiSofaSingleOutline,
        mdiSofaSingle,
        mdiChevronRight,
        mdiSteering,
      },
    };
  },

  data() {
    return {
      schedule: [],
      selectedSeat: [],
      bookingsChair: [],
      snackbar: {
        show: false,
        message: "",
        timeout: 3000,
        color: "error",
      },
    };
  },
  computed: {
    ...mapState(["busData"]),
    id_schedule() {
      return this.busData.id_schedule;
    },
    harga() {
      return this.busData.harga;
    },
    totalHarga() {
      return this.harga * this.selectedSeat.length;
    },
  },

  mounted() {
    this.getSchedule();
    this.getBookingsChair();
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
    ...mapActions(["toggleChairSelection"]),

    getColSize(n) {
      if (n <= 3) {
        return 4;
      } else if (n <= 5) {
        return 3;
      } else if (n <= 9) {
        return 3;
      } else if (n <= 12) {
        return 3;
      } else {
        return 3;
      }
    },

    submitData() {
      if (!isNaN(this.totalHarga) && this.totalHarga !== null) {
        this.$store.dispatch('setSelectedSeat', this.selectedSeat.slice());
        this.proceedToConfirmation();
      } else {
        console.error('Total harga kursi tidak valid');
      }
    },

    getDisplayedSeatNumber(n) {
      return n;
    },

    toggleChairSelection(seat) {
      if (this.selectedSeat.includes(seat)) {
        this.selectedSeat = this.selectedSeat.filter(chair => chair !== seat);
      } else {
        this.selectedSeat.push(seat);
      }
    },

    isSelectedChair(seat) {
      return this.selectedSeat.includes(seat);
    },

    isBookedChair(seat) {
      return this.bookingsChair.includes(seat);
    },

    proceedToConfirmation() {
      if (this.selectedSeat.length > 0) {
        this.$router.push("/confirmasi-pemesanan");
      } else {
        this.snackbar.message = "Pilih setidaknya satu kursi";
        this.snackbar.show = true;
      }
    },

    getBookingsChair() {
      const access_token = localStorage.getItem("access_token");
      axios
        .get(`/api/bookings/show/schedules/${this.id_schedule}`, {
          headers: {
            Authorization: `Bearer ${access_token}`,
          },
        })
        .then((response) => {
          this.bookingsChair = response.data.data.flatMap(item => item.seat_numbers);
        })
        .catch((error) => {
          console.error(error);
        });
    },

    getSchedule() {
      const access_token = localStorage.getItem("access_token");
      axios
        .get(`/api/schedule/show/${this.id_schedule}`, {
          headers: {
            Authorization: `Bearer ${access_token}`,
          },
        })
        .then((response) => {
          this.schedule = response.data.data;
        })
        .catch((error) => {
          console.error(error);
        });
    },

    closeSnackbar() {
      this.snackbar.show = false;
    },
  },

  watch: {
    selectedSeat(newValue) {
      localStorage.setItem("selectedChairs", JSON.stringify(newValue));
    },
  },
};
</script>

<style scoped>
.chair {
  width: 100%;
  margin: 50px auto;
  font-size: 12px;

  @media (min-width: 600px) {
    width: 600px;
  }
}
.note {
  width: 100%;
  margin: 20px auto;
  font-size: 9px;

  @media (min-width: 600px) {
    width: 400px;
  }
}

.style {
  background-color: gainsboro;
  color: white;
  cursor: pointer;
}

.booked {
  background-color: #bbbbbbd0;
  color: black;
  position: relative;
}

.booked::before {
  content: "Tidak Tersedia";
  position: absolute;
  color: #030000;
  padding: 5px 10px;
  margin: 2px;
  border-radius: 5px;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
}
</style>
