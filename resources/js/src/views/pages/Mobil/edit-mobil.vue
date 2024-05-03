<template>
  <v-card class="ml-3">
    <v-card-title>Edit Mobil</v-card-title>
    <v-card-text>
      <v-form class="bg-light">
        <v-row>
          <v-col cols="12" md="3">
            <label for="firstname">Nomor Polisi</label>
          </v-col>

          <v-col cols="12" md="9">
            <v-text-field id="police_number" v-model="mobil.police_number" outlined dense placeholder="Nomor Polisi"
              hide-details></v-text-field>
          </v-col>
          <v-col cols="12" md="3">
            <label for="firstname">Nomor Pintu</label>
          </v-col>
          <v-col cols="12" md="9">
            <v-text-field id="nomor_pintu" v-model="mobil.nomor_pintu" outlined dense placeholder="Nomor Pintu"
              hide-details></v-text-field>
          </v-col>

          <v-col cols="12" md="3">
            <label for="email">Type</label>
          </v-col>

          <v-col cols="12" md="9">
            <v-select v-model="mobil.type" :items="['Ekonomi', 'Eksekutif']" outlined dense placeholder="Type" hide
              details></v-select>
            <!-- <v-text-field id="type" v-model="mobil.type" outlined dense placeholder="type" hide-details></v-text-field> -->
          </v-col>

          <v-col cols="12" md="3">
            <label for="mobile">Supir</label>
          </v-col>

          <v-col cols="12" md="9">
            <v-select v-model="mobil.driver" :items="supir" item-value="id" item-text="name" outlined dense
              placeholder="Pilih supir" @change="saveSelectedItemId" hide-details></v-select>
          </v-col>

          <v-col cols="12" md="3">
            <label for="mobile">Loket</label>
          </v-col>

          <v-col cols="12" md="9">
            <v-select v-model="mobil.loket" :items="loket" item-value="id" item-text="name" outlined dense
              placeholder="Pilih Loket" @change="saveSelectedItemId" hide-details></v-select>
          </v-col>

          <v-col cols="12" md="3">
            <label for="mobile">Jumlah Seats</label>
          </v-col>
          <v-col cols="12" md="9">
            <v-text-field id="num_seats" v-model="mobil.number_of_seats" type="number" outlined dense
              placeholder="Jumlah Seats" hide-details></v-text-field>
          </v-col>
          <v-col offset-md="3" cols="12">
            <v-btn color="primary" @click.prevent="UpdateMobil"> Submit </v-btn>
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
    const mobilData = ref({
      "police_number": "",
      "type": "",
      "driver": "",
      "number_of_seats": "",
      "nomor_pintu": "",
      "merk": "",
      "status": "",
    });
    const supir = ref([]);
    const loket = ref([]);

    return {
      supir,
      loket,
      mobil: mobilData,
    };
  },
  mounted() {
    const access_token = localStorage.getItem("access_token");

    // supir get
    axios
      .get("/api/supir/name/all", {
        headers: {
          Authorization: `Bearer ${access_token}`,
        },
      })
      .then((response) => {
        this.supir = Object.values(response.data)
        .filter((item) => item.status == 1) // Filter dengan supir.status = 1
        .map((item) => {
          return {
            name: item.name,
            id: item.id,
          };
        });
        console.log("supir", this.supir);
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
        this.loket = Object.values(response.data)
        .filter((item) => item.status == 1) // Filter dengan supir.status = 1
        .map((item) => {
          return {
            name: item.nama_loket,
            id: item.id,
          };
        });
        console.log("loket", this.loket);
      })
      .catch((error) => {
        console.log(error);
      });

    const id = this.$route.params.id;
    axios
      .get(`/api/bus/get/${id}`, {
        headers: {
          Authorization: `Bearer ${access_token}`,
        },
      })
      .then((response) => {
        this.mobil.police_number = response.data.data[0].police_number;
        this.mobil.type = response.data.data[0].type;
        this.mobil.driver = response.data.data[0].supir_id;
        this.mobil.loket = response.data.data[0].loket_id;
        this.mobil.number_of_seats = response.data.data[0].number_of_seats;
        this.mobil.nomor_pintu = response.data.data[0].nomor_pintu;
        this.mobil.merk = response.data.data[0].merk;
        this.mobil.status = response.data.data[0].status;
        console.log("all bus", this.mobil);
      })
      .catch((error) => {
        console.log(error);
      });
  },

  methods: {
    UpdateMobil() {
      const access_token = localStorage.getItem("access_token");
      const id = this.$route.params.id;
      axios
        .put(
          `/api/buss/update/${id}`,
          {
            police_number: this.mobil.police_number,
            type: this.mobil.type,
            supir_id: this.mobil.driver,
            loket_id: this.mobil.loket,
            number_of_seats: this.mobil.number_of_seats,
            nomor_pintu: this.mobil.nomor_pintu,
            merk_id: '1',
          },
          {
            headers: {
              Authorization: `Bearer ${access_token}`,
            },
          }
        )
        .then((response) => {
          this.$router.push({
            name: "pages-mobil",
            query: { message: this.message },
          });
        })
        .catch((error) => {
          console.log(error.response.data.errors);
        });
    },
    saveSelectedItemId() {
      // Simpan selectedItem.id ke database di sini
      // console.log('Selected item id:', this.mobil.driver);
    },
  },
};
</script>
