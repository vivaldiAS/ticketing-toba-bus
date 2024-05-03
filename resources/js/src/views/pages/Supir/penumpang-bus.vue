<template>
  <div>
    <h3>Detail Penumpang</h3>
    <div class="d-flex justify-content-between">
      <div>
        <h5>Status bus:</h5>
        <v-btn
          v-if="bus.status == 'in_progress'"
          rounded
          small
          color="warning"
          class="my-2 status text-capitalize"
          style="color: white; font-weight: bold"
          @click="updateBusStatus(bus.schedules_id)"
        >
          Sedang berjalan
        </v-btn>
        <v-btn
          v-if="bus.status == 'complete'"
          rounded
          small
          color="primary"
          class="my-2 status text-capitalize"
          style="color: white; font-weight: bold"
          @click="updateBusStatus(bus.schedules_id)"
        >
          Perjalanan Selesai
        </v-btn>
        <v-btn
          v-if="bus.status == 'not_started'"
          rounded
          small
          color="presecondary"
          class="my-2 status text-capitalize"
          style="color: white; font-weight: bold"
          @click="updateBusStatus(bus.schedules_id)"
        >
          Belum Berangkat
        </v-btn>
      </div>
      <div class="ml-auto p-2" align="right">
        <p>{{ bus.derpature }} - {{ bus.arrival }}</p>
        <p>{{ formatDate(bus.tanggal) }}</p>
      </div>
    </div>
    <h5>Total Penumpang : {{ total_penumpang }}</h5>
    <v-data-table
      :headers="headers"
      :items="penumpang"
      item-key="name"
      class="elevation-1"
    >
    </v-data-table>
  </div>
</template>

<script>
import axios from "axios";
import moment from "moment";
import "moment/locale/id";
import { io } from "socket.io-client";

export default {
  setup() {
    return {
      headers: [
        { text: "Nama", value: "name" },
        { text: "Bangku", value: "num_seats" },
        { text: "No Handphone", value: "number_phone" },
        { text: "Penjemputan", value: "alamatJemput" },
        { text: "Metode", value: "method" },
        { text: "Harga", value: "harga" },
      ],
    };
  },

  data() {
    return {
      id_bus: this.$route.params.id,
      penumpang: [],
      bus: {},
      total_penumpang: 0,
      StatusBus: "",
      center: { lat: -33.9, lng: 151.1 },
      centerOptions: {},
      watcher: null,
      driver_id_real: null,
    };
  },

  methods: {
    formatDate(date) {
      moment.locale("id");
      return moment(date).format("dddd, Do MMMM YYYY, hh:mm:ss");
    },

    sentDataToSocket() {
      // Only sent the location if bus in progress action
      // Format action must mapping
      // {id_bus}-{Scheduler}
      console.log(this.StatusBus);
      if (this.StatusBus === "in_progress" && this.watcher === null) {
        navigator.geolocation.getCurrentPosition(
          (position) => {
            this.center = {
              lat: position.coords.latitude,
              lng: position.coords.longitude,
            };
            this.centerOptions = {
              position: this.center,
              label: "Current Location.",
              title: "ME",
            };
          },
          (err) => {
            console.log(`error : ${err.message.toString()}`);
          }
        );

        this.socket = io("wss://socket.eticketingkbt.online", {
          query: `id=${this.driver_id_real}`,
        });

        this.socket.on("side-hello", (data) => {
          console.log("Connected");
          this.socket.on("RESENT_CURRENT_LOCATION", (data) => {
            if (this.center !== null) {
              this.socket.emit("server-sent-location", {
                center: this.center,
                schedule_id: this.bus.schedules_id,
              });
            }
          });
        });
        console.log(this.bus);

        // if (this.StatusBus === 'in_progress') {
        this.watcher = navigator.geolocation.watchPosition(
          (position) => {
            console.log(
              `Watch position with coordinate late: ${position.coords.latitude} and long: ${position.coords.longitude}`
            );
            this.center = {
              lat: position.coords.latitude,
              lng: position.coords.longitude,
            };
            console.log({
              center: this.center,
              schedule_id: this.bus.schedules_id,
            });
            this.socket.emit("server-sent-location", {
              center: this.center,
              schedule_id: this.bus.schedules_id,
            });
          },
          (err) => {
            console.log(`Failed to watch location ${err}`);
          }
        );
      } else if (this.StatusBus == "complete") {
        if (this.watcher !== null) {
          console.log(`unmounted the watcher`);
          navigator.geolocation.clearWatch(this.watcher);
        }
      }
    },
    async updateBusStatus(schedule_id) {
      const access_token = localStorage.getItem("access_token");
      if (this.StatusBus !== "complete" || true) {
        try {
          const response = await axios.put(
            `/api/update-status/${schedule_id}`,
            {},
            {
              headers: {
                Authorization: `Bearer ${access_token}`,
              },
            }
          );
          console.log(response.data);
          // update status bus pada halaman
          this.bus.status = response.data.data.status;
          this.StatusBus = response.data.data.status;

          this.sentDataToSocket();
        } catch (error) {
          console.log(error);
        }
      }
    },
  },

  mounted() {
    const access_token = localStorage.getItem("access_token");
    axios
      .get(`/api/bookings/show/schedules/${this.id_bus}`, {
        headers: {
          Authorization: `Bearer ${access_token}`,
        },
      })
      .then((response) => {
        this.penumpang = response.data.data;
        console.log(this.penumpang);
        this.bus = response.data.data[0];
        this.StatusBus = response.data.data[0].status;
        this.total_penumpang = response.data.total;
        axios
          .get(`/api/user/profile`, {
            headers: {
              Authorization: `Bearer ${access_token}`,
            },
          })
          .then((res) => {
            this.driver_id_real = res.data.id;
            this.sentDataToSocket();
          });
      })
      .catch((error) => {
        console.log(error);
      });
  },
  created() {
    // }
  },
  unmounted() {
    if (this.watcher !== null) {
      console.log(`unmounted the watcher`);
      navigator.geolocation.clearWatch(this.watcher);
    }
  },
};
</script>
