  <template>
    <div>
      <v-card>
        <v-card-title>
          Pesanan anda
        </v-card-title>
      </v-card>

      <v-card v-for="item in pesanan" :key="item.bookings_id" class="card">
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
              <v-card-title class="text-h6">{{ item.derpature }} - {{ item.arrival }}</v-card-title>
              <div class="text-h6 harga" style="color: #ff4c51">{{ item.harga | toRupiah }}</div>
              <v-btn
                v-if="item.status === 'in_progress' && item.status_pay == 'Berhasil'"
                rounded
                small
                color="primary"
                class="status text-capitalize"
                style="color: white; font-weight: bold"
              >
                sedang berjalan
              </v-btn>
              <v-btn
                v-if="item.status_pay === 'menunggu'"
                rounded
                small
                color="warning"
                class="status text-capitalize"
                style="color: white; font-weight: bold"
              >
                Menunggu Pembayaran
              </v-btn>
            </div>
            <div class="d-flex justify-content-between ml-5 rute">
              <h6>{{ item.nomor_pintu }}</h6>
              <h6 class="text--primary ml-5">{{ item.type }}</h6>
            </div>
            <v-row no-gutters class="my-3">
              <v-col cols="12">
                <div class="row">
                  <div class="col-md-4 det">
                    <v-icon left>{{ icons.mdiCalendarClock }}</v-icon>
                    {{ formatDate(item.tanggal) }}
                  </div>
                  <div class="col-md-2 det">
                    <v-icon left>{{ icons.mdiAccount }}</v-icon> {{ item.name }}
                  </div>
                  <v-row class="col-md-6 d-flex">
                    <div v-if="userRole === 'passenger'" class="col-md-4">
                      <router-link
                        :to="{
                          name: 'tracking',
                          params: { schedule_id: item.schedule_id },
                        }"
                      >
                        <v-btn
                          v-if="
                            item.status === 'in_progress' && item.status_pay === 'Berhasil'
                          "
                          small
                          color="secondary"
                          class="ml-3 btn-tracking"
                          style="color: white; font-weight: bold"
                        >
                          Tracking
                        </v-btn>
                      </router-link>
                    </div>
                    <div
                      v-if="userRole === 'passenger' && item.status_pay === 'menunggu'"
                      class="col-md-2"
                    >
                   <!-- Ganti <router-link> dengan nav-menu-link -->
<nav-menu-link
  :to="{ name: 'pages-admin-loket' }"
>
  <v-btn
    small
    color="primary"
    class="ml-3 btn-menunggu"
    style="color: white; font-weight: bold"
    @click="navigateToDetailPage(item.bookings_id)"
  >
    Lihat detail
  </v-btn>
</nav-menu-link>

                    </div>
                    <div class="col-md-2">
                      <router-link
                        :to="{ name: 'e-ticket', params: { id: item.bookings_id } }"
                      >
                        <v-btn
                          v-if="item.status_pay == 'Berhasil'"
                          small
                          color="accent"
                          class="ml-3 btn-tiket"
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

      <v-card v-if="pesanan.length === 0"  style="margin-top: 10px;">
        <h3 class="text-center py-4">Maaf, anda belum memiliki riwayat pesanan.</h3>
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
    computed: {
      userRole() {
        return this.$store.state.userRole;
      },
    },
    methods: {
      ...mapActions(["setSelectedSeat"]),
      navigateToDetailPage(bookingsId) {
        // Lakukan peralihan ke halaman detail dengan menggunakan Vue Router
        this.$router.push({ name: 'loket-payment', params: { bookings_id: bookingsId } });
      },
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
    return moment(date).format("dddd, Do MMMM YYYY, HH:mm:ss");
  },  
    },
mounted() {
  const access_token = localStorage.getItem("access_token");

  // Define a function to fetch data and update status
  const fetchDataAndUpdateStatus = () => {
    console.log("Waktu sekarang:", new Date());
    axios
      .get("/api/bookings/my", {
        headers: {
          Authorization: `Bearer ${access_token}`,
        },
      })
      .then((response) => {
        this.pesanan = response.data.filter(
          (pesanan) =>
            pesanan.status === "in_progress" || pesanan.status === "not_started"
        );
        const currentDate = new Date();

        this.pesanan.forEach((item) => {
          const expiredDate = new Date(item.expired_date);

          if (
            currentDate > expiredDate && 
            item.status_pay !== "Expired" && 
            item.status_pay !== "Berhasil"
          ) {
            item.status_pay = "Expired";
            axios.put(
              `/api/bookings/update-status/${item.pembayarans_id}`,
              {
                status_pay: "Expired",
              },
              {
                headers: {
                  Authorization: `Bearer ${access_token}`,
                },
              }
            );
          }
        });
      })
      .catch((error) => {
        console.log(error);
      });
  };

  // Call the function immediately when the component is mounted
  fetchDataAndUpdateStatus();

  // Set interval to refresh data every 3 seconds
  setInterval(fetchDataAndUpdateStatus, 3000);
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
  .card {
    margin-top: 25px;
  }
  .status {
    position: absolute;
    top: -15px;
    right: 10px;
    cursor: default;
    /*  transform: rotate(38deg); */
    /* Mengatur rotasi button */
  }
  v-btn {
    cursor: pointer;
  }

  /* Mengatur jarak dari kanan card */
  .harga {
    position: absolute;
    right: 20px;
    top: 20px;
  }
  @media only screen and (max-width: 600px) {
    .harga {
      position: absolute;
      left: 65px;
      top: 50px;

    }.btn-pesan {
      margin-top: 160px;
    }
  .rute{
    margin-top: 30px;
  }
  .det{
    margin-left: 13px;
  }
  }
  </style>
