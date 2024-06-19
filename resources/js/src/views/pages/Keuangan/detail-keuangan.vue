<template>
  <div>
    <h2>Catatan Keuangan</h2>
    <!-- <v-text-field label="Pilih tanggal" placeholder="Pilih Tanggal" v-model="selectedDate" solo /> -->
    <v-data-table :headers="headers" :items="ListPenumpang">
      <template #item.harga="{ item }">
        {{ item.harga | toRupiah }}
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
    <template>
      <v-simple-table class="mt-4 table-primary">
        <template v-slot:default>
          <thead>
            <tr></tr>
          </thead>
          <tbody>
            <tr>
              <td class="judul">Komisi</td>
              <td>{{ persentaseKomisi }}% * {{ totalSemua | toRupiah }}</td>
              <td>{{ komisi | toRupiah }}</td>
            </tr>
            <tr>
              <td class="judul">Kantor</td>
              <td>1 * {{ setoranKantor | toRupiah }}</td>
              <td>{{ kantor | toRupiah }}</td>
            </tr>
            <tr>
              <td class="judul">Administrasi</td>
              <td>1 * {{ administrasi | toRupiah }}</td>
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
      schedule_id: this.$route.params.id,
      ListPenumpang: [],
      harga: 0,
      headers: [
        {
          text: "Nama",
          align: "start",
          value: "name",
        },
        { text: "Jumlah Bangku", value: "num_seats" },
        { text: "Nomor Bangku", value: "seat_number" },
        { text: "No Telepon", value: "number_phone" },
        { text: "Penjumputan", value: "alamatJemput" },
        { text: "Metode", value: "method" },
        { text: "Harga", value: "harga" },
      ],
      selectedDate: "",
      persentaseKomisi: 0,
      setoranKantor: 0,
      administrasi: 0,
    };
  },
  mounted() {
    const access_token = localStorage.getItem("access_token");
    let url = '';

    if (this.userRole === "direksi" || this.userRole === "admin_kantor") {
      url = `/api/Detail-keuangan-ByPassenger/all/${this.schedule_id}`;
    } else if (this.userRole === "admin_loket") {
      url = `/api/Detail-keuangan-ByPassenger/${this.schedule_id}`;
    }

    axios
      .get(url, {
        headers: {
          Authorization: `Bearer ${access_token}`,
        },
      })
      .then((response) => {
        this.ListPenumpang = response.data.data;
      })
      .catch((error) => {
        console.log(error);
      });

    axios
      .get(`/api/komisi/${this.schedule_id}`, {
        headers: {
          Authorization: `Bearer ${access_token}`,
        },
      })
      .then((response) => {
        const komisiData = response.data.data;
        this.persentaseKomisi = komisiData.persentase_komisi;
        this.setoranKantor = komisiData.setoran_kantor;
        this.administrasi = komisiData.administrasi;
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
    totalSemua() {
      let total = 0;
      this.ListPenumpang.forEach(item => {
        total += parseInt(item.harga);
      });
      return total;
    },
    komisi() {
      return (this.persentaseKomisi / 100) * this.totalSemua;
    },
    kantor() {
      return this.setoranKantor;
    },
    admin() {
      return this.administrasi;
    },
    filteredList() {
      return this.ListByDate.filter((item) => {
        return (
          moment(item.tanggal).format("YYYY-MM-DD") ===
          moment(this.selectedDate).format("YYYY-MM-DD")
        );
      });
    },
  },
};
</script>

<style scoped>
.table-primary tr .judul {
  background-color: var(--v-primary-base);
  color: white;
  width: 300px;
}
</style>
