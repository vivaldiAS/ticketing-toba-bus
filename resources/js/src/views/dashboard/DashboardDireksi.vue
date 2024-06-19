<template>
  <div>
  <v-card>
    <v-card-title class="align-start">
      <span class="font-weight-semibold">Statistics Card</span>
      <v-spacer></v-spacer>
      <v-btn icon small class="me-n3 mt-n2">
        <v-icon>
          {{ icons.mdiDotsVertical }}
        </v-icon>
      </v-btn>
    </v-card-title>

    <v-card-text>
      <v-row>
        <v-col cols="6" md="4" class="d-flex align-center">
          <v-avatar size="44" color="primary" rounded class="elevation-1">
            <v-icon dark color="white" size="30">
              {{ icons.mdiAccountOutline }}
            </v-icon>
          </v-avatar>
          <div class="ms-3">
            <p class="text-xs mb-0">Admin Kantor</p>
            <h3 class="text-xl font-weight-semibold">
              {{ adminkantor }}
            </h3>
          </div>
        </v-col>
        <v-col cols="6" md="4" class="d-flex align-center">
          <v-avatar size="44" color="primary" rounded class="elevation-1">
            <v-icon dark color="white" size="30">
              {{ icons.mdiTag }}
            </v-icon>
          </v-avatar>
          <div class="ms-3">
            <p class="text-xs mb-0">Total Merk</p>
            <h3 class="text-xl font-weight-semibold">
              {{ totalBrands }}
            </h3>
          </div>
        </v-col>
      </v-row>
    </v-card-text>
  </v-card>
  <br>
  <ListPenumpang />
</div>
</template>

<script>
import axios from "axios";
import ListPenumpang from "../pages/Penumpang/list-penumpang.vue"; // Pastikan path-nya sesuai dengan struktur proyek Anda
import { mdiAccountOutline, mdiDotsVertical, mdiTag } from "@mdi/js";

export default {
  components: {
    ListPenumpang, // Daftarkan komponen ListPenumpang di sini
  },
  data() {
    return {
      adminkantor: 0,
      totalBrands: 0,
    };
  },
  setup() {
    return {
      icons: {
        mdiDotsVertical,
        mdiAccountOutline,
        mdiTag,
      },
    };
  },
  mounted() {
    const access_token = localStorage.getItem("access_token");

    axios
      .get(`/api/statistik/direksi`, {
        headers: {
          Authorization: `Bearer ${access_token}`,
        },
      })
      .then((response) => {
        this.adminkantor = response.data.count_users;
        this.totalBrands = response.data.count_brands;
      })
      .catch((error) => {
        console.log(error);
      });
  },
};
</script>
