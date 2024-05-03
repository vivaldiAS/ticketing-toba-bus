<template>
  <v-container class="grey text-center">
    <v-card class="mb-3">
      <v-row>
        <v-col cols="4" md="4" sm="4">
          <div class="pa-2" tile>
            <h3>Seat</h3>
            <h5>{{ selectedChair }}</h5>
          </div>
        </v-col>
        <v-col cols="4" md="4" sm="4">
          <div class="pa-2">
            <v-btn
              class="mx-2"
              fab
              dark
              color="secondary"
              @click="selectSeat(selectedChair)"
            >
              <v-icon dark>
                {{ icons.mdiChevronRight }}
              </v-icon>
            </v-btn>
          </div>
        </v-col>
        <v-col cols="4" md="4" sm="4">
          <div class="pa-2" tile>
            <h3>Harga</h3>
            <h5>{{ toRupiah(item.harga) }}</h5>
          </div>
        </v-col>
        <v-col cols="6" md="6" sm="6">
          <div class="pa-2" tile>
            <h3>Menaikkan</h3>
            <h5>{{ item.derpature }}</h5>
          </div>
        </v-col>
        <v-col cols="6" md="6" sm="6">
          <div class="pa-2" tile>
            <h3>Menurunkan</h3>
            <h5>{{ item.arrival }}</h5>
          </div>
        </v-col>
      </v-row>
    </v-card>
  </v-container>
</template>

<script>
export default {
  props: {
    item: {
      type: Object,
      required: true,
    },
    selectedChair: {
      type: Number,
      required: true,
    },
    icons: {
      type: Object,
      required: true,
    },
    toRupiah: {
      type: Function,
      required: true,
    },
    routeName: {
      type: String,
      required: true,
    },
  },
  methods: {
    selectSeat(seat) {
      // set tempat duduk yang dipilih ke state Vuex
      this.$store.dispatch("setSelectedSeat", seat);
      this.$router.push(this.routeName);
    },
  },
  mounted() {},
};
</script>

<style scoped>
/* Kustomisasi gaya kartu pemesanan di sini (jika diperlukan) */
</style>
