<template>
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
              {{ this.adminkantor }}
            </h3>
          </div>
        </v-col>
      </v-row>
    </v-card-text>
  </v-card>



</template>

<script>
// eslint-disable-next-line object-curly-newline
import axios from "axios";

import {
  mdiAccountOutline,
  mdiCurrencyUsd,
  mdiTrendingUp,
  mdiDotsVertical,
  mdiLabelOutline,
  mdiCar,
} from "@mdi/js";

export default {
  data() {
    return {
      SemuaData: {},
      adminkantor: 0,
      mobil: 0,
      rute: 0,
    };
  },
  setup() {
    return {
      // icons
      icons: {
        mdiDotsVertical,
        mdiTrendingUp,
        mdiAccountOutline,
        mdiLabelOutline,
        mdiCurrencyUsd,
        mdiCar,
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
        this.SemuaData = response.data;
        this.adminkantor = this.SemuaData.count;
        console.log(this.SemuaData);
        console.log(this.SemuaData.adminkantor);
      })
      .catch((error) => {
        console.log(error);
      });
  },
};
</script>
