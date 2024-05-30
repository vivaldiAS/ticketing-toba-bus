<template>
    <v-card class="ml-3">
      <v-card-title>Tambah Brand</v-card-title>
      <v-card-text>
        <v-form class="bg-light">
          <v-row>
            <v-col cols="12" md="3">
              <label for="firstname">Nama Brand</label>
            </v-col>
  
            <v-col cols="12" md="9">
              <v-text-field
                id="nama_Brand"
                v-model="Brand.nama_Brand"
                outlined
                dense
                placeholder="Nama Brand"
                :error-messages="errors.nama_Brand"
              ></v-text-field>
            </v-col>
  
            <v-col cols="12" md="3">
              <label for="mobile">Admin Brand</label>
            </v-col>
  
            <v-col cols="12" md="9">
              <v-select
                v-model="Brand.id"
                :items="adminBrand"
                item-value="id"
                item-text="name"
                outlined
                dense
                placeholder="Pilih Admin Brand"
                @change="saveSelectedItemId"
                :error-messages="errors.admin_id"
              ></v-select>
            </v-col>
  
            <v-col offset-md="3" cols="12">
              <v-btn color="primary" @click.prevent="AddBrand">Submit</v-btn>
              <v-btn type="reset" class="mx-2" outlined>Reset</v-btn>
            </v-col>
          </v-row>
        </v-form>
      </v-card-text>
    </v-card>
  </template>
  
  <script>
  import axios from "axios";
  import Swal from "sweetalert2";
  import { ref } from "@vue/composition-api";
  
  export default {
    setup() {
      const errors = ref({});
      return { errors };
    },
    data() {
      return {
        adminBrand: [],
        Brand: {
          nama_Brand: '',
          id: null,
        },
      };
    },
    mounted() {
      const access_token = localStorage.getItem("access_token");
      axios
        .get("api/GetAdminKantor/notAssociated", {
          headers: {
            Authorization: `Bearer ${access_token}`,
          },
        })
        .then((response) => {
          this.adminBrand = response.data
            .filter((item) => item.status == 1)
            .map((item) => ({
              name: item.name,
              id: item.id,
            }));
          console.log("ini", this.adminBrand);
        })
        .catch((error) => {
          console.log(error);
        });
    },
    methods: {
      AddBrand() {
        const access_token = localStorage.getItem("access_token");
  
        console.log("Nama Brand:", this.Brand.nama_Brand);
        console.log("Admin ID:", this.Brand.id);
  
        axios
          .post(
            "api/registrasi/brands",
            {
              merk: this.Brand.nama_Brand,
              admin_id: String(this.Brand.id), // Ensure admin_id is a string
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
              name: "list-brands",
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
        console.log("Selected item id:", this.Brand.id);
      },
    },
  };
  </script>
  