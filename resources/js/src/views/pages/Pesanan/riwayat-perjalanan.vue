<template>
  <div>
    <v-card flat>
      <v-card class="mb-3">
        <v-card-title> Riwayat Perjalanan Anda </v-card-title>
      </v-card>
      <v-card v-for="item in pesanan" :key="item.schedule_id" class="mb-2">
        <v-card v-if="item.length < 1">
          <h3 class="text-center py-4">Maaf, tidak ada jadwal yang tersedia saat ini.</h3>
        </v-card>
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
              <div class="text-h6 harga" style="color: #ff4c51">
                {{ item.harga | toRupiah }}
              </div>
            </div>
            <div class="d-flex justify-content-between ml-5 type">
              <h6>{{ item.nomor_pintu }}</h6>
              <h6 class="text--primary ml-5">{{ item.type }}</h6>
            </div>
            <v-row no-gutters class="my-3">
              <v-col cols="12">
                <div class="row">
                  <div class="col-md-4">
                    <v-icon left>{{ icons.mdiCalendarClock }}</v-icon>
                    {{ formatDate(item.tanggal) }}
                  </div>
                  <div class="col-md-2">
                    <v-icon left>{{ icons.mdiAccount }}</v-icon> {{ item.name }}
                  </div>
                  <v-row class="col-md-4 d-flex justify-space-around">
                    <div class="col-md-2"></div>
                    <div class="col-md-2">
                      <router-link
                        :to="{ name: 'e-ticket', params: { id: item.bookings_id } }"
                      >
                        <v-btn
                          small
                          color="accent"
                          class="ml-3"
                          style="color: white; font-weight: bold"
                        >
                          E-Ticket
                        </v-btn>
                      </router-link>
                    </div>
                  </v-row>
                </div>
              </v-col>
            </v-row>
          </v-col>
        </v-row>
      </v-card>
    </v-card>
  </div>
</template>
<script>
import axios from "axios";
import moment from "moment";
import "moment/locale/id";
import { mapActions } from "vuex";

import { mdiCalendarClock, mdiAccountGroup, mdiAccount } from "@mdi/js";
export default {
  data() {
    return {
      tab: null,
      pesanan: [],
    };
  },
  setup() {
    return {
      icons: {
        mdiCalendarClock,
        mdiAccountGroup,
        mdiAccount,
      },
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
  },
  mounted() {
    const access_token = localStorage.getItem("access_token");

    axios
      .get("/api/bookings/my", {
        headers: {
          Authorization: `Bearer ${access_token}`,
        },
      })
      .then((response) => {
        this.pesanan = response.data.filter(
          (pesanan) => pesanan.status === "complete" && pesanan.status_pay === "Berhasil"
        );
        console.log(this.pesanan);
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
  right: 20px;
  top: 5px;
}
@media only screen and (max-width: 480px) {
  .harga{
    position: absolute;
    margin-top: 50px;
    left: 65px;

  }
  .type{
    margin-top: 28px;
  }
}
</style>
