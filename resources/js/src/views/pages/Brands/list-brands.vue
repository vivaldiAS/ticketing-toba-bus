<template>
    <v-card>
      <v-card-title>
        <v-btn class="mb-3" :to="{ name: 'pages-add-brands' }" color="primary">
          Tambah Brands
        </v-btn>
        <v-spacer></v-spacer>
        <v-text-field v-model="search" append-icon="mdi-magnify" label="Cari" hide-details></v-text-field>
      </v-card-title>
      <v-data-table :headers="headers" :items="brand" :search="search">
        <template #item.edit="{ item }">
          <v-btn small color="primary" :to="{ name: 'pages-edit-brands', params: { id: item.id } }"><v-icon center>{{
            icons.mdiPencil }}</v-icon></v-btn>
        </template>
        <template #item.status="{ item }">
          <v-switch v-model="item.status" @click="showConfirmation(item.id)" color="secondary" inset></v-switch>
        </template>
      </v-data-table>
    </v-card>
  </template>
  <script>
  import axios from 'axios';
  import { mdiPencil, mdiTrashCanOutline } from '@mdi/js';
  import Swal from 'sweetalert2';
  export default {
    setup() {
      return {
        brand: [
          'merk',
          'admin brand',
          'email',
        ],
        icons: {
          mdiPencil,
          mdiTrashCanOutline
        }
      }
    },
    data() {
      return {
        brand: [],
        search: '',
        headers: [
          {
            text: 'Nama Merk',
            align: '',
            sortable: false,
            value: 'merk',
  
          },
          { text: 'Admin Kantor', value: 'name' },
          { text: 'email', value: 'email' },
          { text: 'Edit', value: 'edit', align: 'center', sortable: false },
          { text: 'Status', value: 'status', sortable: false }
  
        ],
      }
    },
    methods: {
      async updateStatus(id) {
        const access_token = localStorage.getItem("access_token");
  
        try {
          const response = await axios.put(
            `/api/update/status-brands/${id}`,
            {},
            {
              headers: {
                Authorization: `Bearer ${access_token}`,
              },
            }
          );
          this.brand.find((brand) => brand.id === id).status = response.data.data.status;
        } catch (error) {
          console.log(error);
        }
      },
  
      showConfirmation(id) {
        Swal.fire({
          title: "Konfirmasi",
          text: "Apakah anda ingin mengubah status?",
          icon: "question",
          showCancelButton: true,
          confirmButtonColor: "primary",
          cancelButtonColor: "danger",
          confirmButtonText: "Ya",
          cancelButtonText: "Batal",
        }).then((result) => {
          if (result.isConfirmed) {
            this.updateStatus(id);
            Swal.fire("Berhasil!", "Status Telah diubah", "success");
          } else {
            // Revert the v-switch value back to its original state
            const brand = this.brand.find((brand) => brand.id === id);
            if (brand) {
              brand.status = !brand.status;
            }
          }
        });
      },
    },
    mounted() {
      const access_token = localStorage.getItem('access_token');
  
      axios.get('/api/allBrands', {
        headers: {
          'Authorization': `Bearer ${access_token}`
        }
      }).then(response => {
        this.brand = response.data;
        console.log(this.brand)
      }).catch(error => {
        console.log(error);
      });
    }
  }
  </script>
  