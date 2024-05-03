<template>
  <div>
    <h2>Catatan Keuangan</h2>
    <v-text-field
      type="date"
      label="Pilih tanggal"
      placeholder="Pilih Tanggal"
      v-model="selectedDate"
      style="width: 300px"
      solo
    />
    <v-data-table :headers="headers" :items="filteredItems">
      <template #item.Tanggal="{ item }">
        {{ formatDate(item.tanggal) }}
      </template>
      <template #item.total="{ item }"> {{ item.total | toRupiah }} </template>
      <template #item.Detail="{ item }">
        <router-link
          :to="{ name: 'detail-catatan-keuangan', params: { tanggal: item.tanggal } }"
        >
          Detail
        </router-link>
      </template>
    </v-data-table>
  </div>
</template>
<script>
import moment from "moment";
import axios from "axios";
import "moment/locale/id";

export default {
  data() {
    return {
      selectedDate: null,
      ListByDate: [],
      search: "",
      headers: [
        {
          text: "Tanggal",
          align: "start",
          value: "Tanggal",
        },
        { text: "Total", value: "total" },
        { text: "Detail", value: "Detail", sortable: false },
      ],
      filteredItemsList: [],
    };
  },
  mounted() {
    const access_token = localStorage.getItem("access_token");

    let url = '';

    if (this.userRole === "direksi" || this.userRole === "admin_kantor") {
      url = "/api/Keuangan/all/index";
    } else if (this.userRole === "admin_loket") {
      url = "/api/Keuangan/index";
    }

    axios
      .get(url,{
        headers: {
          Authorization: `Bearer ${access_token}`,
        },
      })
      .then((response) => {
        this.ListByDate = response.data.data;
      })
      .catch((error) => {
        console.log(error);
      });
  },
  methods: {
    formatDate(date) {
      return moment(date).format("dddd, Do MMMM YYYY");
    },
  },
  filters: {
    toRupiah(value) {
      const formatter = new Intl.NumberFormat("id-ID", {
        style: "currency",
        currency: "IDR",
        minimumFractionDigits: 2,
      });
      return formatter.format(value);
    },
  },
  computed: {
    userRole() {
      return this.$store.state.userRole
    },
    filteredItems() {
      if (!this.selectedDate) {
        return this.ListByDate;
      } else {
        return this.ListByDate.filter(
          (item) => moment(item.tanggal).format("YYYY-MM-DD") === this.selectedDate
        );
      }
    },
  },
  watch: {
    selectedDate(newVal, oldVal) {
      if (!newVal) {
        this.filteredItemsList = this.ListByDate;
      } else {
        this.filteredItemsList = this.ListByDate.filter(
          (item) => moment(item.tanggal).format("YYYY-MM-DD") === newVal
        );
      }
    },
  },
};
</script>
