<template>
  <v-card class="ml-3">
    <v-card-title>Edit Loket</v-card-title>
    <v-card-text>
      <v-form class="bg-light">
        <v-row>
          <v-col cols="12" md="3">
            <label for="firstname">Nama Loket</label>
          </v-col>

          <v-col cols="12" md="9">
            <v-text-field id="nama_loket" v-model="loket.nama_loket" outlined dense placeholder="Nama Loket"
              hide-details></v-text-field>
          </v-col>
          <v-col cols="12" md="3">
            <label for="firstname">Lokasi Loket</label>
          </v-col>
          <v-col cols="12" md="9">
            <v-text-field id="loak" v-model="loket.lokasi_loket" outlined dense placeholder="Lokasi Loket"
              hide-details></v-text-field>
          </v-col>

          <v-col cols="12" md="3">
            <label for="mobile">Admin Loket</label>
          </v-col>

          <v-col cols="12" md="9">
            <v-select v-model="loket.admin" :items="adminloket" item-value="id" item-text="name" outlined dense
              placeholder="Pilih Admin Loket" @change="saveSelectedItemId"></v-select>
          </v-col>

          <v-col offset-md="3" cols="12">
            <v-btn color="primary" @click.prevent="updateLoket"> Submit </v-btn>
            <v-btn type="reset" class="mx-2" outlined> Reset </v-btn>
          </v-col>
        </v-row>
      </v-form>
    </v-card-text>
  </v-card>
</template>

<script>
import axios from "axios";
import { ref } from "@vue/composition-api";
export default
  {
    setup() {
      const loket = ref({
        nama_loket: "",
        lokasi_loket: "",
        admin: ""
      });
      const adminloket = ref([])
      return {
        adminloket,
        loket,
      };
    },
    mounted() {
      const access_token = localStorage.getItem("access_token");
      const id = this.$route.params.id;

      axios
        .get(`/api/loket/get/${id}`, {
          headers: {
            Authorization: `Bearer ${access_token}`,
          },
        })
        .then((response) => {
          this.loket = response.data.data;
          this.loket.admin = response.data.data.admin_id;
          // console.log(response.data.data.admin_id);
        })
        .catch((error) => {
          console.log(error);
        });

      axios
        .get("/api/admin-loket/all", {
          headers: {
            Authorization: `Bearer ${access_token}`,
          },
        })
        .then((response) => {
          this.adminloket = Object.values(response.data)
            .filter((item) => item.status == 1) // Filter dengan supir.status = 1
            .map((item) => {
              return {
                name: item.name,
                id: item.id,
              };
            });
          console.log("ini", this.adminloket);
        })
        .catch((error) => {
          console.log(error);
        });
    },
    methods: {
      async updateLoket() {
        const access_token = localStorage.getItem('access_token');
        const id = this.$route.params.id;
        try {
          await axios.put(`/api/loket/update/${id}`, this.loket, {
            headers: {
              Authorization: `Bearer ${access_token}`,
            },
          });
          // console.log(response.data.data.role_id);
          this.$router.push({ name: 'pages-loket' }); // Arahkan ke halaman list admin

        } catch (error) {
          console.error(error);
          // Handle error, show an error message, or perform any other actions.
        }

      },
      saveSelectedItemId() {
        // Simpan selectedItem.id ke database di sini
        console.log('Selected item id:', this.loket.admin);
      },
    },
  };
</script>
