<template>
  <div>
    <v-card class="mb-4">
      <v-card-text>
        <v-row>
          <v-col cols="6" md="4" class="d-flex align-center">
            <v-avatar size="44" color="primary" rounded class="elevation-1">
              <v-icon dark color="white" size="30">
                {{ icons.mdiAccountOutline }}
              </v-icon>
            </v-avatar>
            <div class="ms-3">
              <p class="text-xs mb-0">Supir</p>
              <h3 class="text-xl font-weight-semibold">
                {{ this.supir }}
              </h3>
            </div>
          </v-col>
          <v-col cols="6" md="4" class="d-flex align-center">
            <v-avatar size="44" color="success" rounded class="elevation-1">
              <v-icon dark color="white" size="30">
                {{ icons.mdiCar }}
              </v-icon>
            </v-avatar>
            <div class="ms-3">
              <p class="text-xs mb-0">Mobil</p>
              <h3 class="text-xl font-weight-semibold">
                {{ this.mobil }}
              </h3>
            </div>
          </v-col>
          <v-col cols="6" md="4" class="d-flex align-center">
            <v-avatar size="44" color="warning" rounded class="elevation-1">
              <v-icon dark color="white" size="30">
                {{ icons.mdiTrendingUp }}
              </v-icon>
            </v-avatar>
            <div class="ms-3">
              <p class="text-xs mb-0">Rute</p>
              <h3 class="text-xl font-weight-semibold">
                {{ this.rute }}
              </h3>
            </div>
          </v-col>
        </v-row>
      </v-card-text>
    </v-card>
    <ListSchedule />
  </div>
</template>

<script>
// eslint-disable-next-line object-curly-newline
import axios from "axios";
import ListSchedule from "../pages/Schedule/list-schedule.vue";

import {
  mdiAccountOutline,
  mdiCurrencyUsd,
  mdiTrendingUp,
  mdiDotsVertical,
  mdiLabelOutline,
  mdiCar,
} from "@mdi/js";

export default {
  components: {
    ListSchedule,
  },
  data() {
    return {
      SemuaData: {},
      supir: 0,
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
      .get(`/api/Dashboard/direksi/`, {
        headers: {
          Authorization: `Bearer ${access_token}`,
        },
      })
      .then((response) => {
        this.SemuaData = response.data;
        this.supir = this.SemuaData.supir;
        this.mobil = this.SemuaData.mobil;
        this.rute = this.SemuaData.rute;
        console.log(this.SemuaData);
        console.log(this.SemuaData.supir);
      })
      .catch((error) => {
        console.log(error);
      });
  },
  components: { ListSchedule },
};
</script>
