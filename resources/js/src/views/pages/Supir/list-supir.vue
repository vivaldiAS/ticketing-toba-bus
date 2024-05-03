<template>
  <v-card>
    <v-card-title>
      <v-btn class="mb-3" :to="{ name: 'pages-add-supir' }" color="primary">
        Tambah sopir
      </v-btn>
      <v-spacer></v-spacer>
      <v-text-field v-model="search" append-icon="mdi-magnify" label="Cari" hide-details></v-text-field>
    </v-card-title>
    <v-data-table :headers="headers" :items="supir" :search="search">
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
      supir: [
        'name',
        'email',
        'username',
        'phone_number',
        'address',
        'gender',
        'status'
      ],
      icons: {
        mdiPencil,
        mdiTrashCanOutline
      }
    }
  },
  data() {
    return {
      supir: [],
      search: '',
      headers: [
        {
          text: 'Nama Lengkap',
          align: '',
          sortable: false,
          value: 'name',

        },
        { text: 'Email', value: 'email' },
        { text: 'No.Handphone', value: 'phone_number' },
        { text: 'Jenis Kelamin', value: 'gender' },
        { text: 'Alamat', value: 'address' },
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
        this.supir.find((admin) => admin.id === id).status = response.data.data.status;
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
          const admin = this.supir.find((supir) => supir.id === id);
          if (admin) {
            admin.status = !admin.status;
          }
        }
      });
    },
  },

  mounted() {
    const access_token = localStorage.getItem('access_token');

    axios.get('/api/supir/all', {

      headers: {
        'Authorization': `Bearer ${access_token}`
      }
    }).then(response => {
      this.supir = response.data;
      // console.log(this.supir)
    }).catch(error => {
      console.log(error);
    })
  }
}
</script>
