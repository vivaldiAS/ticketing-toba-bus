<template>
  <v-card>
    <v-card-title>
      <v-btn class="mb-3" :to="{ name: 'pages-add-loket' }" color="primary">
        Tambah Loket
      </v-btn>
      <v-spacer></v-spacer>
      <v-text-field v-model="search" append-icon="mdi-magnify" label="Cari" hide-details></v-text-field>
    </v-card-title>
    <v-data-table :headers="headers" :items="loket" :search="search">
      <template #item.edit="{ item }">
        <v-btn small color="primary" :to="{ name: 'pages-edit-lokets', params: { id: item.id } }"><v-icon center>{{
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
      loket: [
        'nama_loket',
        'lokasi_loket',
        'admin loket',
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
      loket: [],
      search: '',
      headers: [
        {
          text: 'Nama Loket',
          align: '',
          sortable: false,
          value: 'nama_loket',

        },
        { text: 'Lokasi Loket', value: 'lokasi_loket' },
        { text: 'Admin loket', value: 'name' },
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
          `/api/update/status/loket/${id}`,
          {},
          {
            headers: {
              Authorization: `Bearer ${access_token}`,
            },
          }
        );
        this.loket.find((loket) => loket.id === id).status = response.data.data.status;
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
          const loket = this.loket.find((loket) => loket.id === id);
          if (loket) {
            loket.status = !loket.status;
          }
        }
      });
    },
  },
  mounted() {
    const access_token = localStorage.getItem('access_token');

    axios.get('/api/loket/all', {
      headers: {
        'Authorization': `Bearer ${access_token}`
      }
    }).then(response => {
      this.loket = response.data;
      console.log(this.loket)
    }).catch(error => {
      console.log(error);
    });
  }
}
</script>
