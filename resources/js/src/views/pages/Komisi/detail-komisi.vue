<template>
  <div>
    <h2>Detail Komisi</h2>
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
      <template #item.total="{ item }"> {{ item.total | toRupiah }} </template>
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
    <template>
      <v-simple-table class="mt-4 table-primary">
        <template v-slot:default>
          <thead>
            <tr></tr>
          </thead>
          <tbody>
            <tr>
              <td class="judul">Komisi</td>
              <td>10% * {{ totalSemua | toRupiah }}</td>
              <td>{{ komisi | toRupiah }}</td>
            </tr>
            <tr>
              <td class="judul">Kantor</td>
              <td>{{ jumlahSchedule }} * Rp.53.000</td>
              <td>{{ kantor | toRupiah }}</td>
            </tr>
            <tr>
              <td class="judul">Administrasi</td>
              <td>{{ jumlahSchedule }} * Rp.5.000</td>
              <td>{{ admin | toRupiah }}</td>
            </tr>
            <tr>
              <td>Total Setoran admin loket</td>
              <td></td>
              <td>
                <h4>{{ (totalSemua - (komisi + kantor + admin)) | toRupiah }}</h4>
              </td>
            </tr>
          </tbody>
        </template>
      </v-simple-table>
      <h4 class="mt-4">Pembagian Komisi</h4>
      <v-simple-table class="mt-4 table-primary">
        <template v-slot:default>
          <thead>
            <tr></tr>
          </thead>
          <tbody>
            <tr>
              <td class="judul">Perusahaan</td>
              <td>
                (60% * {{ komisi | toRupiah }}) + {{ kantor | toRupiah }} +
                {{ admin | toRupiah }}
              </td>
              <td>{{ perusahaan | toRupiah }}</td>
            </tr>
            <tr>
              <td class="judul">Admin/Agen</td>
              <td>40% * {{ komisi | toRupiah }}</td>
              <td>{{ AdminAgen | toRupiah }}</td>
            </tr>
          </tbody>
        </template>
      </v-simple-table>
    </template>
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
      jumlahSchedule: "",
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
        { text: "Loket", value: "nama_loket" },
        { text: "Detail", value: "Detail", sortable: false },
        { text: "Total", value: "total" },
      ],
      selectedDate: "",
    };
  },
  mounted() {
    const access_token = localStorage.getItem("access_token");

    let url = "";

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
        this.jumlahSchedule = this.ListByDate.length;
        this.ListByDate.forEach((item) => {
          item.total = item.jumlah_booking * item.harga;
        });
      })
      .catch((error) => {
        console.log(error);
      });
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
  methods: {
    formatDate(date, format = "dddd, Do MMMM YYYY") {
      return moment(date).format(format);
    },
  },
  computed: {
    userRole() {
      return this.$store.state.userRole;
    },
    komisi() {
      let komisi = 0;
      komisi = (10 / 100) * this.totalSemua;
      return komisi;
    },
    kantor() {
      let kantor = 0;
      kantor = this.jumlahSchedule * 53000;
      return kantor;
    },
    admin() {
      let admin = 0;
      admin = this.jumlahSchedule * 5000;
      return admin;
    },
    // perusahaan() {
    //   let perusahaan = 0;
    //   if (this.ListByDate.nama_loket == "Loket Medan") {
    //     perusahaan = (40 / 100) * +this.komisi + +this.kantor + +this.admin;
    //   } else {
    //     perusahaan = (60 / 100) * +this.komisi + +this.kantor + +this.admin;
    //   }
    //   return perusahaan;
    // },
    // AdminAgen() {
    //   let AdminAgen = 0;
    //   if (this.ListByDate.nama_loket == "Loket Medan") {
    //     AdminAgen = (60 / 100) * +this.komisi;
    //   } else {
    //     AdminAgen = (40 / 100) * +this.komisi;
    //   }
    //   return AdminAgen;
    // },
    perusahaan() {
      let perusahaan = 0;
      perusahaan = (60 / 100) * +this.komisi + +this.kantor + +this.admin;
      return perusahaan;
    },
    AdminAgen() {
      let AdminAgen = 0;
      AdminAgen = (40 / 100) * +this.komisi;
      return AdminAgen;
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
<style scope>
.table-primary tr .judul {
  background-color: var(--v-primary-base);
  color: white;
  width: 300px;
}
</style>
