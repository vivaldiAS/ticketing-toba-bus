<template>
  <div>
    <h2>Catatan Keuangan</h2>
    <!-- <v-text-field label="Pilih tanggal" placeholder="Pilih Tanggal" v-model="selectedDate" style="width: 300px;" solo /> -->
    <h5 align="right" class="mb-2">Tanggal : {{ formatDate(tanggal) }}</h5>
    <v-data-table :headers="headers" :items="ListByDate">
      <template #item.tanggal="{ item }">
        {{ formatDate(item.tanggal) }}
      </template>
      <template #item.Detail="{ item }">
        <router-link
          :to="{ name: 'detail-keuangan-by-penumpang', params: { id: item.schedule_id } }"
          >Detail</router-link
        >
      </template>
      <template #item.total="{ item }">
        {{ item.total | toRupiah }}
      </template>
      <template v-slot:body.append>
        <tr>
          <td>
            <h2>Total</h2>
          </td>
          <td colspan="8" style="text-align: right">
            <h3 style="color: red">{{ totalSemua | toRupiah }}</h3>
          </td>
        </tr>
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
      tanggal: this.$route.params.tanggal,
      ListByDate: [],
      headers: [
        {
          text: "Tanggal",
          align: "start",
          value: "tanggal",
        },
        { text: "Nomor Polisi", value: "police_number" },
        { text: "Nomor Pintu", value: "nomor_pintu" },
        { text: "Kedatangan", value: "arrival" },
        { text: "Keberangkatan", value: "derpature" },
        { text: "Tipe", value: "type" },
        { text: "Nama Supir", value: "name" },
        { text: "Detail", value: "Detail", sortable: false },
        { text: "Total", value: "total" },
      ],
      selectedDate: "",
    };
  },
  mounted() {
    const access_token = localStorage.getItem("access_token");

    let url = '';

    if (this.userRole === "direksi" || this.userRole === "admin_kantor") {
      url = `/api/Detail-keuangan-Bydate/all/${this.tanggal}`;
    } else if (this.userRole === "admin_loket") {
      url = `/api/Detail-keuangan-Bydate/${this.tanggal}`;
    }

    axios
      .get(url, {
        headers: {
          Authorization: `Bearer ${access_token}`,
        },
      })
      .then((response) => {
        this.ListByDate = response.data.data;
        this.ListByDate.forEach((item) => {
          item.total = item.jumlah_booking * item.harga;
        });
      })
      .catch((error) => {
        console.log(error);
      });
  },
  methods: {
    formatDate(date, format = "dddd, Do MMMM YYYY") {
      return moment(date).format(format);
    },
  },
  filters: {
    toRupiah(value) {
      const formatter = new Intl.NumberFormat("id-ID", {
        style: "currency",
        currency: "IDR",
        minimumFractionDigits: 0,
      });
      return formatter.format(value);
    },
  },
  computed: {
    userRole() {
      return this.$store.state.userRole
    },
    filteredList() {
      return this.ListByDate.filter((item) => {
        return (
          moment(item.tanggal).format("YYYY-MM-DD") ===
          moment(this.selectedDate).format("YYYY-MM-DD")
        );
      });
    },
    totalSemua() {
      return this.ListByDate.reduce((acc, item) => {
        return acc + item.total;
      }, 0);
    },
  },
};
</script>
