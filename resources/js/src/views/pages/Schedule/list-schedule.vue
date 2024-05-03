<template>
  <v-card>
    <v-card-title>
      <v-btn class="mb-3" :to="{ name: 'pages-add-schedule' }" color="primary">
        Schedule Baru
      </v-btn>
      <v-spacer></v-spacer>
      <v-text-field
        v-model="search"
        append-icon="mdi-magnify"
        label="Cari"
        hide-details
      ></v-text-field>
    </v-card-title>
    <v-data-table :headers="headers" :items="schedule" :search="search">
      <template #item.edit="{ item }">
        <v-btn
          small
          color="primary"
          :to="{ name: 'pages-edit-schedule', params: { id: item.schedule_id } }"
          ><v-icon center>{{ icons.mdiPencil }}</v-icon></v-btn
        >
      </template>
      <template v-slot:item.status="{ item }">
        <v-chip v-if="item.status == 'not_started'" color="error" x-small>
          Belum Berangkat
        </v-chip>
        <v-chip v-else-if="item.status == 'in_progress'" color="secondary" x-small>
          Dalam Perjalanan
        </v-chip>
        <v-chip v-else color="info" x-small> Selesai </v-chip>
      </template>
    </v-data-table>
  </v-card>
</template>

<script>
import axios from "axios";
import moment from "moment";
import "moment/locale/id";
import { mdiPencil, mdiTrashCanOutline } from "@mdi/js";

export default {
  setup() {
    return {
      buss: [],
      icons: {
        mdiPencil,
        mdiTrashCanOutline,
      },
    };
  },
  data() {
    return {
      search: "",
      headers: [
        {
          text: "Nomor pintu",
          align: "",
          sortable: false,
          value: "nomor_pintu",
        },
        { text: "Nomor Polisi", value: "police_number" },
        { text: "Sopir", value: "name" },
        { text: "Asal", value: "derpature" },
        { text: "Tujuan", value: "arrival" },
        { text: "Loket", value: "loket" },
        { text: "Tanggal", value: "tanggal" },
        { text: "Harga", value: "harga" },
        { text: "Status", value: "status" },
        { text: "Edit", value: "edit", align: "center", sortable: false },
      ],
      schedule: [],
    };
  },
  methods: {
    formatDate(date) {
      // moment.locale('id');
      return moment(date).format("dddd, Do MMMM YYYY");
    },
    getColor(status) {
      if (status == "not_started") return "red";
      else if (status == "in_progress") return "orange";
      else return "green";
    },
  },
  mounted() {
    const access_token = localStorage.getItem("access_token");

    axios
      .get("/api/schedule/admin/show/all", {
        headers: {
          Authorization: `Bearer ${access_token}`,
        },
      })
      .then((response) => {
        function formatDateToYMDHIS(date) {
          const year = date.getFullYear();
          const month = String(date.getMonth() + 1).padStart(2, "0");
          const day = String(date.getDate()).padStart(2, "0");
          const hours = String(date.getHours()).padStart(2, "0");
          const minutes = String(date.getMinutes()).padStart(2, "0");
          const seconds = String(date.getSeconds()).padStart(2, "0");

          return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
        }

        const schedules = response.data.data;

        schedules.forEach((schedule) => {
          // current dat
          const currentDate = new Date();
          // add 1 day
          const scheduleDate = new Date(schedule.tanggal);
          scheduleDate.setHours(scheduleDate.getHours() + 24);
          // update format
          const scheduledateUp = formatDateToYMDHIS(scheduleDate);

          const scheduledateUpObj = new Date(scheduledateUp);

          if (scheduledateUpObj < currentDate) {
            schedule.status = "complete"
            axios
              .put(
                `/api/status/update/auto/${schedule.schedule_id}`,
                {
                  status: "complete",
                },
                {
                  headers: {
                    Authorization: `Bearer ${access_token}`,
                  },
                }
              )
              .then((response) => {
                console.log(`Schedule with id=${schedule.schedule_id} marked as complete`);
              })
              .catch((error) => {
                console.log("Error updating schedule status:", error);
              });
          }
        });

        // Now, the schedules array will have the "status" property updated for each schedule
        this.schedule = schedules;
      })
      .catch((error) => {
        console.log(error);
      });
  },
};
</script>
