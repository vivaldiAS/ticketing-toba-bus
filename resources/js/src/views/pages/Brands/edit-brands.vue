<template>
    <v-card class="ml-3">
      <v-card-title>Edit Brands</v-card-title>
      <v-card-text>
        <v-form class="bg-light">
          <v-row>
            <v-col cols="12" md="3">
              <label for="firstname">Nama Merk</label>
            </v-col>
  
            <v-col cols="12" md="9">
              <v-text-field
                id="nama_brand"
                v-model="brand.merk"
                outlined
                dense
                placeholder="Nama brand"
                hide-details
              ></v-text-field>
            </v-col>
  
            <v-col cols="12" md="3">
              <label for="mobile">Admin brand</label>
            </v-col>
  
            <v-col cols="12" md="9">
              <v-select
                v-model="brand.admin_id"
                :items="adminbrand"
                item-value="id"
                item-text="name"
                outlined
                dense
                placeholder="Pilih Admin brand"
                @change="saveSelectedItemId"
              ></v-select>
            </v-col>
  
            <v-col offset-md="3" cols="12">
              <v-btn color="primary" @click.prevent="updatebrand">Submit</v-btn>
              <v-btn type="reset" class="mx-2" outlined>Reset</v-btn>
            </v-col>
          </v-row>
        </v-form>
      </v-card-text>
    </v-card>
  </template>
  
  <script>
  import axios from "axios";
  import { ref } from "@vue/composition-api";
  export default {
    setup() {
      const brand = ref({
        merk: "",
        admin_id: ""
      });
      const adminbrand = ref([]);
      return {
        adminbrand,
        brand,
      };
    },
    mounted() {
      this.fetchData();
    },
    methods: {
      async fetchData() {
        const access_token = localStorage.getItem("access_token");
        const id = this.$route.params.id;
  
        try {
          const brandResponse = await axios.get(`/api/brands/${id}`, {
            headers: {
              Authorization: `Bearer ${access_token}`,
            },
          });
          this.brand = {
            merk: brandResponse.data.data.merk,
            admin_id: brandResponse.data.data.admin_id,
          };
  
          const adminResponse = await axios.get("/api/GetAdminKantor/notAssociated", {
            headers: {
              Authorization: `Bearer ${access_token}`,
            },
          });
          this.adminbrand = adminResponse.data
            .filter((item) => item.status === 1)
            .map((item) => ({
              name: item.name,
              id: item.id,
            }));
          console.log("adminbrand", this.adminbrand);
        } catch (error) {
          console.log(error);
        }
      },
      async updatebrand() {
        const access_token = localStorage.getItem("access_token");
        const id = this.$route.params.id;
        try {
          await axios.put(`/api/udpate-brands/${id}`, this.brand, {
            headers: {
              Authorization: `Bearer ${access_token}`,
            },
          });
          this.$router.push({ name: "list-brands" }); 
        } catch (error) {
          console.error(error);
        }
      },
      saveSelectedItemId() {
        console.log("Selected item id:", this.brand.admin_id);
      },
    },
  };
  </script>
  