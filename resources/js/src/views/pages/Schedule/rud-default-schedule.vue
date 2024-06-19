<template>
    <v-card class="ml-3">
      <v-card-title>Edit Jadwal Default</v-card-title>
      <v-card-text>
        <v-form class="bg-light">
          <v-row>
            <v-col cols="12" md="3">
              <label for="bus">Bus</label>
            </v-col>
            <v-col cols="12" md="9">
              <v-select
                id="bus"
                v-model="data.bus"
                :items="busOptions"
                outlined
                dense
                placeholder="Pilih Bus"
                :error-messages="errors.bus"
              ></v-select>
            </v-col>
            <v-col cols="12" md="3">
              <label for="route">Rute</label>
            </v-col>
            <v-col cols="12" md="9">
              <v-select
                id="route"
                v-model="data.route"
                :items="routeOptions"
                outlined
                dense
                placeholder="Pilih Rute"
                :error-messages="errors.route"
                @change="fetchHargaByRoute"
              ></v-select>
            </v-col>
            <v-col cols="12" md="3">
              <label for="day">Hari</label>
            </v-col>
            <v-col cols="12" md="9">
              <v-select
                id="day"
                v-model="data.day"
                :items="dayOptions"
                outlined
                dense
                placeholder="Pilih Hari"
                :error-messages="errors.day"
              ></v-select>
            </v-col>
            <v-col cols="12" md="3">
              <label for="time">Jam</label>
            </v-col>
            <v-col cols="12" md="9">
              <v-text-field
                id="time"
                v-model="data.time"
                outlined
                dense
                placeholder="Jam"
                :error-messages="errors.time"
                mask="##:##:##"
              ></v-text-field>
            </v-col>
            <v-col cols="12" md="3">
              <label for="harga">Harga</label>
            </v-col>
            <v-col cols="12" md="9">
              <v-text-field
                id="harga"
                v-model="data.harga"
                outlined
                dense
                placeholder="Harga"
                :error-messages="errors.harga"
              ></v-text-field>
            </v-col>
            <v-col offset-md="3" cols="12">
              <v-btn @click.prevent="editRoute" color="primary">Submit</v-btn>
              <v-btn type="reset" class="mx-2" outlined>Reset</v-btn>
            </v-col>
          </v-row>
        </v-form>
      </v-card-text>
    </v-card>
  </template>
  
  <script>
  import { ref, onMounted } from "@vue/composition-api";
  import Swal from "sweetalert2";
  import axios from "axios";
  
  export default {
    setup() {
      const errors = ref({});
      const data = ref({
        id: null,
        bus: null,
        route: null,
        day: null,
        time: null,
        harga: null
      });
  
      const busOptions = ref([]);
      const routeOptions = ref([]);
      const dayOptions = ref([
        { text: 'Minggu', value: 0 },
        { text: 'Senin', value: 1 },
        { text: 'Selasa', value: 2 },
        { text: 'Rabu', value: 3 },
        { text: 'Kamis', value: 4 },
        { text: 'Jumat', value: 5 },
        { text: 'Sabtu', value: 6 }
      ]);
  
      const fetchBusOptions = async () => {
        const access_token = localStorage.getItem("access_token");
        try {
          const response = await axios.get("/api/buss/show/all", {
            headers: {
              Authorization: `Bearer ${access_token}`
            }
          });
          busOptions.value = response.data.data.map(bus => ({
            text: `${bus.police_number} - ${bus.nomor_pintu}`,
            value: bus.id
          }));
        } catch (error) {
          console.error(error);
        }
      };
  
      const fetchRouteOptions = async () => {
        const access_token = localStorage.getItem("access_token");
        try {
          const response = await axios.get("/api/routes/show/all", {
            headers: {
              Authorization: `Bearer ${access_token}`
            }
          });
          routeOptions.value = response.data.data.map(route => ({
            text: `${route.derpature} - ${route.arrival}`,
            value: route.id,
            harga: route.harga
          }));
        } catch (error) {
          console.error(error);
        }
      };
  
      const fetchHargaByRoute = () => {
        const selectedRouteId = data.value.route;
        const selectedRoute = routeOptions.value.find(route => route.value === selectedRouteId);
        if (selectedRoute) {
          data.value.harga = selectedRoute.harga;
        } else {
          data.value.harga = null;
        }
      };
  
      const editRoute = async () => {
        const access_token = localStorage.getItem("access_token");
        try {
          const response = await axios.put(`/api/default-schedules/edit/${data.value.id}`, {
            bus_id: data.value.bus,
            route_id: data.value.route,
            day_of_week: data.value.day,
            time: data.value.time,
            harga: data.value.harga
          }, {
            headers: {
              Authorization: `Bearer ${access_token}`
            }
          });
  
          Swal.fire({
            icon: "success",
            title: "Berhasil",
            text: response.data.message
          }).then(() => {
            this.$router.push({ name: 'pages-default-schedules' }); // Arahkan ke halaman list admin
          });
        } catch (error) {
          if (error.response.status === 422) {
            errors.value = error.response.data.data;
          }
        }
      };
  
      const fetchData = async () => {
        try {
          const access_token = localStorage.getItem("access_token");
          const id = window.location.href.split('/').pop(); // Mendapatkan id dari URL
          const response = await axios.get(`/api/default-schedules/${id}`, {
            headers: {
              Authorization: `Bearer ${access_token}`
            }
          });
          const responseData = response.data;
          // Mengisi data dengan respons dari API
          data.value.id = responseData.id;
          data.value.bus = responseData.bus_id;
          data.value.route = responseData.route_id;
          data.value.day = responseData.day_of_week;
          data.value.time = responseData.time;
          data.value.harga = responseData.harga;
        } catch (error) {
          console.error(error);
        }
      };
  
      // Panggil fetchData saat komponen di-mount
      onMounted(() => {
        fetchData();
        fetchBusOptions();
        fetchRouteOptions();
      });
  
      return {
        errors,
        data,
        busOptions,
        routeOptions,
             dayOptions,
      editRoute, // Tambahkan fungsi editRoute ke dalam objek yang dikembalikan
      fetchHargaByRoute
    };
  }
};
</script>

<style scoped>
/* CSS styles here */
</style>

  