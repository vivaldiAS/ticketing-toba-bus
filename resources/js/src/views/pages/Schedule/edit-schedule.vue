<template>
  <v-card class="ml-3">
    <v-card-title>Edit Jadwal</v-card-title>
    <v-card-text>
      <v-form class="bg-light">
        <v-row>
          <v-col cols="12" md="3">
            <label for="bus">Bus</label>
          </v-col>
          <v-col cols="12" md="9">
            <v-autocomplete v-model="schedule.bus_id" :items="bus" item-value="id" item-text="police_number" outlined
              dense hide-details placeholder="Pilih Bus" @change="saveSelectBus"></v-autocomplete>
          </v-col>

          <v-col cols="12" md="3">
            <label for="rute">Rute</label>
          </v-col>
          <v-col cols="12" md="9">
            <v-autocomplete v-model="schedule.route_id" :items="route.filter((route) => route.type === selectedBusType)"
              item-value="id" item-text="derpature" outlined dense search placeholder="Pilih Rute" hide-details
              @change="saveSelectRoute"></v-autocomplete>
          </v-col>
          <v-col cols="12" md="3">
            <label for="rute">Tanggal</label>
          </v-col>
          <v-col cols="12" md="9">
            <v-text-field id="rute" v-model="schedule.tanggal" type="datetime-local" outlined dense placeholder="Tanggal"
              hide-details></v-text-field>
          </v-col>

          <v-col cols="12" md="3">
            <label for="rute">Harga</label>
          </v-col>

          <v-col cols="12" md="9">
            <v-row>
              <v-col cols="12" md="1" class="text-right mt-2"><b>Rp</b></v-col>
              <v-col cols="12" md="11">
                <v-text-field id="rute" v-model="schedule.harga" type="number" outlined dense placeholder="Harga" readonly
                  hide-details></v-text-field>
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
import { ref } from "@vue/composition-api";
import axios from "axios";

export default {
  setup() {
    const schedule = ref({
      bus_id: "",
      route_id: "",
      tanggal: "",
      harga: "",
    });
    const bus = ref([]);
    const route = ref([]);
    return {
      schedule,
      bus,
      route,
      selectedBusType: "",
      selectedBusPrice: "",
    };
  },
  mounted() {
    const access_token = localStorage.getItem("access_token");

    // Fetch routes
    axios
      .get("/api/routes/show/all", {
        headers: {
          Authorization: `Bearer ${access_token}`,
        },
      })
      .then((response) => {
        this.route = Object.values(response.data.data)
          .filter((item) => item.status === 1)
          .map((item) => ({
            id: item.id,
            derpature: item.derpature + " - " + item.arrival,
            arrival: item.arrival,
            type: item.type,
            harga: item.harga,
          }));
      })
      .catch((error) => {
        console.log(error);
      });

    // Fetch buses
    axios
      .get("/api/buss/show/all", {
        headers: {
          Authorization: `Bearer ${access_token}`,
        },
      })
      .then((response) => {
        this.bus = Object.values(response.data.data)
          .filter((item) => item.status === 1)
          .map((item) => ({
            id: item.id,
            police_number: item.police_number + "(" + item.nomor_pintu + ")",
            type: item.type,
          }));
      })
      .catch((error) => {
        console.log(error);
      });

    const id = this.$route.params.id;
    axios
      .get(`/api/schedule/show/${id}`, {
        headers: {
          Authorization: `Bearer ${access_token}`,
        },
      })
      .then((response) => {
        this.schedule = response.data.data[0];
        this.schedule.route_id = response.data.data[0].route_id;
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
        this.schedule.bus_id = selectedBus.id;
        this.schedule.harga = null;
      }
    },
    saveSelectRoute() {
      const selectedRoute = this.route.find((route) => route.id === this.schedule.route_id);
      if (selectedRoute) {
        this.selectedBusPrice = selectedRoute.harga;
        this.schedule.route_id = selectedRoute.id;
        this.schedule.harga = selectedRoute.harga;
      }
    },
    AddSchedule() {
      const access_token = localStorage.getItem("access_token");
      axios
        .post(
          "api/schedule/add",
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
          console.log(this.schedule);
          this.$router.push({
            name: "pages-schedule",
            query: { message: this.message },
          });
        })
        .catch((error) => {
          console.log(error.response.data.errors);
        });
    },
  },
};
</script>
