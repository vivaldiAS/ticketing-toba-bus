<template>
  <div>
    <v-card v-for="item in schedule" :key="item.id">
      <v-card-title>Pembayaran</v-card-title>
      <div class="container mt-3">
        <div class="text-center">
          <h2>{{ item.derpature }} -> {{ item.arrival }}</h2>
          <h5>{{ formatHour(item.tanggal) }}</h5>
          <h5>{{ formatDate(item.tanggal) }}</h5>
          <h5>{{ item.harga | toRupiah }}</h5>
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
                  <h5>Nomor Handphone</h5>
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
              required
              hide-details
              readonly
            ></v-text-field>
          </v-col>
        </div>
        <v-container>
          <div v-if="userRole === 'admin_loket'">
            <label for="pesan-orang-lain" class="mr-2">Penumpang punya akun?</label>
            <v-switch
              v-model="isAccount"
              inset
              color="secondary"
              id="pesan-akun-lain"
            ></v-switch>
            <v-col v-if="isAccount">
              <label for="">cari akun berdasarkan email</label>
              <v-text-field
                id="loket"
                v-model="bookings.email"
                outlined
                dense
                placeholder="Email"
                required
                hide-details
              ></v-text-field>
            </v-col>
            <div class="text-center">
              <v-row justify="center">
                <v-col class="col">
                  <v-btn class="custom-button" color="primary" @click.prevent="BayarCash"
                    >Bayar Sekarang</v-btn
                  >
                </v-col>
                <v-col class="col">
                  <v-btn class="custom-button" color="error" @click.prevent="cancel"
                    >Batalkan</v-btn
                  >
                </v-col>
              </v-row>
            </div>
          </div>
          <!-- <v-banner elevation="4"> -->
          <!-- <v-row align="center" color="black" justify="center" @click="showPaymentMethods = !showPaymentMethods">
              <v-col cols="auto">
                <v-icon size="22">{{ icons.mdiCreditCard }}</v-icon>
              </v-col>
              <v-col>
                <span class="text-subtitle-1 ml-2">Pilih metode Pembayaran</span>
              </v-col>
              <v-col cols="auto">
                <v-icon size="22">{{ icons.mdiChevronRight }}</v-icon>
              </v-col>
            </v-row> -->
          <!-- <v-row v-if="showPaymentMethods"> -->
          <v-col>
            <!-- <v-radio-group v-model="selectedMethod"> -->
            <!-- nontunai -->
            <div v-if="userRole == 'passenger'">
              <div v-if="loading" class="loading-overlay">
                <div class="loading-spinner"></div>
              </div>
              <v-banner>
                <v-row>
                  <v-col cols="auto">
                    <v-icon size="22" color="primary">{{
                      icons.mdiWalletOutline
                    }}</v-icon>
                  </v-col>
                  <v-col @click="togglePaymentNoncash"> NonTunai </v-col>
                  <v-col cols="auto">
                    <v-icon size="22">{{ icons.mdiChevronRight }}</v-icon>
                  </v-col>
                </v-row>
              </v-banner>
              <v-col v-if="showPaymentNoncash">
                <v-col class="ml-3">
                  <v-row>
                    <v-col cols="auto">
                      <v-col>
                        <v-btn color="primary" @click.prevent="BayarNontunai"
                          >Bayar Sekarang</v-btn
                        >
                      </v-col>
                    </v-col>
                  </v-row>
                </v-col>
              </v-col>
            </div>
            <!-- </v-radio-group> -->
          </v-col>
          <!-- </v-row> -->
          <!-- </v-banner> -->
        </v-container>
      </div>
    </v-card>
  </div>
</template>

<script>
import axios from "axios";
import moment from "moment";
import "moment/locale/id";
import { mapState } from "vuex";
import Swal from "sweetalert2";

import { mdiChevronRight, mdiCreditCard, mdiCashCheck, mdiWalletOutline } from "@mdi/js";

export default {
  data() {
    return {
      showPaymentMethods: false,
      showPaymentcash: false,
      showPaymentNoncash: false,
      selectedMethod: null,
      amount: null,
      howtoPayStep: {},
      schedule: {},
      loading: false,
      isAccount: false,
      icons: {
        mdiChevronRight,
        mdiCreditCard,
        mdiCashCheck,
        mdiWalletOutline,
      },

      bookings: [
        "schedules_id",
        "name",
        "number_phone ",
        "num_seats",
        "alamat_jemput",
        "status",
        "harga",
        "email"
      ],
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
      return moment(date).format("hh:mm");
    },
    togglePaymentcash() {
      this.showPaymentcash = !this.showPaymentcash;
      this.showPaymentNoncash = false;
    },
    togglePaymentNoncash() {
      this.showPaymentNoncash = !this.showPaymentNoncash;
      this.showPaymentcash = false;
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
    BayarCash() {
      const access_token = localStorage.getItem("access_token");
      const email = this.isAccount ? this.bookings.email : null;
      console.log('email', this.bookings.email);
      axios
        .post(
          "api/bookings",
          {
            schedules_id: this.id_schedule,
            name: this.passengerData.name,
            number_phone: this.passengerData.number_phone,
            num_seats: this.selectedSeat,
            alamatJemput: this.passengerData.alamatJemput,
            harga: this.harga,
            status: "berhasil",
            email: email
          },
          {
            headers: {
              Authorization: `Bearer ${access_token}`,
            },
          }
        )
        .then((response) => {
          // tampilkan SweetAlert jika pembayaran berhasil
          Swal.fire({
            icon: "success",
            title: "Pembayaran Berhasil",
            text: "Terima kasih sudah melakukan pembayaran",
          });

          this.$router.push({
            name: "pesananku",
          });
        })
        .catch((error) => {
          console.log(error);
          Swal.fire({
            icon: "error",
            title: "Oops...",
            text: "Terjadi kesalahan saat melakukan pembayaran",
          });
        });
    },
    cancel() {
      Swal.fire({
        icon: "question",
        title: "Apakah anda ingin membatalkan pesanan?",
        showCancelButton: true,
        confirmButtonText: "Ya",
        cancelButtonText: "Tidak",
        confirmButtonColor: "#307475",
      }).then((result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
          this.$router.push({
            name: "pages-pemesanan",
          });
        }
      });
    },
    BayarNontunai() {
      const access_token = localStorage.getItem("access_token");
      try {
        axios
          .post(
            "api/bookings/nontunai",
            {
              schedules_id: this.id_schedule,
              name: this.passengerData.name,
              number_phone: this.passengerData.number_phone,
              num_seats: this.selectedSeat,
              alamatJemput: this.passengerData.alamatJemput,
              harga: this.harga,
            },
            {
              headers: {
                Authorization: `Bearer ${access_token}`,
              },
            }
          )
          .then((response) => {
            this.loading = true;
            const data = response.data;
            window.open(data.data.virtual_account_info.how_to_pay_page, "_blank");
            this.loading = false;

            setTimeout(() => {
              this.$router.push({
                name: "pesananku",
              });
            }, 1000);

            // console.log(data);
            // if (data.code === 200 && data.data.virtual_account_info.how_to_pay_api) {
            //   const howToPayApi = data.data.virtual_account_info.how_to_pay_api;
            //   console.log(howToPayApi)
            //   this.$router.push({
            //     name: 'pembayaran-instruction-bca',
            //     params: { howToPayApi: howToPayApi }
            //   });

            // } else {
            //   console.error("Invalid response or missing how_to_pay_page XML");
            // }
          });
      } catch (error) {
        console.error(error);
      } finally {
        this.loading = false;
      }
    },
  },
};
</script>

<style scoped>
.custom-button {
  width: 80%;
}

.loading-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  z-index: 9999;
  display: flex;
  align-items: center;
  justify-content: center;
}

.loading-spinner {
  border: 4px solid #f3f3f3;
  border-top: 4px solid #3498db;
  border-radius: 50%;
  width: 40px;
  height: 40px;
  animation: spin 2s linear infinite;
}

@keyframes spin {
  0% {
    transform: rotate(0deg);
  }

  100% {
    transform: rotate(360deg);
  }
}
</style>
