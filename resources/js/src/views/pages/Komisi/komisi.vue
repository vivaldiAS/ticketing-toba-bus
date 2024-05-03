<template>
  <div>
    <h2>Komisi</h2>
    <v-text-field type="date" label="Pilih tanggal" placeholder="Pilih Tanggal" v-model="selectedDate"
      style="width: 300px" solo />
    <template>
      <v-simple-table class="table-primary">
        <template v-slot:default>
          <tbody>
            <tr colspan="3">
              <th class="text-center pt-3">
                <h3>
                  Surat Jalan <br />
                  Bintang Tapanuli
                </h3>
                <p>
                  Kantor pusat : Jl D.I Panjaitan No.24 Tarutung Telp (0633) 21090
                  4902039<br />
                  Tarutung : Telp (0633) 21090. Loket Terminal Telp. (0633) 7325354 <br />
                  Perwakilan Medan : Jl.Sisimangaraja No.27 Km. 6,5 Medan Telp. (061)
                  77823226-76329910
                </p>
              </th>
            </tr>
          </tbody>
        </template>
      </v-simple-table>
    </template>
    <v-data-table :headers="headers" :items="filteredItems">
      <template #item.Tanggal="{ item }">
        {{ formatDate(item.tanggal) }}
      </template>
      <template #item.total="{ item }"> {{ item.total | toRupiah }} </template>
      <template #item.jumlah="{ item }">
        {{ JumlahSetoran(item.total, item.jumlah) | toRupiah }}
      </template>
      <template #item.perusahaan="{ item }">
        {{ perusahaan(item.total, item.jumlah) | toRupiah }}
      </template>
      <template #item.adm="{ item }"> {{ Adm(item.total) | toRupiah }} </template>
      <template #item.Detail="{ item }">
        <router-link :to="{ name: 'detail-komisi', params: { tanggal: item.tanggal } }">
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
        { text: "Total Pemasukan", value: "total" },
        { text: "Total Setoran Admin Loket", value: "jumlah" },
        { text: "Komisi Adm/agen", value: "adm" },
        { text: "Komisi Perusahaan", value: "perusahaan" },
        { text: "Detail", value: "Detail", sortable: false },
      ],
      filteredItemsList: [],
    };
  },
  mounted() {
    const access_token = localStorage.getItem("access_token");
    // console.log(combinedDat);
    let url = '';

    if (this.userRole === "direksi" || this.userRole === "admin_kantor") {
      url = "/api/Keuangan/all/index";
    } else if (this.userRole === "admin_loket") {
      url = "/api/Keuangan/index";
    }

    axios
      .get(url, {
        headers: {
          Authorization: `Bearer ${access_token}`,
        },
      })
      .then((response) => {
        this.ListByDate = response.data.data;
        this.JumlahTanggal = response.data.total;
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
        minimumFractionDigits: 2,
      });
      return formatter.format(value);
    },
  },
  methods: {
    formatDate(date) {
      return moment(date).format("dddd, Do MMMM YYYY");
    },


    JumlahSetoran(total, jlhTgl) {
      return total - ((0.1 * total) + (jlhTgl * 53000 )+ (jlhTgl * 5000));
    },

    perusahaan(total, jlhTgl) {
      return (60 / 100) * ((10 / 100) * total) + (jlhTgl * 53000 )+ (jlhTgl *5000);
    },
    Adm(total) {
      return (40 / 100) * ((10 / 100) * total);
    },
  },
  computed: {
    userRole() {
      return this.$store.state.userRole
    },
    filteredItems() {
      if (!this.selectedDate) {
        return this.combinedData;
      } else {
        return this.combinedData.filter(
          (item) => moment(item.tanggal).format("YYYY-MM-DD") === this.selectedDate
        );
      }
    },
    combinedData() {
      return this.ListByDate.map((item) => {
        const match = this.JumlahTanggal.find((t) => t.tanggal === item.tanggal);
        return {
          ...item,
          jumlah: match ? match.jumlah : 0,
        };
      });
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
<style scope>
.table-primary tr th {
  background-color: var(--v-primary-base);
  color: white;
  width: 300px;
}
</style>
