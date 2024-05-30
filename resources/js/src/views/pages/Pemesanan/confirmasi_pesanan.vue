<template>
  <div>
    <v-card v-for="item in schedule" :key="item.id">
      <v-card-title>Konfirmasi pesanan anda</v-card-title>
      <div class="container mt-3">
        <div class="text-center">
          <h2>{{ item.derpature }} -> {{ item.arrival }}</h2>
          <h5>{{ formatHour(item.tanggal) }}</h5>
          <h5>{{ formatDate(item.tanggal) }}</h5>
        </div>
        <div class="d-flex justify-end">
          <div v-if="userRole === 'passenger'" class="d-flex justify-start align-center">
            <label for="pesan-orang-lain" class="mr-2">Pesan untuk orang lain</label>
            <v-switch v-model="autoFill" inset color="secondary" id="pesan-orang-lain"></v-switch>
          </div>
        </div>
        <div>
          <v-col cols="12" md="3">
            <label for="name">Nama Lengkap</label>
          </v-col>
          <v-col>
            <v-text-field
              id="name"
              v-model="passenger.name"
              outlined
              dense
              placeholder="Nama Lengkap"
              required
              hide-details
              :readonly="!isEditable"
              :rules="[(v) => !!v || 'Nama harus diisi']"
            ></v-text-field>
          </v-col>
        </div>
        <div>
          <v-col cols="12" md="3">
            <label for="Nomor Handphone">Nomor Handphone</label>
          </v-col>
          <v-col>
            <v-text-field
              id="Nomor Handphone"
              v-model="passenger.number_phone"
              type="number"
              outlined
              dense
              placeholder="Nomor Handphone"
              required
              hide-details
              :readonly="!isEditable"
              :rules="[(v) => !!v || 'Nomor Handphone harus diisi']"
            ></v-text-field>
          </v-col>
        </div>

        <div v-if="userRole === 'admin_loket'">
          <h4>Dijemput</h4>
          <p>
            Apabila penumpang tidak memilih request penjemputan, maka penumpang akan
            datang ke loket yang dipilih oleh penumpang. Namun, apabila penumpang memilih
            Request Penjemputan maka penumpang akan diarahkan kelokasi rekomendasi sistem
            dengan posisi terdekat dari sekitaran alamat yang dicantumkan sistem.
          </p>
          <v-col v-if="!jemput" cols="12">
            <v-text-field
              v-model="item.derpature"
              outlined
              dense
              readonly
              hide-details
            ></v-text-field>
          </v-col>
        </div>
        <div v-if="userRole === 'passenger'">
          <h4>Dijemput</h4>
          <p>
            Request penjemputan akan diarahkan ke lokasi rekomendasi sistem dengan posisi
            terdekat dari sekitaran alamat yang dicantumkan penumpang.
          </p>
          <v-switch v-model="jemput" color="primary"></v-switch>
          <v-col v-if="jemput" cols="12">
            <v-autocomplete
              filled
              solo
              clearable
              v-model="passenger.alamatJemput"
              :items="items"
              label="Pilih Lokasi Penjemputan"
            ></v-autocomplete>
          </v-col>
        </div>
      </div>
      <div class="check">
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
                  <h5>{{ item.harga * selectedSeat.length | toRupiah }}</h5>
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
      </div>
    </v-card>
    <v-snackbar ref="snackbar" v-model="snackbar" color="error" relative outlined top>
      Nama lengkap dan umur harus di isi!
      <template v-slot:action="{ attrs }">
        <v-btn color="error" text v-bind="attrs" @click="snackbar = false"> Close </v-btn>
      </template>
    </v-snackbar>
  </div>
</template>

<script>
import axios from "axios";
import moment from "moment";
import { mapState, mapActions } from "vuex";
import { mdiCalendarClock, mdiAccountGroup, mdiAccount, mdiSofaSingleOutline, mdiSofaSingle, mdiChevronRight } from "@mdi/js";

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
  computed: {
    ...mapState(["selectedSeat"]),
    id_schedule() {
      return this.$store.state.busData.id_schedule;
    },
    harga() {
      return this.$store.state.busData.harga;
    },
    userRole() {
      return this.$store.state.userRole;
    },
    isEditable() {
      return this.userRole === 'admin_loket' || (this.userRole === 'passenger' && this.autoFill);
    }
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
  data() {
    return {
      schedule: {},
      jemput: false,
      passenger: {
        name: "",
        age: "",
        alamatJemput: "",
      },
      snackbar: false,
      items: [
        "Amplas Terminal Bus",
        "Sekolah Parulian 3 Medan",
        "Wisma Amplas",
        "Indomaret Fresh, Jl. Sisingamangaraja, Harjosari II, Kec. Medan Amplas",
        "RSU. Mitra Medika-Amplas",
        "Sm. Raja Harjosari Indomaret",
        "Multi Batang Indonesia",
        "Indomart Spbu Amplas",
        "Naga Mas Amplas",
        "Kantor Camat Medan Amplas",
        "Simpang dua pematang Siantar",
        "Terminal Sosor Saba Parapat",
        "Indomaret Porsea Laguboti",
        "Indomaret SM Raja Sitoluama",
        "Alfamidi Hinalang Bagasan Balige",
        "Wisata Pemandian Air Panas Sipoholon",
      ],
      loket: [
        "Loket Balige",
        "Loket Tarutung",
        "Loket Terminal Tarutung ",
        "Loket Porsea",
        "Loket Medan",
      ],
      autoFill: false,
      user: {},
    };
  },
  mounted() {
    this.getSchedule();
    console.log('nilai autoFill:', this.autoFill);
    console.log('nilai userRole:', this.userRole); // Add this line
    console.log('nilai selectedSeat pada halaman confirmasi-pesanan.vue:', this.selectedSeat);
    // Update passenger.name and passenger.number_phone value when component is mounted
    if (!this.autoFill && this.userRole === 'passenger') {
      const access_token = localStorage.getItem("access_token");
      axios
        .get("api/user/profile", {
          headers: {
            Authorization: `Bearer ${access_token}`,
          },
        })
        .then((response) => {
          this.user = response.data;
          this.passenger.name = this.user.name;
          this.passenger.number_phone = this.user.phone_number;
        })
        .catch((error) => {
          console.log(error);
        });
    } else {
      // user will fill the input text manually
    }
  },
  watch: {
    autoFill: function (val) {
      if (val) {
        // If autoFill is active, set input field to not readonly
        this.passenger.name = "";
        this.passenger.number_phone = "";
      } else if (this.userRole === 'passenger') {
        // If autoFill is not active and userRole is 'passenger', set input field to readonly
        this.passenger.name = this.user.name;
        this.passenger.number_phone = this.user.phone_number;
      }
    },
  },
  methods: {
    ...mapActions(["setSelectedSeat"]),
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
      if (this.jemput) {
        if (!this.passenger.name || !this.passenger.number_phone) {
          this.snackbar = true;
          return;
        }
        this.$store.dispatch("setPassengerData", {
          name: this.passenger.name,
          number_phone: this.passenger.number_phone,
          alamatJemput: this.passenger.alamatJemput,
          selectedSeat: this.selectedSeat, // Sending selectedSeat to passenger data
        });
      } else {
        if (!this.passenger.name || !this.passenger.number_phone) {
          this.snackbar = true;
          return;
        }
        this.$store.dispatch("setPassengerData", {
          name: this.passenger.name,
          number_phone: this.passenger.number_phone,
          alamatJemput: this.schedule[0].derpature,
          selectedSeat: this.selectedSeat, // Sending selectedSeat to passenger data
        });
      }
      this.$router.push("/pembayaran");
    },
  },
};
</script>
