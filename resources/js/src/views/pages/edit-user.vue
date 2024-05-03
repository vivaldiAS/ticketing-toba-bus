<template>
  <v-card-text>
    <h3 class="">Edit User</h3>
    <v-form>
      <v-row>
        <v-col cols="12" md="6">
          <v-text-field v-model="user.name" :prepend-inner-icon="icons.mdiAccountOutline" label="Nama Lengkap" outlined
            dense placeholder="Nama Lengkap"></v-text-field>
        </v-col>
        <v-col cols="12" md="6">
          <v-text-field v-model="user.email" :prepend-inner-icon="icons.mdiEmailOutline" label="Email" type="email"
            outlined dense placeholder="Email"></v-text-field>
        </v-col>
        <v-col cols="12" md="6">
          <v-text-field v-model="user.username" :prepend-inner-icon="icons.mdiAccountOutline" label="Username" outlined
            dense placeholder="Username"></v-text-field>
        </v-col>
        <v-col cols="12" md="6">
          <v-text-field v-model="user.phone_number" :prepend-inner-icon="icons.mdiCellphone" label="Nomor Handphone"
            outlined dense type="number" placeholder="Nomor Handphone"></v-text-field>
        </v-col>
        <v-col cols="12" md="6">
          <v-select v-model="user.gender" :items="['Laki-laki', 'Perempuan']"
            :prepend-inner-icon="icons.mdiHumanMaleFemale" label="Jenis Kelamin" outlined dense
            placeholder="Jenis Kelamin"></v-select>
        </v-col>
        <v-col cols="12" md="6">
          <v-text-field v-model="user.address" :prepend-inner-icon="icons.mdiMapMarker" label="Alamat" outlined dense
            type="text" placeholder="Alamat"></v-text-field>
        </v-col>
      </v-row>
      <v-col cols="3" class="align-center">
        <v-btn color="primary" class="mt-6" @click.prevent="updateUser">Update</v-btn>
      </v-col>
    </v-form>
  </v-card-text>
</template>

<script>
import { mdiEyeOutline, mdiEyeOffOutline, mdiAccountOutline, mdiEmailOutline, mdiCellphone, mdiLockOutline, mdiHumanMaleFemale, mdiMapMarker } from '@mdi/js'
import { ref } from '@vue/composition-api'
import axios from 'axios'

export default {
  setup() {
    const isPasswordVisible = ref(false)
    const user = ref({}) // Declare user as a ref

    return {
      user,
      isPasswordVisible,
      icons: {
        mdiEyeOutline,
        mdiEyeOffOutline,
        mdiAccountOutline,
        mdiEmailOutline,
        mdiCellphone,
        mdiHumanMaleFemale,
        mdiLockOutline,
        mdiMapMarker
      },
    }
  },
  methods: {
    async updateUser() {
      const access_token = localStorage.getItem('access_token');
      const id = this.$route.params.id;
      try {
        const response = await axios.put(`/api/user/update/${id}`, this.user, {
          headers: {
            Authorization: `Bearer ${access_token}`,
          },
        });
        console.log(response.data.data.role_id);

        // Handle success, show a success message, or perform any other actions.
        if (response.data.data.role_id == 4) {
          this.$router.push({ name: 'pages-admin-loket' }); // Arahkan ke halaman list admin
        } else if (response.data.data.role_id == 3) {
          this.$router.push({ name: 'pages-supir' }); // Arahkan ke halaman list supir
        }
      } catch (error) {
        console.error(error);
        // Handle error, show an error message, or perform any other actions.
      }

    },
  },
  mounted() {
    const access_token = localStorage.getItem('access_token');
    const id = this.$route.params.id;
    axios
      .get(`/api/user/get/${id}`, {
        headers: {
          Authorization: `Bearer ${access_token}`,
        },
      })
      .then((response) => {
        this.user = response.data.data;
        // console.log(this.user);
      })
      .catch((error) => {
        console.log(error);
      });
  },
}
</script>
