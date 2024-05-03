<template>
  <v-card class="ml-3">
    <v-card-title>Tambah Rute</v-card-title>
    <v-card-text>
      <v-form class="bg-light">
        <v-row>
          <v-col cols="12" md="3">
            <label for="depature">Keberangkatan</label>
          </v-col>

          <v-col cols="12" md="9">
            <v-text-field
              id="depature"
              v-model="routes.derpature"
              outlined
              dense
              placeholder="Keberangkatan"
              :error-messages="errors.derpature"
            ></v-text-field>
          </v-col>

          <v-col cols="12" md="3">
            <label for="username">Kedatangan</label>
          </v-col>

          <v-col cols="12" md="9">
            <v-text-field
              id="Username"
              v-model="routes.arrival"
              type="text"
              outlined
              dense
              placeholder="Kedatangan"
              :error-messages="errors.arrival"
            ></v-text-field>
          </v-col>

          <v-col cols="12" md="3">
            <label for="username">Harga</label>
          </v-col>

          <v-col cols="12" md="9">
            <v-text-field
              id="Username"
              v-model="routes.harga"
              type="text"
              outlined
              dense
              placeholder="Harga"
              :error-messages="errors.harga"
            ></v-text-field>
          </v-col>
          <v-col cols="12" md="3">
            <label for="username">Type</label>
          </v-col>

          <v-col cols="12" md="9">
            <v-select
              v-model="routes.type"
              :items="['Ekonomi', 'Eksekutif']"
              outlined
              dense
              placeholder="Type"
              :error-messages="errors.type"
            ></v-select>
          </v-col>

          <v-col offset-md="3" cols="12">
            <v-btn @click.prevent="AddRoute" color="primary"> Submit </v-btn>
            <v-btn type="reset" class="mx-2" outlined> Reset </v-btn>
          </v-col>
        </v-row>
      </v-form>
    </v-card-text>
  </v-card>
</template>

<script>
import { ref } from "@vue/composition-api";
import Swal from "sweetalert2";
import axios from "axios";

export default {
  setup() {
    const errors = ref({});

    return {
      routes: ["derpature", "arrival", "harga", "type"],
      errors,
    };
  },
  data() {
    return {};
  },
  methods: {
    AddRoute() {
      const access_token = localStorage.getItem("access_token");

      axios
        .post(
          "api/routes/add",
          {
            derpature: this.routes.derpature,
            arrival: this.routes.arrival,
            harga: this.routes.harga,
            type: this.routes.type,
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
            name: "pages-routes",
            query: { message: this.message },
          });
        })
        .catch((error) => {
          if (error.response.status === 422) {
            this.errors = error.response.data.data;
            this.errors_general = error.response.data.message;
            console.log(this.errors);
          }
        });
    },
  },
};
</script>
