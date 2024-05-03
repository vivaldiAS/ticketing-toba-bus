<template>
  <div>
    <v-card v-for="item in schedule" :key="item.id">
      <v-card-title>Konfirmasi Data Penumpang</v-card-title>

      <div class="container mt-3">
        <div class="text-center">
          <h2>{{ item.derpature }} -> {{ item.arrival }}</h2>
          <h5>{{ formatHour(item.tanggal) }}</h5>
          <h5>{{ formatDate(item.tanggal) }}</h5>
        </div>
        <template class="text-center">
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
                  <h5>Nmor Handphone</h5>
                  <h6>{{ passengerData.number_phone }}</h6>
                </v-card>
              </v-col>
              <v-col cols="12" sm="4">
                <v-card class="pa-2" outlined tile>
                  <h5>No.Tempat duduk</h5>
                  <h6>{{ selectedSeat }}</h6>
                </v-card>
              </v-col>
            </v-row>
          </v-container>
        </template>
        <div>
          <v-col cols="12" md="3">
            <label for="loket">Loket Pemberangkatan</label>
          </v-col>

          <v-col>
            <v-text-field
              id="loket"
              v-model="passengerData.alamatJemput"
              outlined
              dense
              placeholder="Loket Jemput"
              required
              hide-details
              readonly
            ></v-text-field>
          </v-col>
        </div>
      </div>
      <v-container class="grey text-center">
        <v-card class="mb-3">
          <v-row>
            <v-col cols="4" md="4" sm="4">
              <div class="pa-2" tile>
                <h3>Seat</h3>
                <h5>{{ selectedSeat }}</h5>
              </div>
            </v-col>
            <v-col cols="4" md="4" sm="4">
              <div class="pa-2">
                <v-btn class="mx-2" fab dark color="secondary" @click="submitData">
                  <v-icon dark>
                    {{ icons.mdiChevronRight }}
                  </v-icon>
                </v-btn>
              </div>
            </v-col>
            <v-col cols="4" md="4" sm="4">
              <div class="pa-2" tile>
                <h3>Harga</h3>
                <h5>{{ item.harga | toRupiah }}</h5>
              </div>
            </v-col>
            <v-col cols="6" md="6" sm="6">
              <div class="pa-2" tile>
                <h3>Menaikkan</h3>
                <h5>{{ item.derpature }}</h5>
              </div>
            </v-col>
            <v-col cols="6" md="6" sm="6">
              <div class="pa-2" tile>
                <h3>Menurunkan</h3>
                <h5>{{ item.arrival }}</h5>
              </div>
            </v-col>
          </v-row>
        </v-card>
      </v-container>
    </v-card>
  </div>
</template>

<script>
import axios from "axios";
import moment from "moment";
import "moment/locale/id";
import { mapState, mapActions } from "vuex";
import {
  mdiCalendarClock,
  mdiAccountGroup,
  mdiAccount,
  mdiSofaSingleOutline,
  mdiSofaSingle,
  mdiChevronRight,
} from "@mdi/js";

export default {
  setup() {
    return {
      icons: {
        mdiCalendarClock,
        mdiAccountGroup,
        mdiAccount,
        mdiSofaSingleOutline,
        mdiSofaSingle,
        mdiChevronRight,
      },
    };
  },
  data() {
    return {
      schedule: {},
    };
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
  },

  methods: {
    formatDate(date) {
      moment.locale("id");
      return moment(date).format("dddd, Do MMMM YYYY");
    },
    formatHour(date) {
      moment.locale("id");
      return moment(date).format("hh:mm");
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
          console.log(this.schedule);
        })
        .catch((error) => {
          console.log(error);
        });
    },
    ...mapActions(["setPassengerData"]),
    submitData() {
      // redirect ke halaman berhasil
      this.$router.push("/pembayaran-method");
    },
  },
};
</script>
