<template>
  <v-card>
    <v-card-title>
      <v-btn class="mb-3" color="primary" @click="goToAddDefaultSchedule">
        Tambah Jadwal ke Jadwal Mingguan
      </v-btn>
      <v-spacer></v-spacer>
      <!-- <v-text-field v-model="search" append-icon="mdi-magnify" label="Cari" hide-details></v-text-field> -->
      <v-btn class="mb-3" color="primary" @click="addJadwal">
        Tambahkan jadwal
      </v-btn>
    </v-card-title>
    <v-card-text>
      <v-row>
        <v-col v-for="day in daysOfWeek" :key="day" class="day-column">
          <h3>{{ dayLabels[day] }}</h3>
          <div v-for="schedule in filteredSchedules[day]" :key="schedule.nomor_pintu">
            <v-btn :color="getButtonColor(schedule.nomor_pintu)" dark style="margin-top: 1rem;" @click="goToRUDDefaultSchedule(schedule.id)">
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
  // Initialize filtered object with arrays for each day
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
    // Ensure day_of_week is within the expected range or map 0 to Sunday
    let day;
    if (schedule.day_of_week === 0) {
      day = 'sunday';
    } else if (schedule.day_of_week >= 1 && schedule.day_of_week <= 7) {
      day = this.daysOfWeek[schedule.day_of_week - 1];
    } else {
      console.error('Invalid day_of_week:', schedule.day_of_week);
      return; // Skip invalid day_of_week
    }
    filtered[day].push(schedule);
  });

  // Log the filtered schedules before applying the search filter
  console.log('Filtered schedules before search:', filtered);

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
          console.log('Schedules fetched:', this.schedules);
        })
        .catch(error => {
          console.error('Error fetching schedules:', error);
        });
    },
    getButtonColor(value) {
      // Mengembalikan warna tombol sesuai dengan nilai nomor pintu
      return value ? '#3D7C7F' : null;
    },
    goToAddDefaultSchedule() {
      this.$router.push({ name: 'add-default-schedule' });
    },
    addJadwal() {
      const access_token = localStorage.getItem('access_token');
      axios.post('http://127.0.0.1:8000/api/DefaultSchedulesToSchedules', {}, {
        headers: {
          Authorization: `Bearer ${access_token}`
        }
      })
        .then(response => {
          console.log(response.data.message); // Optional: Handle the response message
          this.$router.push({ name: 'dashboard' });
        })
        .catch(error => {
          console.error('Error adding jadwal:', error);
        });
    },
    goToRUDDefaultSchedule(id) {
      this.$router.push({ name: 'rud-default-schedule', params: { id: id } });
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
