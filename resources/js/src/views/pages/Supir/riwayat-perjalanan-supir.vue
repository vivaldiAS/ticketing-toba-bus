<template>
  <div>
    <v-card-title> Riwayat Perjalanan Anda </v-card-title>
    <v-card v-for="item in pesanan" :key="item.schedule_id" class="mb-3 mt-4">
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
          <div class="d-flex justify-content-between ml-5 type">
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
      total: "",
    };
  },
  setup() {
    return {
      icons: {
        mdiCalendarClock,
        mdiAccountGroup,
        mdiAccount,
        bookingCounts: {},
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
  mounted() {
    const access_token = localStorage.getItem("access_token");

    axios
      .get("/api/schedules/driver", {
        headers: {
          Authorization: `Bearer ${access_token}`,
        },
      })
      .then((response) => {
        console.log(response.data);
        this.pesanan = response.data.data.filter(
          (pesanan) => pesanan.schedules_status == "complete"
        );
        // console.log("iini", this.pesanan);
      })
      .catch((error) => {
        console.log(error);
      });
  },
};
</script>

<style scoped>
.status {
  position: absolute;
  top: -15px;
  right: 10px;
}

.pendapatan {
  position: absolute;
  right: 150px;
  top: 20px;
  font-size: 24px;
  font-weight: bold;
  color: red;
}

/* Mengatur jarak dari kanan card */
.harga {
  position: absolute;
  right: 150px;
}
@media only screen and (max-width: 600px) {
  .harga {
    position: absolute;
    margin-top: 50px;
    left: 65px;
  }
  .type {
    margin-top: 28px;
  }
}
</style>
