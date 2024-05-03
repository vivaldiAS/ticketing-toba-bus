<template>
  <v-card class="ml-3">
    <v-card-title>Edit Rute</v-card-title>
    <v-card-text>
      <v-form class="bg-light">
        <v-row>
          <v-col cols="12" md="3">
            <label for="depature">Keberangkatan</label>
          </v-col>

          <v-col cols="12" md="9">
            <v-text-field id="depature" v-model="routes.derpature" outlined dense placeholder="Keberangkatan"
              hide-details></v-text-field>
          </v-col>

          <v-col cols="12" md="3">
            <label for="username">Kedatangan</label>
          </v-col>

          <v-col cols="12" md="9">
            <v-text-field id="Username" v-model="routes.arrival" type="text" outlined dense placeholder="Kedatangan"
              hide-details></v-text-field>
          </v-col>

          <v-col cols="12" md="3">
            <label for="harga">Harga</label>
          </v-col>

          <v-col cols="12" md="9">
            <v-text-field id="harga" v-model="routes.harga" type="number" outlined dense placeholder="Harga"
              hide-details></v-text-field>
          </v-col>
          <v-col cols="12" md="3">
            <label for="type">Type</label>
          </v-col>

          <v-col cols="12" md="9">
            <v-select v-model="routes.type" :items="['Ekonomi', 'Eksekutif']" outlined dense placeholder="Type" hide
              details></v-select>
          </v-col>


          <v-col offset-md="3" cols="12">
            <v-btn @click.prevent="updateRoute" color="primary">
              Submit
            </v-btn>
            <v-btn type="reset" class="mx-2" outlined>
              Reset
            </v-btn>
          </v-col>
        </v-row>
      </v-form>
    </v-card-text>
  </v-card>
</template>

<script>
// import { ref } from '@vue/composition-api'
import axios from 'axios'
import { ref } from '@vue/composition-api'

export default {
  setup() {
    const routes = ref({
      derpature: '',
      arrival: '',
      harga: '',
      type: ''
    }) // Declare user as a ref

    return {
      routes
    }
  },
  data() {
    return {}
  },
  methods: {
    async updateRoute() {
      const access_token = localStorage.getItem('access_token');
      const id = this.$route.params.id;
      try {
        const response = await axios.put(`/api/routes/update/${id}`, this.routes, {
          headers: {
            Authorization: `Bearer ${access_token}`,
          },
        });
        console.log(response.data.data);
        this.$router.push({ name: 'pages-routes' });
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
      .get(`/api/routes/get/${id}`, {
        headers: {
          Authorization: `Bearer ${access_token}`,
        },
      })
      .then((response) => {
        this.routes = response.data.data;
        // console.log(this.user);
      })
      .catch((error) => {
        console.log(error);
      });
  },
}
</script>
