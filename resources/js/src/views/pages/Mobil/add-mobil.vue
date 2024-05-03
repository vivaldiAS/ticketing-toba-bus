<template>
  <v-card class="ml-3">
    <v-card-title>Tambah Mobil</v-card-title>
    <v-card-text>
      <v-form class="bg-light">
        <v-row>
          <v-col cols="12" md="3">
            <label for="firstname">Nomor Polisi</label>
          </v-col>

          <v-col cols="12" md="9">
            <v-text-field
              id="police_number"
              v-model="mobil.police_number"
              outlined
              dense
              placeholder="Nomor Polisi"
              :error-messages="errors.police_number"
            ></v-text-field>
          </v-col>
          <v-col cols="12" md="3">
            <label for="firstname">Nomor Pintu</label>
          </v-col>
          <v-col cols="12" md="9">
            <v-text-field
              id="nomor_pintu"
              v-model="mobil.nomor_pintu"
              outlined
              dense
              placeholder="Nomor Pintu"
              :error-messages="errors.nomor_pintu"
            ></v-text-field>
          </v-col>

          <v-col cols="12" md="3">
            <label for="email">Type</label>
          </v-col>

          <v-col cols="12" md="9">
            <v-select
              v-model="mobil.type"
              :items="['Ekonomi', 'Eksekutif']"
              @change="selectType"
              outlined
              dense
              placeholder="Type"
              :error-messages="errors.type"
            ></v-select>
            <!-- <v-text-field id="type" v-model="mobil.type" outlined dense placeholder="type" hide-details></v-text-field> -->
          </v-col>

          <v-col cols="12" md="3">
            <label for="mobile">Supir</label>
          </v-col>

          <v-col cols="12" md="9">
            <v-select
              v-model="mobil.driver"
              :items="supir"
              item-value="id"
              item-text="name"
              outlined
              dense
              placeholder="Pilih supir"
              @change="saveSelectedItemId"
              :error-messages="errors.supir_id"
            ></v-select>
          </v-col>

          <v-col cols="12" md="3">
            <label for="mobile">Loket</label>
          </v-col>

          <v-col cols="12" md="9">
            <v-select
              v-model="mobil.loket"
              :items="loket"
              item-value="id"
              item-text="name"
              outlined
              dense
              placeholder="Pilih Loket"
              @change="saveSelectedItemId"
              :error-messages="errors.loket_id"
            ></v-select>
          </v-col>

          <v-col offset-md="3" cols="12">
            <v-btn color="primary" @click.prevent="AddMobil"> Submit </v-btn>
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
import Swal from "sweetalert2";

export default {
  setup() {
    const police_number = ref("");
    const num_seats = ref("");
    const type = ref();
    const status = ref();
    const driver = ref();
    const errors = ref({});

    return {
      police_number,
      num_seats,
      type,
      status,
      driver,
      errors,
      mobil: [
        "police_number",
        "type",
        "driver",
        "number_of_seats",
        "nomor_pintu",
        "merk_id",
        "status",
      ],
    };
  },
  data() {
    return {
      supir: [],
      driver: null,
      loket: null,
      mobil: [],
    };
  },
  mounted() {
    const access_token = localStorage.getItem("access_token");
    axios
      .get("/api/buss/show/notAssociated", {
        headers: {
          Authorization: `Bearer ${access_token}`,
        },
      })
      .then((response) => {
        this.supir = response.data
          .filter((item) => item.status == 1) // Filter dengan supir.status = 1
          .map((item) => {
            return {
              name: item.name,
              id: item.id,
            };
          });
        console.log("ini", this.supir);
      })
      .catch((error) => {
        console.log(error);
      });

    // Loket Get
    axios
      .get("/api/loket/all", {
        headers: {
          Authorization: `Bearer ${access_token}`,
        },
      })
      .then((response) => {
        this.loket = response.data
          .filter((item) => item.status == 1) // Filter dengan supir.status = 1
          .map((item) => {
            return {
              name: item.nama_loket,
              id: item.id,
            };
          });
      })
      .catch((error) => {
        console.log(error);
      });
  },
  methods: {
    selectType() {
      if (this.mobil.type === "Ekonomi") {
        this.mobil.number_of_seats = "12";
      } else if (this.mobil.type === "Eksekutif") {
        this.mobil.number_of_seats = "12";
      }
    },
    AddMobil() {
      const access_token = localStorage.getItem("access_token");

      axios
        .post(
          "/api/buss/add",
          {
            police_number: this.mobil.police_number,
            type: this.mobil.type,
            supir_id: this.mobil.driver,
            number_of_seats: this.mobil.number_of_seats,
            nomor_pintu: this.mobil.nomor_pintu,
            merk_id: '1',
            loket_id: this.mobil.loket,
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
            name: "pages-mobil",
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

    saveSelectedItemId() {
      // Simpan selectedItem.id ke database di sini
      // console.log('Selected item id:', this.mobil.driver);
    },
  },
};
</script>
