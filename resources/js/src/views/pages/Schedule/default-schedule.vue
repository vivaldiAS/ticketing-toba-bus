<template>
  <v-card>
    <v-card-title>
      <v-btn class="mb-3" color="primary" @click="goToAddDefaultSchedule">
        Tambah Jadwal ke Jadwal Mingguan
      </v-btn>
      <v-spacer></v-spacer>
      <v-text-field v-model="search" append-icon="mdi-magnify" label="Cari" hide-details></v-text-field>
    </v-card-title>
    <v-card-text>
      <v-row>
        <v-col v-for="day in daysOfWeek" :key="day" class="day-column">
          <h3>{{ dayLabels[day] }}</h3>
          <div v-for="schedule in filteredSchedules[day]" :key="schedule.nomor_pintu">
            <v-btn :color="getButtonColor(schedule.nomor_pintu)" dark style="margin-top: 1rem;">
              {{ schedule.nomor_pintu }}
            </v-btn>
          </div>
        </v-col>
      </v-row>
    </v-card-text>
  </v-card>
</template>

<script>
import { mdiPencil, mdiMagnify } from '@mdi/js';
import axios from 'axios';

export default {
  data() {
    return {
      search: '',
      daysOfWeek: [
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
        'sunday'
      ],
      dayLabels: {
        monday: 'Senin',
        tuesday: 'Selasa',
        wednesday: 'Rabu',
        thursday: 'Kamis',
        friday: 'Jumat',
        saturday: 'Sabtu',
        sunday: 'Minggu'
      },
      schedules: [],
      icons: {
        mdiPencil,
        mdiMagnify
      },
      access_token: ''
    };
  },
  computed: {
    filteredSchedules() {
      const filtered = {
        monday: [],
        tuesday: [],
        wednesday: [],
        thursday: [],
        friday: [],
        saturday: [],
        sunday: []
      };

      this.schedules.forEach(schedule => {
        const day = this.daysOfWeek[schedule.day_of_week - 1];
        filtered[day].push(schedule);
      });

      if (this.search) {
        for (const day in filtered) {
          filtered[day] = filtered[day].filter(schedule =>
            schedule.nomor_pintu.toLowerCase().includes(this.search.toLowerCase())
          );
        }
      }

      return filtered;
    }
  },
  methods: {
    fetchSchedules() {
      const access_token = localStorage.getItem('access_token');
      axios.get('/api/default-schedules', {
        headers: {
          Authorization: `Bearer ${access_token}`
        }
      })
        .then(response => {
          this.schedules = response.data;
          this.access_token = access_token;
        })
        .catch(error => {
          console.error(error);
        });
    },
    getButtonColor(value) {
      // Mengembalikan warna tombol sesuai dengan nilai nomor pintu
      return value ? '#3D7C7F' : null;
    },
    goToAddDefaultSchedule() {
      this.$router.push({ name: 'add-default-schedule' });
    }
  },
  mounted() {
    this.fetchSchedules();
  }
};
</script>

<style scoped>
.v-card-text {
  padding: 16px;
}

.day-column {
  display: flex;
  flex-direction: column;
  align-items: center; /* Center the column content horizontally */
  margin-bottom: 16px;
}

.day-column h3 {
  margin-bottom: 8px;
  text-align: center; /* Center the text horizontally */
}
</style>
