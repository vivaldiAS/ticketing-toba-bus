<template>
  <v-card>
    <v-card-title>
      <v-btn class="mb-3" :to="{ name: 'pages-add-mobil' }" color="primary">
        Tambah Mobil
      </v-btn>
      <v-spacer></v-spacer>
      <v-text-field v-model="search" append-icon="mdi-magnify" label="Cari" hide-details></v-text-field>
    </v-card-title>
    <v-data-table :headers="headers" :items="buss" :search="search">
      <template #item.action="{ item }">
        <v-btn small color="primary" :to="{ name: 'pages-edit-mobil', params: { id: item.id } }"><v-icon center>{{
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
      buss: [
        'police_number',
        'name',
        'number_of_seats',
        'type',
        'status',
      ],
      icons: {
        mdiPencil,
        mdiTrashCanOutline
      }
    }
  },
  data() {
    return {
      buss: [],
      supir: [],
      search: '',
      headers: [
        {
          text: 'Nomor Polisi',
          align: '',
          sortable: false,
          value: 'police_number',

        },
        { text: 'Nomor Pintu', value: 'nomor_pintu' },
        { text: 'Sopir', value: 'name' },
        { text: 'Jumlah Seat', value: 'number_of_seats' },
        { text: 'Type', value: 'type' },
        { text: 'Loket', value: 'nama_loket' },
        { text: 'Action', value: 'action', align: 'center', sortable: false },
        { text: 'Status', value: 'status', align: 'center', sortable: false }
      ],
    }
  },
  methods: {
    async updateStatus(id) {
      const access_token = localStorage.getItem("access_token");

      try {
        const response = await axios.put(
          `/api/bus/update/status/${id}`,
          {},
          {
            headers: {
              Authorization: `Bearer ${access_token}`,
            },
          }
        );
        this.buss.find((buss) => buss.id === id).status = response.data.data.status;
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
          const admin = this.buss.find((admin) => admin.id === id);
          if (admin) {
            admin.status = !admin.status;
          }
        }
      });
    },
  },
  mounted() {
    const access_token = localStorage.getItem('access_token');

    axios.get('/api/buss/show/all', {
      headers: {
        'Authorization': `Bearer ${access_token}`
      }
    }).then(response => {
      this.buss = response.data.data;
      console.log(this.buss)
    }).catch(error => {
      console.log(error);
    });
  }
}
</script>
