<template>
    <div>
      <h2>Informasi Komisi</h2>
      <v-simple-table class="mt-4 table-primary">
        <template v-slot:default>
          <thead>
            <tr>
              <th>Persentase Komisi</th>
              <th>Setoran Kantor</th>
              <th>Administrasi</th>
              <th>Aksi</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>
                <div v-if="isEditing">
                  <input v-model="editedData.persentase_komisi" type="number" />
                </div>
                <div v-else>{{ persentaseKomisi }}%</div>
              </td>
              <td>
                <div v-if="isEditing">
                  <input v-model="editedData.setoran_kantor" type="number" />
                </div>
                <div v-else>{{ setoranKantor | toRupiah }}</div>
              </td>
              <td>
                <div v-if="isEditing">
                  <input v-model="editedData.administrasi" type="number" />
                </div>
                <div v-else>{{ administrasi | toRupiah }}</div>
              </td>
              <td>
                <v-btn v-if="isEditing" small color="primary" @click="saveEdit">
                <v-icon color="white">{{ icons.mdiContentSave }}</v-icon>
                </v-btn>
                <v-btn v-if="isEditing" small color="red" @click="cancelEdit">
                <v-icon color="white">{{ icons.mdiClose }}</v-icon>
                </v-btn>
                <v-btn v-else small color="primary" @click="editFields">
                <v-icon color="white">{{ icons.mdiPencil }}</v-icon>
                </v-btn>
              </td>
            </tr>
          </tbody>
        </template>
      </v-simple-table>
    </div>
  </template>
  
  <script>
  import axios from "axios";
  import {
  mdiPencil,
  mdiContentSave,
  mdiClose
} from '@mdi/js';
  
  export default {
    setup() {
    return {
      icons: {
        mdiPencil,
        mdiContentSave,
        mdiClose
      },
    };
  },
    data() {
      return {
        id: null,
        persentaseKomisi: 0,
        setoranKantor: 0,
        administrasi: 0,
        brandId: 0,
        isEditing: false,
        editedData: {
          id: null,
          persentase_komisi: 0,
          setoran_kantor: 0,
          administrasi: 0,
          brand_id: 0,
        },
      };
    },
    mounted() {
      const access_token = localStorage.getItem("access_token");
      axios
        .get('/api/komisi', {
          headers: {
            Authorization: `Bearer ${access_token}`,
          },
        })
        .then((response) => {
          const komisiData = response.data.data[0];
          this.id = komisiData.id;
          this.persentaseKomisi = komisiData.persentase_komisi;
          this.setoranKantor = komisiData.setoran_kantor;
          this.administrasi = komisiData.administrasi;
          this.brandId = komisiData.brand_id;
  
          this.editedData = { ...komisiData };
        })
        .catch((error) => {
          console.log(error);
        });
    },
    methods: {
      editFields() {
        this.isEditing = true;
      },
      saveEdit() {
        const access_token = localStorage.getItem("access_token");
        axios
          .put('/api/komisi', this.editedData, {
            headers: {
              Authorization: `Bearer ${access_token}`,
            },
          })
          .then((response) => {
            this.persentaseKomisi = this.editedData.persentase_komisi;
            this.setoranKantor = this.editedData.setoran_kantor;
            this.administrasi = this.editedData.administrasi;
            this.brandId = this.editedData.brand_id;
            this.isEditing = false;
            console.log(response.data);
          })
          .catch((error) => {
            console.log(error);
          });
      },
      cancelEdit() {
        this.editedData = {
          id: this.id,
          persentase_komisi: this.persentaseKomisi,
          setoran_kantor: this.setoranKantor,
          administrasi: this.administrasi,
          brand_id: this.brandId,
        };
        this.isEditing = false;
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
  };
  </script>
  
  <style scoped>
  .table-primary {
    width: 100%;
    border-collapse: collapse;
  }
  .table-primary th,
  .table-primary td {
    padding: 12px;
    border: 1px solid #ccc;
  }
  .table-primary th {
    background-color: var(--v-primary-base);
    color: white;
  }
  .btn {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    padding: 8px 12px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }
  .btn-primary {
    background-color: var(--v-primary-base);
    color: white;
  }
  .btn-danger {
    background-color: red;
    color: white;
  }
  </style>
  