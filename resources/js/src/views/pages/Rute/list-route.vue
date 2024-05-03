<template>
  <v-card>
    <v-card-title>
      <v-btn class="mb-3" :to="{ name: 'pages-add-route' }" color="primary">
        Tambah Rute
      </v-btn>
      <v-spacer></v-spacer>
      <v-text-field v-model="search" append-icon="mdi-magnify" label="Cari" hide-details></v-text-field>
    </v-card-title>
    <v-data-table :headers="headers" :items="route" :search="search">
      <template #item.edit="{ item }">
        <v-btn small color="primary" :to="{ name: 'pages-edit-route', params: { id: item.id } }"><v-icon center>{{
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
import { mdiSwapHorizontalBold, mdiPencil, mdiTrashCanOutline } from '@mdi/js';
import Swal from 'sweetalert2';
export default {
  setup() {
    return {
      route: [
        'derpature',
        'arrival',
        'harga',
        'type',
      ],
      icons: {
        mdiSwapHorizontalBold,
        mdiPencil,
        mdiTrashCanOutline
      }

    }
  },
  data() {
    return {
      route: [],
      search: '',
      headers: [
        {
          text: 'Keberangkatan',
          align: '',
          sortable: false,
          value: 'derpature',

        },
        { text: 'Kedatangan', value: 'arrival' },
        { text: 'Type', value: 'type' },
        { text: 'Harga', value: 'harga' },
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
          `/api/routes/update/status/${id}`,
          {},
          {
            headers: {
              Authorization: `Bearer ${access_token}`,
            },
          }
        );
        this.route.find((route) => route.id === id).status = response.data.data.status;
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
          const route = this.route.find((route) => route.id === id);
          if (route) {
            route.status = !route.status;
          }
        }
      });
    },
  },
  mounted() {
    const access_token = localStorage.getItem('access_token');

    axios.get('/api/routes/show/all', {
      headers: {
        'Authorization': `Bearer ${access_token}`
      }
    }).then(response => {
      this.route = response.data.data;
      // console.log(this.route)
    }).catch(error => {
      console.log(error);
    });
  }
}
</script>
