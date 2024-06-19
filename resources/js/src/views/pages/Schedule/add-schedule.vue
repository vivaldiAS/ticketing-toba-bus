<template>
  <v-card class="ml-3">
    <v-card-title>Tambah Jawal</v-card-title>
    <v-card-text>
      <v-form class="bg-light">
        <v-row>
          <v-col cols="12" md="3">
            <label for="bus">Bus</label>
          </v-col>
          <v-col cols="12" md="9">
            <v-autocomplete
              v-model="schedule.bus_id"
              :items="bus"
              item-value="id"
              item-text="police_number"
              outlined
              dense
              placeholder="Pilih Bus"
              @change="saveSelectBus"
              :error-messages="errors.bus_id"
            ></v-autocomplete>
          </v-col>

          <v-col cols="12" md="3">
            <label for="rute">Rute</label>
          </v-col>
          <v-col cols="12" md="9">
            <v-autocomplete
              v-model="schedule.route_id"
              :items="route.filter((route) => route.type === selectedBusType)"
              item-value="id"
              item-text="derpature"
              outlined
              dense
              search
              placeholder="Pilih Rute"
              @change="saveSelectRoute"
              :error-messages="errors.route_id"
            ></v-autocomplete>
          </v-col>
          <v-col cols="12" md="3">
            <label for="rute">Tanggal</label>
          </v-col>
          <v-col cols="12" md="9">
            <v-text-field
              id="rute"
              v-model="schedule.tanggal"
              type="datetime-local"
              outlined
              dense
              placeholder="Tanggal"
              :error-messages="errors.tanggal"
              :rules="[validateDate]"
              :min="now"
            ></v-text-field>
          </v-col>

          <v-col cols="12" md="3">
            <label for="rute">Harga</label>
          </v-col>

          <v-col cols="12" md="9">
            <v-row>
              <v-col cols="12" md="1" class="text-right mt-2"><b>Rp</b></v-col>
              <v-col cols="12" md="11">
                <v-text-field
                  id="rute"
                  v-model="schedule.harga"
                  type="number"
                  outlined
                  dense
                  placeholder="Harga"
                  readonly
                  :error-messages="errors.harga"
                ></v-text-field>
              </v-col>
            </v-row>
          </v-col>

          <v-col offset-md="3" cols="12">
            <v-btn @click.prevent="AddSchedule" color="primary"> Submit </v-btn>
            <v-btn type="reset" class="mx-2" outlined> Reset </v-btn>
          </v-col>
        </v-row>
      </v-form>
    </v-card-text>
  </v-card>
</template>

<script>
// import { ref } from '@vue/composition-api'
import axios from "axios";
import { ref } from "@vue/composition-api";
import Swal from "sweetalert2";
export default {
  setup() {
    const errors = ref({});
    return {
      errors,
    };
  },
  data() {
    return {
      schedule: {
        bus_id: null,
        route_id: null,
        tanggal: null,
        harga: null,
      },
      bus: [],
      route: [],
      selectedBusType: null,
      selectedBusPrice: null,
      now: new Date().toISOString().slice(0, 16), // Current date and time in "yyyy-MM-ddTHH:mm" format
    };
  },
  mounted() {
    const access_token = localStorage.getItem("access_token");
    // rute
    axios
      .get("api/routes/show/all", {
        headers: {
          Authorization: `Bearer ${access_token}`,
        },
      })
      .then((response) => {
        this.route = response.data.data
          .filter((item) => item.status == 1) // Filter dengan supir.status = 1
          .map((item) => {
            return {
              id: item.id,
              derpature: item.derpature + " - " + item.arrival,
              arrival: item.arrival,
              type: item.type,
              harga: item.harga,
            };
          });
        // console.log(this.route)
      })
      .catch((error) => {
        console.log(error);
      });
    // bus
    axios
      .get("/api/buss/show/noJadwal", {
        headers: {
          Authorization: `Bearer ${access_token}`,
        },
      })
      .then((response) => {
        this.bus = response.data.data
          .filter((item) => item.status == 1) // Filter dengan supir.status = 1
          .map((item) => {
            return {
              id: item.id,
              police_number: item.police_number + "(" + item.nomor_pintu + ")",
              type: item.type,
            };
          });
        console.log(this.bus);
      })
      .catch((error) => {
        console.log(error);
      });
  },
  methods: {
    saveSelectBus() {
      const selectedBus = this.bus.find((bus) => bus.id === this.schedule.bus_id);
      if (selectedBus) {
        this.selectedBusType = selectedBus.type;
        console.log(this.selectedBusType);
        this.schedule.bus_id = selectedBus.id;
        this.schedule.harga = null; // Reset harga saat tipe bus berubah
      }
    },
    saveSelectRoute() {
      const selectedRoute = this.route.find(
        (route) => route.id === this.schedule.route_id
      );
      if (selectedRoute) {
        this.selectedBusPrice = selectedRoute.harga;
        this.schedule.route_id = selectedRoute.id;
        this.schedule.harga = selectedRoute.harga;
      }
    },
    validateDate(value) {
      if (value < this.now) {
        return 'Tanggal dan waktu tidak boleh di masa lalu';
      }
      return true;
    },
    AddSchedule() {
      const access_token = localStorage.getItem("access_token");
      axios
        .post(
          "/api/schedule/add",  // Ensure correct URL with leading slash
          {
            bus_id: this.schedule.bus_id,
            route_id: this.schedule.route_id,
            tanggal: this.schedule.tanggal,
            harga: this.schedule.harga,
          },
          {
            headers: {
              Authorization: `Bearer ${access_token}`,
            },
          }
        )
        .then((response) => {
          this.message = response.data.message;

          Swal.fire({
            icon: "success",
            title: "Berhasil",
            text: this.message,
          });
          this.$router.push({
            name: "pages-schedule",
          });
        })
        .catch((error) => {
          if (error.response && error.response.status === 422) {
            this.errors = error.response.data.data;
            this.errors_general = error.response.data.message;
          } else {
            console.error('An error occurred:', error.message);
            Swal.fire({
              icon: 'error',
              title: 'Error',
              text: 'An unexpected error occurred. Please try again later.',
            });
          }
        });
    }
  },
};
</script>
<style scoped>
.v-messages.error--text {
  color: red; /* Customize the error message text color */
}
</style>
