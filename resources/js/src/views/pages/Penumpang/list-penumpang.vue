<template>
  <v-card>
    <v-card-title>
      <v-btn class="mb-3" :to="{ name: 'pages-add-admin-loket' }" color="primary">
        Users
      </v-btn>
      <v-spacer></v-spacer>
      <v-text-field v-model="search" append-icon="mdi-magnify" label="Cari" hide-details></v-text-field>
    </v-card-title>
    <v-data-table
      :headers="headers"
      :items="adminLoket"
      :search="search"
      :item-class="getRowClass"
    >
      <template #item.edit="{ item }">
        <v-btn small color="primary" :to="{ name: 'pages-edit-user', params: { id: item.id } }">
          <v-icon center>{{ icons.mdiPencil }}</v-icon>
        </v-btn>
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
      icons: {
        mdiPencil,
        mdiTrashCanOutline
      }
    }
  },

  data() {
    return {
      adminLoket: [],
      search: '',
      headers: [
        { text: 'Nama Lengkap', align: '', sortable: false, value: 'name' },
        { text: 'Email', value: 'email' },
        { text: 'No.Handphone', value: 'phone_number' },
        { text: 'Jenis Kelamin', value: 'gender' },
        { text: 'Alamat', value: 'address' },
        { text: 'Jumlah Pembayaran Kadaluwarsa', value: 'jumlah_pembayaran_expired' },
        { text: 'Edit', value: 'edit', align: 'center', sortable: false },
        { text: 'Status', value: 'status', align: 'center', sortable: false }
      ],
    }
  },

  methods: {
    async updateStatus(id) {
      const access_token = localStorage.getItem("access_token");

      try {
        const response = await axios.put(
          `/api/account/update/status/${id}`,
          {},
          {
            headers: {
              Authorization: `Bearer ${access_token}`,
            },
          }
        );
        this.adminLoket.find((admin) => admin.id === id).status = response.data.data.status;
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
          const admin = this.adminLoket.find((admin) => admin.id === id);
          if (admin) {
            admin.status = !admin.status;
          }
        }
      });
    },

    getRowClass(item) {
      if (item.jumlah_pembayaran_expired >= 3 && item.status !== 0) {
        return 'pink-background';
      }
      return '';
    },
  },

  mounted() {
    const access_token = localStorage.getItem('access_token');

    axios
      .get('/api/user/all', {
        headers: {
          Authorization: `Bearer ${access_token}`,
        },
      })
      .then((response) => {
        this.adminLoket = response.data;
        console.log(this.adminLoket);
      })
      .catch((error) => {
        console.log(error);
      });
  },
};
</script>

<style>
.pink-background {
  background-color: rgb(235, 112, 132) !important;
}
</style>
